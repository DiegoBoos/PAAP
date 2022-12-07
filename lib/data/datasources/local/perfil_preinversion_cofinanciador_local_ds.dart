import 'package:sqflite/sqflite.dart';

import '../../../domain/db/db_config.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../models/perfil_preinversion_cofinanciador_model.dart';

abstract class PerfilPreInversionCofinanciadorLocalDataSource {
  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilPreInversionCofinanciadoresDB(String perfilPreInversionId);

  Future<int> savePerfilesPreInversionesCofinanciadores(
      List<PerfilPreInversionCofinanciadorEntity>
          perfilPreInversionCofinanciadorEntity);
  Future<int> savePerfilPreInversionCofinanciadorDB(
      PerfilPreInversionCofinanciadorEntity
          perfilPreInversionCofinanciadorEntity);
  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilesPreInversionesCofinanciadoresProduccionDB();
  Future<int> updatePerfilesPreInversionesCofinanciadoresProduccionDB(
      List<PerfilPreInversionCofinanciadorEntity>
          perfilesPreInversionesCofinanciadoresProduccionEntity);
}

class PerfilPreInversionCofinanciadorLocalDataSourceImpl
    implements PerfilPreInversionCofinanciadorLocalDataSource {
  static createPerfilPreInversionCofinanciadorTable(Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreInversionCofinanciador (
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
      getPerfilPreInversionCofinanciadoresDB(
          String perfilPreInversionId) async {
    final db = await DBConfig.database;

    String sql = '''
      select 
      PerfilPreInversionCofinanciador.PerfilPreInversionId,
      PerfilPreInversionCofinanciador.CofinanciadorId,
      Monto as monto,
      Cofinanciador.Nombre as cofinanciador,
      Cofinanciador.Teléfono_x0020_Móvil as telefonoMovil,
      Cofinanciador.Correo as correo
      from PerfilPreInversionCofinanciador
      left join Cofinanciador on (Cofinanciador.ID=PerfilPreInversionCofinanciador.CofinanciadorId)
      where PerfilPreInversionId = $perfilPreInversionId
      ''';

    final res = await db.rawQuery(sql);

    final perfilPreInversionCofinanciador =
        List<PerfilPreInversionCofinanciadorModel>.from(res.map(
            (m) => PerfilPreInversionCofinanciadorModel.fromJson(m))).toList();

    return perfilPreInversionCofinanciador;
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
      batch.insert('PerfilPreInversionCofinanciador',
          perfilPreInversionCofinanciador.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> savePerfilPreInversionCofinanciadorDB(
      PerfilPreInversionCofinanciadorEntity
          perfilPreInversionCofinanciadorEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilPreInversionCofinanciador',
        where: 'CofinanciadorId = ?',
        whereArgs: [perfilPreInversionCofinanciadorEntity.cofinanciadorId]);

    if (resQuery.isEmpty) {
      perfilPreInversionCofinanciadorEntity.recordStatus = 'N';
      batch.insert('PerfilPreInversionCofinanciador',
          perfilPreInversionCofinanciadorEntity.toJson());
    } else {
      perfilPreInversionCofinanciadorEntity.recordStatus = 'E';
      batch.update('PerfilPreInversionCofinanciador',
          perfilPreInversionCofinanciadorEntity.toJson(),
          where: 'CofinanciadorId = ?',
          whereArgs: [perfilPreInversionCofinanciadorEntity.cofinanciadorId]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilesPreInversionesCofinanciadoresProduccionDB() async {
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
  Future<int> updatePerfilesPreInversionesCofinanciadoresProduccionDB(
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

    final res = await batch.commit();

    return res.length;
  }
}
