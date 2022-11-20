import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../../domain/entities/perfil_preinversion_consultor_entity.dart';
import '../../../models/perfil_preinversion_consultor_model.dart';

abstract class PerfilPreInversionConsultorLocalDataSource {
  Future<List<PerfilPreInversionConsultorModel>>
      getPerfilPreInversionConsultoresDB();
  Future<PerfilPreInversionConsultorModel?> getPerfilPreInversionConsultorDB(
      String id);
  Future<int> savePerfilPreInversionConsultores(
      List<PerfilPreInversionConsultorEntity>
          perfilPreInversionConsultorEntity);
  Future<int> savePerfilPreInversionConsultorDB(
      PerfilPreInversionConsultorEntity perfilPreInversionConsultorEntity);
  Future<List<PerfilPreInversionConsultorModel>>
      getPerfilesPreInversionesConsultoresProduccionDB();
  Future<int> updatePerfilesPreInversionesConsultoresProduccionDB(
      List<PerfilPreInversionConsultorEntity>
          perfilesPreInversionesConsultoresProduccionEntity);
}

class PerfilPreInversionConsultorLocalDataSourceImpl
    implements PerfilPreInversionConsultorLocalDataSource {
  static createPerfilPreInversionConsultorTable(Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreInversionConsultor (
        PerfilPreInversionId	TEXT NOT NULL,
        ConsultorId	TEXT NOT NULL,
        RevisionId	TEXT,
        FechaRevision	TEXT,
        RecordStatus	TEXT,
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId),
        FOREIGN KEY(ConsultorId) REFERENCES Consultor(ConsultorId)
        FOREIGN KEY(RevisionId) REFERENCES Revision(RevisionId)
      )
    ''');
  }

  @override
  Future<List<PerfilPreInversionConsultorModel>>
      getPerfilPreInversionConsultoresDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionConsultor');

    final perfilPreInversionConsultor =
        List<PerfilPreInversionConsultorModel>.from(
                res.map((m) => PerfilPreInversionConsultorModel.fromJson(m)))
            .toList();

    return perfilPreInversionConsultor;
  }

  @override
  Future<PerfilPreInversionConsultorModel?> getPerfilPreInversionConsultorDB(
      String id) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionConsultor',
        where: 'PerfilPreInversionId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final perfilPreInversionConsultorMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilPreInversionConsultorModel =
        PerfilPreInversionConsultorModel.fromJson(
            perfilPreInversionConsultorMap);

    return perfilPreInversionConsultorModel;
  }

  @override
  Future<int> savePerfilPreInversionConsultores(
      List<PerfilPreInversionConsultorEntity>
          perfilPreInversionConsultorEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversionConsultor');

    for (var perfilPreInversionConsultor in perfilPreInversionConsultorEntity) {
      batch.insert(
          'PerfilPreInversionConsultor', perfilPreInversionConsultor.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> savePerfilPreInversionConsultorDB(
      PerfilPreInversionConsultorEntity
          perfilPreInversionConsultorEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilPreInversionConsultor',
        where: 'PerfilPreinversionId = ? AND ConsultorId = ?',
        whereArgs: [
          perfilPreInversionConsultorEntity.perfilPreInversionId,
          perfilPreInversionConsultorEntity.consultorId
        ]);

    if (resQuery.isEmpty) {
      perfilPreInversionConsultorEntity.recordStatus = 'N';
      batch.insert('PerfilPreInversionConsultor',
          perfilPreInversionConsultorEntity.toJson());
    } else {
      perfilPreInversionConsultorEntity.recordStatus = 'E';
      batch.update('PerfilPreInversionConsultor',
          perfilPreInversionConsultorEntity.toJson(),
          where: 'PerfilPreinversionId = ? AND ConsultorId = ?',
          whereArgs: [
            perfilPreInversionConsultorEntity.perfilPreInversionId,
            perfilPreInversionConsultorEntity.consultorId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionConsultorModel>>
      getPerfilesPreInversionesConsultoresProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionConsultor',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final perfilesPreInversionesConsultoresModel =
        List<PerfilPreInversionConsultorModel>.from(
                res.map((m) => PerfilPreInversionConsultorModel.fromJson(m)))
            .toList();

    return perfilesPreInversionesConsultoresModel;
  }

  @override
  Future<int> updatePerfilesPreInversionesConsultoresProduccionDB(
      List<PerfilPreInversionConsultorEntity>
          perfilesPreInversionesConsultoresProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var perfilPreInversionConsultorProduccion
        in perfilesPreInversionesConsultoresProduccionEntity) {
      perfilPreInversionConsultorProduccion.recordStatus = 'R';
      batch.update('PerfilPreInversionConsultor',
          perfilPreInversionConsultorProduccion.toJson(),
          where: 'PerfilPreinversionId = ? AND ConsultorId = ?',
          whereArgs: [
            perfilPreInversionConsultorProduccion.perfilPreInversionId,
            perfilPreInversionConsultorProduccion.consultorId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }
}
