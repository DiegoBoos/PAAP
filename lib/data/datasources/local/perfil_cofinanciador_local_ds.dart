import 'package:sqflite/sqflite.dart';

import '../../db/db_config.dart';
import '../../../domain/entities/perfil_cofinanciador_entity.dart';
import '../../models/perfil_cofinanciador_model.dart';

abstract class PerfilCofinanciadorLocalDataSource {
  Future<List<PerfilCofinanciadorModel>> getPerfilCofinanciadoresDB(
      String perfilId);
  Future<List<PerfilCofinanciadorModel>>
      getPerfilesCofinanciadoresProduccionDB();
  Future<PerfilCofinanciadorModel?> getPerfilCofinanciadorDB(
      String perfilId, String cofinanciadorId);
  Future<int> savePerfilCofinanciadores(
      List<PerfilCofinanciadorEntity> perfilesCofinanciadoresEntity);
  Future<int> savePerfilCofinanciadorDB(
      PerfilCofinanciadorEntity perfilCofinanciadorEntity);
  Future<int> updatePerfilesCofinanciadoresProduccionDB(
      List<PerfilCofinanciadorEntity> perfilesCofinanciadoresEntity);
}

class PerfilCofinanciadorLocalDataSourceImpl
    implements PerfilCofinanciadorLocalDataSource {
  static createPerfilCofinanciadorTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS PerfilCofinanciador (
        PerfilId	TEXT NOT NULL,
        CofinanciadorId	TEXT NOT NULL,zz
        Monto	TEXT,
        Participacion	TEXT,
        RecordStatus	TEXT,
        FOREIGN KEY(PerfilId) REFERENCES Perfil(ID),
        FOREIGN KEY(CofinanciadorId) REFERENCES Cofinanciador(CofinanciadorId)
      )
    ''');
  }

  @override
  Future<List<PerfilCofinanciadorModel>> getPerfilCofinanciadoresDB(
      String perfilId) async {
    final db = await DBConfig.database;

    String sql = '''
      Select 
      Cofinanciador.ID as CofinanciadorId,
      Cofinanciador.Nombre as Nombre,
      Cofinanciador.Teléfono_x0020_Móvil as TelefonoMovil,
      Cofinanciador.Correo as Correo,
      Cofinanciador.Municipio as Municipio,
      PerfilCofinanciador.Monto as Monto,
      CASE  
      WHEN Cast(PerfilCofinanciador.Monto as decimal) = 0  
      THEN 0 
      ELSE ((Cast(PerfilCofinanciador.Monto as decimal)*100)/Cast(Perfil.ValorTotalProyecto as decimal)) 
      END as Participacion
      From  Cofinanciador
      INNER JOIN PerfilCofinanciador  ON Cofinanciador.ID = PerfilCofinanciador.CofinanciadorId
      INNER JOIN Perfil  ON PerfilCofinanciador.PerfilId = Perfil.ID
      where PerfilCofinanciador.PerfilId = $perfilId
      UNION ALL
      Select 
      '' as CofinanciadorId,
      '' as Nombre,
      '' as TelefonoMovil,
      'TOTAL' as Correo,
      '' as Municipio,
      SUM (Cast(PerfilCofinanciador.Monto as decimal)) + MAX( Cast(Perfil.IncentivoModular as decimal)) as Monto,
      CASE  
      WHEN (SUM (Cast(PerfilCofinanciador.Monto as decimal)) + MAX(Cast(Perfil.IncentivoModular as decimal))) = 0  
      THEN 0 
      ELSE (((SUM(Cast(PerfilCofinanciador.Monto as decimal))  + MAX (Cast(Perfil.IncentivoModular as decimal)))*100)/Cast(Perfil.ValorTotalProyecto as decimal)) 
      END as Participacion
      FROM Perfil
      INNER JOIN PerfilCofinanciador ON Perfil.ID = PerfilCofinanciador.PerfilId
      where PerfilCofinanciador.PerfilId = $perfilId
      GROUP BY Perfil.ID, Perfil.IncentivoModular, Perfil.ValorTotalProyecto
      ''';

    final res = await db.rawQuery(sql);

    final cofinanciadoresDB = List<PerfilCofinanciadorModel>.from(
        res.map((m) => PerfilCofinanciadorModel.fromJson(m))).toList();

    return cofinanciadoresDB;
  }

  @override
  Future<PerfilCofinanciadorModel?> getPerfilCofinanciadorDB(
      String perfilId, String cofinanciadorId) async {
    final db = await DBConfig.database;
    final res = await db.query('PerfilCofinanciador',
        where: 'PerfilId = ? AND CofinanciadorId = ?',
        whereArgs: [perfilId, cofinanciadorId]);

    if (res.isEmpty) return null;

    final perfilCofinanciadorMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilCofinanciadorModel =
        PerfilCofinanciadorModel.fromJson(perfilCofinanciadorMap);

    return perfilCofinanciadorModel;
  }

  @override
  Future<int> savePerfilCofinanciadores(
      List<PerfilCofinanciadorEntity> perfilesCofinanciadoresEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilCofinanciador');

    for (var perfilCofinanciador in perfilesCofinanciadoresEntity) {
      perfilCofinanciador.recordStatus = 'R';
      batch.insert('PerfilCofinanciador', perfilCofinanciador.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> savePerfilCofinanciadorDB(
      PerfilCofinanciadorEntity perfilCofinanciadorEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilCofinanciador',
        where: 'PerfilId = ? AND CofinanciadorId = ?',
        whereArgs: [
          perfilCofinanciadorEntity.perfilId,
          perfilCofinanciadorEntity.cofinanciadorId
        ]);

    if (resQuery.isEmpty) {
      perfilCofinanciadorEntity.recordStatus = 'N';
      batch.insert('PerfilCofinanciador', perfilCofinanciadorEntity.toJson());
    } else {
      perfilCofinanciadorEntity.recordStatus = 'E';
      batch.update('PerfilCofinanciador', perfilCofinanciadorEntity.toJson(),
          where: 'PerfilId = ? AND CofinanciadorId = ?',
          whereArgs: [
            perfilCofinanciadorEntity.perfilId,
            perfilCofinanciadorEntity.cofinanciadorId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilCofinanciadorModel>>
      getPerfilesCofinanciadoresProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilCofinanciador',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final perfilesCofinanciadoresModel = List<PerfilCofinanciadorModel>.from(
        res.map((m) => PerfilCofinanciadorModel.fromJson(m))).toList();

    return perfilesCofinanciadoresModel;
  }

  @override
  Future<int> updatePerfilesCofinanciadoresProduccionDB(
      List<PerfilCofinanciadorEntity>
          perfilesCofinanciadoresProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var perfilCofinanciadorProduccion
        in perfilesCofinanciadoresProduccionEntity) {
      perfilCofinanciadorProduccion.recordStatus = 'R';
      batch.update(
          'PerfilCofinanciador', perfilCofinanciadorProduccion.toJson(),
          where: 'PerfilId = ? AND CofinanciadorId = ?',
          whereArgs: [
            perfilCofinanciadorProduccion.perfilId,
            perfilCofinanciadorProduccion.cofinanciadorId
          ]);
    }

    await batch.commit();
    final query = await db.query('PerfilCofinanciador',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    return query.length;
  }
}
