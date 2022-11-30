import 'package:sqflite/sqflite.dart';

import '../../../domain/db/db_config.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../models/perfil_preinversion_cofinanciador_desembolso_model.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsoLocalDataSource {
  Future<List<PerfilPreInversionCofinanciadorDesembolsoModel>>
      getPerfilPreInversionCofinanciadorDesembolsosDB();
  Future<PerfilPreInversionCofinanciadorDesembolsoModel?>
      getPerfilPreInversionCofinanciadorDesembolsoDB(
          String perfilPreInversionId, String cofinanciadorId);
  Future<int> savePerfilPreInversionCofinanciadorDesembolsos(
      List<PerfilPreInversionCofinanciadorDesembolsoEntity>
          perfilPreInversionCofinanciadorDesembolsoEntity);
  Future<int> savePerfilPreInversionCofinanciadorDesembolsoDB(
      PerfilPreInversionCofinanciadorDesembolsoEntity
          perfilPreInversionCofinanciadorDesembolsoEntity);
  Future<List<PerfilPreInversionCofinanciadorDesembolsoModel>>
      getPerfilesPreInversionesCofinanciadoresDesembolsosProduccionDB();
  Future<int>
      updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccionDB(
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              perfilesPreInversionesCofinanciadoresDesembolsosProduccionEntity);
  getPerfilPreInversionCofinanciadorDesembolsosByCofinanciadorDB(
      String perfilPreInversionId, String cofinanciadorId, String desembolsoId);
}

class PerfilPreInversionCofinanciadorDesembolsoLocalDataSourceImpl
    implements PerfilPreInversionCofinanciadorDesembolsoLocalDataSource {
  static createPerfilPreInversionCofinanciadorDesembolsoTable(
      Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreInversionCofinanciadorDesembolso (
        PerfilPreInversionId	TEXT NOT NULL,
        CofinanciadorId	TEXT NOT NULL,
        DesembolsoId	TEXT NOT NULL,
        Fecha	TEXT,
        RecordStatus	TEXT,
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId),
        FOREIGN KEY(CofinanciadorId) REFERENCES Cofinanciador(CofinanciadorId),
        FOREIGN KEY(DesembolsoId) REFERENCES Desembolso(DesembolsoId)
      )
    ''');
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorDesembolsoModel>>
      getPerfilPreInversionCofinanciadorDesembolsosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciadorDesembolso');

    final perfilPreInversionCofinanciadorDesembolso =
        List<PerfilPreInversionCofinanciadorDesembolsoModel>.from(res.map((m) =>
                PerfilPreInversionCofinanciadorDesembolsoModel.fromJson(m)))
            .toList();

    return perfilPreInversionCofinanciadorDesembolso;
  }

  @override
  Future<PerfilPreInversionCofinanciadorDesembolsoModel?>
      getPerfilPreInversionCofinanciadorDesembolsoDB(
          String perfilPreInversionId, String cofinanciadorId) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciadorDesembolso',
        where: 'PerfilPreInversionId = ? AND CofinanciadorId = ?',
        whereArgs: [perfilPreInversionId, cofinanciadorId]);

    if (res.isEmpty) return null;
    final perfilPreInversionCofinanciadorDesembolsoMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilPreInversionCofinanciadorDesembolsoModel =
        PerfilPreInversionCofinanciadorDesembolsoModel.fromJson(
            perfilPreInversionCofinanciadorDesembolsoMap);

    return perfilPreInversionCofinanciadorDesembolsoModel;
  }

  @override
  Future<int> savePerfilPreInversionCofinanciadorDesembolsos(
      List<PerfilPreInversionCofinanciadorDesembolsoEntity>
          perfilPreInversionCofinanciadorDesembolsoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversionCofinanciadorDesembolso');

    for (var perfilPreInversionCofinanciadorDesembolso
        in perfilPreInversionCofinanciadorDesembolsoEntity) {
      perfilPreInversionCofinanciadorDesembolso.recordStatus = 'R';
      batch.insert('PerfilPreInversionCofinanciadorDesembolso',
          perfilPreInversionCofinanciadorDesembolso.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  getPerfilPreInversionCofinanciadorDesembolsosByCofinanciadorDB(
      String perfilPreInversionId,
      String cofinanciadorId,
      String desembolsoId) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciadorDesembolso',
        where:
            'PerfilPreInversionId = ? AND CofinanciadorId = ? AND DesembolsoId = ?',
        whereArgs: [perfilPreInversionId, cofinanciadorId, desembolsoId]);

    final perfilPreInversionCofinanciadorDesembolso =
        List<PerfilPreInversionCofinanciadorDesembolsoModel>.from(res.map((m) =>
                PerfilPreInversionCofinanciadorDesembolsoModel.fromJson(m)))
            .toList();

    return perfilPreInversionCofinanciadorDesembolso;
  }

  @override
  Future<int> savePerfilPreInversionCofinanciadorDesembolsoDB(
      PerfilPreInversionCofinanciadorDesembolsoEntity
          perfilPreInversionCofinanciadorDesembolsoEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilPreInversionCofinanciadorDesembolso',
        where:
            'PerfilPreInversionId = ? AND CofinanciadorId = ? AND DesembolsoId = ?',
        whereArgs: [
          perfilPreInversionCofinanciadorDesembolsoEntity.perfilPreInversionId,
          perfilPreInversionCofinanciadorDesembolsoEntity.cofinanciadorId,
          perfilPreInversionCofinanciadorDesembolsoEntity.desembolsoId,
        ]);

    if (resQuery.isEmpty) {
      perfilPreInversionCofinanciadorDesembolsoEntity.recordStatus = 'N';
      batch.insert('PerfilPreInversionCofinanciadorDesembolso',
          perfilPreInversionCofinanciadorDesembolsoEntity.toJson());
    } else {
      perfilPreInversionCofinanciadorDesembolsoEntity.recordStatus = 'E';
      batch.update('PerfilPreInversionCofinanciadorDesembolso',
          perfilPreInversionCofinanciadorDesembolsoEntity.toJson(),
          where:
              'PerfilPreInversionId = ? AND CofinanciadorId = ? AND DesembolsoId = ?',
          whereArgs: [
            perfilPreInversionCofinanciadorDesembolsoEntity
                .perfilPreInversionId,
            perfilPreInversionCofinanciadorDesembolsoEntity.cofinanciadorId,
            perfilPreInversionCofinanciadorDesembolsoEntity.desembolsoId,
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorDesembolsoModel>>
      getPerfilesPreInversionesCofinanciadoresDesembolsosProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciadorDesembolso',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final perfilesPreInversionesCofinanciadoresDesembolsosModel =
        List<PerfilPreInversionCofinanciadorDesembolsoModel>.from(res.map((m) =>
                PerfilPreInversionCofinanciadorDesembolsoModel.fromJson(m)))
            .toList();

    return perfilesPreInversionesCofinanciadoresDesembolsosModel;
  }

  @override
  Future<int> updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccionDB(
      List<PerfilPreInversionCofinanciadorDesembolsoEntity>
          perfilesPreInversionesCofinanciadoresDesembolsosProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var perfilPreInversionCofinanciadorDesembolsoProduccion
        in perfilesPreInversionesCofinanciadoresDesembolsosProduccionEntity) {
      perfilPreInversionCofinanciadorDesembolsoProduccion.recordStatus = 'R';
      batch.update('PerfilPreInversionCofinanciadorDesembolso',
          perfilPreInversionCofinanciadorDesembolsoProduccion.toJson(),
          where:
              'PerfilPreInversionId = ? AND CofinanciadorId = ? AND DesembolsoId = ?',
          whereArgs: [
            perfilPreInversionCofinanciadorDesembolsoProduccion
                .perfilPreInversionId,
            perfilPreInversionCofinanciadorDesembolsoProduccion.cofinanciadorId,
            perfilPreInversionCofinanciadorDesembolsoProduccion.desembolsoId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }
}
