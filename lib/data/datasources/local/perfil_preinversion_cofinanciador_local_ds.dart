import 'package:sqflite/sqflite.dart';

import '../../db/db_config.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../models/perfil_preinversion_cofinanciador_model.dart';

abstract class PerfilPreInversionCofinanciadorLocalDataSource {
  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilesPreInversionesCofinanciadores(String perfilPreInversionId);

  Future<PerfilPreInversionCofinanciadorModel?>
      getPerfilPreInversionCofinanciador(String perfilPreInversionId);

  Future<int> savePerfilesPreInversionesCofinanciadores(
      List<PerfilPreInversionCofinanciadorEntity>
          perfilPreInversionCofinanciadorEntity);

  Future<int> savePerfilPreInversionCofinanciador(
      PerfilPreInversionCofinanciadorEntity
          perfilPreInversionCofinanciadorEntity);

  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilesPreInversionesCofinanciadoresProduccion();

  Future<int> updatePerfilesPreInversionesCofinanciadoresProduccion(
      List<PerfilPreInversionCofinanciadorEntity>
          perfilesPreInversionesCofinanciadoresProduccionEntity);
}

class PerfilPreInversionCofinanciadorLocalDataSourceImpl
    implements PerfilPreInversionCofinanciadorLocalDataSource {
  static createPerfilPreInversionCofinanciadorTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS PerfilPreInversionCofinanciador (
        PerfilPreInversionId	TEXT NOT NULL,
        CofinanciadorId	TEXT NOT NULL,
        Monto	TEXT,
        Participacion	TEXT,
        RecordStatus	TEXT,
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId),
        FOREIGN KEY(CofinanciadorId) REFERENCES Cofinanciador(CofinanciadorId)
      )
    ''');
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilesPreInversionesCofinanciadores(
          String perfilPreInversionId) async {
    final db = await DBConfig.database;

    String sql = '''
      Select 
      Cofinanciador.ID as CofinanciadorId,
      Cofinanciador.Nombre as Nombre,
      Cofinanciador.Teléfono_x0020_Móvil as TelefonoMovil,
      Cofinanciador.Correo as Correo,
      Cofinanciador.Municipio as Municipio,
      PerfilPreInversionCofinanciador.Monto as Monto,
      CASE  
      WHEN Cast(PerfilPreInversionCofinanciador.Monto as decimal) = 0  
      THEN 0 
      ELSE ((Cast(PerfilPreInversionCofinanciador.Monto as decimal)*100)/Cast(PerfilPreInversion.ValorTotalProyecto as decimal)) 
      END as Participacion
      From  Cofinanciador
      INNER JOIN PerfilPreInversionCofinanciador  ON Cofinanciador.ID = PerfilPreInversionCofinanciador.CofinanciadorId
      INNER JOIN PerfilPreInversion  ON PerfilPreInversionCofinanciador.PerfilPreInversionId = PerfilPreInversion.PerfilPreInversionId
      where PerfilPreInversionCofinanciador.PerfilPreInversionId = $perfilPreInversionId
      UNION ALL
      Select 
      '' as CofinanciadorId,
      '' as Nombre,
      '' as TelefonoMovil,
      'TOTAL' as Correo,
      '' as Municipio,
      SUM (Cast(PerfilPreInversionCofinanciador.Monto as decimal)) + MAX( Cast(PerfilPreInversion.IncentivoModular as decimal)) as Monto,
      CASE  
      WHEN (SUM (Cast(PerfilPreInversionCofinanciador.Monto as decimal)) + MAX(Cast(PerfilPreInversion.IncentivoModular as decimal))) = 0  
      THEN 0 
      ELSE (((SUM(Cast(PerfilPreInversionCofinanciador.Monto as decimal))  + MAX (Cast(PerfilPreInversion.IncentivoModular as decimal)))*100)/Cast(PerfilPreInversion.ValorTotalProyecto as decimal)) 
      END as Participacion
      FROM PerfilPreInversion
      INNER JOIN PerfilPreInversionCofinanciador ON PerfilPreInversion.PerfilPreInversionId = PerfilPreInversionCofinanciador.PerfilPreInversionId
      where PerfilPreInversionCofinanciador.PerfilPreInversionId = $perfilPreInversionId
      GROUP BY PerfilPreInversion.PerfilId, PerfilPreInversion.IncentivoModular, PerfilPreInversion.ValorTotalProyecto
      ''';

    final res = await db.rawQuery(sql);

    final perfilPreInversionCofinanciador =
        List<PerfilPreInversionCofinanciadorModel>.from(res.map(
            (m) => PerfilPreInversionCofinanciadorModel.fromJson(m))).toList();

    return perfilPreInversionCofinanciador;
  }

  @override
  Future<PerfilPreInversionCofinanciadorModel?>
      getPerfilPreInversionCofinanciador(String perfilPreInversionId) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciador',
        where: 'PerfilPreInversionId = ?', whereArgs: [perfilPreInversionId]);

    if (res.isEmpty) return null;
    final perfilPreInversionCofinanciadorMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilPreInversionCofinanciadorModel =
        PerfilPreInversionCofinanciadorModel.fromJson(
            perfilPreInversionCofinanciadorMap);

    return perfilPreInversionCofinanciadorModel;
  }

  @override
  Future<int> savePerfilesPreInversionesCofinanciadores(
      List<PerfilPreInversionCofinanciadorEntity>
          perfilPreInversionCofinanciadorEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversionCofinanciador');

    for (var perfilPreInversionCofinanciador
        in perfilPreInversionCofinanciadorEntity) {
      perfilPreInversionCofinanciador.recordStatus = 'R';

      batch.insert('PerfilPreInversionCofinanciador',
          perfilPreInversionCofinanciador.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> savePerfilPreInversionCofinanciador(
      PerfilPreInversionCofinanciadorEntity
          perfilPreInversionCofinanciadorEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilPreInversionCofinanciador',
        where: 'CofinanciadorId = ? AND PerfilPreInversionId = ?',
        whereArgs: [
          perfilPreInversionCofinanciadorEntity.cofinanciadorId,
          perfilPreInversionCofinanciadorEntity.perfilPreInversionId
        ]);

    if (resQuery.isEmpty) {
      perfilPreInversionCofinanciadorEntity.recordStatus = 'N';
      batch.insert('PerfilPreInversionCofinanciador',
          perfilPreInversionCofinanciadorEntity.toJson());
    } else {
      perfilPreInversionCofinanciadorEntity.recordStatus = 'E';
      batch.update('PerfilPreInversionCofinanciador',
          perfilPreInversionCofinanciadorEntity.toJson(),
          where: 'CofinanciadorId = ? AND PerfilPreInversionId = ?',
          whereArgs: [
            perfilPreInversionCofinanciadorEntity.cofinanciadorId,
            perfilPreInversionCofinanciadorEntity.perfilPreInversionId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilesPreInversionesCofinanciadoresProduccion() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciador',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final perfilesPreInversionesCofinanciadoresModel =
        List<PerfilPreInversionCofinanciadorModel>.from(res.map(
            (m) => PerfilPreInversionCofinanciadorModel.fromJson(m))).toList();

    return perfilesPreInversionesCofinanciadoresModel;
  }

  @override
  Future<int> updatePerfilesPreInversionesCofinanciadoresProduccion(
      List<PerfilPreInversionCofinanciadorEntity>
          perfilesPreInversionesCofinanciadoresProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var perfilPreInversionCofinanciadorProduccion
        in perfilesPreInversionesCofinanciadoresProduccionEntity) {
      perfilPreInversionCofinanciadorProduccion.recordStatus = 'R';
      batch.update('PerfilPreInversionCofinanciador',
          perfilPreInversionCofinanciadorProduccion.toJson(),
          where: 'CofinanciadorId = ?',
          whereArgs: [
            perfilPreInversionCofinanciadorProduccion.cofinanciadorId
          ]);
    }

    await batch.commit();
    final query = await db.query('PerfilPreInversionCofinanciador',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    return query.length;
  }
}
