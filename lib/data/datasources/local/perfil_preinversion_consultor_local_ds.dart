import 'package:sqflite/sqflite.dart';

import '../../../domain/db/db_config.dart';
import '../../../domain/entities/perfil_preinversion_consultor_entity.dart';
import '../../models/perfil_preinversion_consultor_model.dart';

abstract class PerfilPreInversionConsultorLocalDataSource {
  Future<List<PerfilPreInversionConsultorModel>>
      getPerfilPreInversionConsultoresDB(String perfilPreInversionId);
  Future<PerfilPreInversionConsultorModel?> getPerfilPreInversionConsultorDB(
      String perfilPreInversionId, String consultorId, String revisionId);
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
  Future<int> deletePerfilesPreInversionesConsultoresDB(
      String perfilPreInversionId, String consultorId, String revisionId);
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
      getPerfilPreInversionConsultoresDB(String perfilPreInversionId) async {
    final db = await DBConfig.database;

    String sql = '''
      select 
      PerfilPreInversionConsultor.PerfilPreInversionId,
      PerfilPreInversionConsultor.ConsultorId,
      PerfilPreInversionConsultor.RevisionId,
      PerfilPreInversionConsultor.FechaRevision,
      Revision.Nombre as Revision,
      Consultor.Consultor as consultor
      from PerfilPreInversionConsultor
      left join Consultor on (Consultor.ConsultorId=PerfilPreInversionConsultor.ConsultorId)
      left join Revision on (Revision.RevisionId=PerfilPreInversionConsultor.RevisionId)
      where PerfilPreInversionId = $perfilPreInversionId
      ''';

    final res = await db.rawQuery(sql);

    if (res.isEmpty) return [];

    final perfilPreInversionConsultor =
        List<PerfilPreInversionConsultorModel>.from(
                res.map((m) => PerfilPreInversionConsultorModel.fromJson(m)))
            .toList();

    return perfilPreInversionConsultor;
  }

  @override
  Future<PerfilPreInversionConsultorModel?> getPerfilPreInversionConsultorDB(
      String perfilPreInversionId,
      String consultorId,
      String revisionId) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionConsultor',
        where:
            'PerfilPreInversionId = ? AND ConsultorId = ? AND RevisionId = ?',
        whereArgs: [perfilPreInversionId, consultorId, revisionId]);

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
      final objInsert = {
        'perfilPreInversionId':
            perfilPreInversionConsultor.perfilPreInversionId,
        'consultorId': perfilPreInversionConsultor.consultorId,
        'revisionId': perfilPreInversionConsultor.revisionId,
        'fechaRevision': perfilPreInversionConsultor.fechaRevision,
        'recordStatus': 'R',
      };
      batch.insert('PerfilPreInversionConsultor', objInsert);
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

    //await db.delete('PerfilPreInversionConsultor');

    final resQuery = await db.query('PerfilPreInversionConsultor',
        where:
            'PerfilPreinversionId = ? AND ConsultorId = ? AND RevisionId = ?',
        whereArgs: [
          perfilPreInversionConsultorEntity.perfilPreInversionId,
          perfilPreInversionConsultorEntity.consultorId,
          perfilPreInversionConsultorEntity.revisionId
        ]);

    if (resQuery.isEmpty) {
      //perfilPreInversionConsultorEntity.recordStatus = 'N';
      final objInsert = {
        'perfilPreInversionId':
            perfilPreInversionConsultorEntity.perfilPreInversionId,
        'consultorId': perfilPreInversionConsultorEntity.consultorId,
        'revisionId': perfilPreInversionConsultorEntity.revisionId,
        'fechaRevision': perfilPreInversionConsultorEntity.fechaRevision,
        'recordStatus': 'N',
      };
      batch.insert('PerfilPreInversionConsultor', objInsert);
    } else {
      final objUpdate = {
        'perfilPreInversionId':
            perfilPreInversionConsultorEntity.perfilPreInversionId,
        'consultorId': perfilPreInversionConsultorEntity.consultorId,
        'revisionId': perfilPreInversionConsultorEntity.revisionId,
        'fechaRevision': perfilPreInversionConsultorEntity.fechaRevision,
        'recordStatus': 'E',
      };
      batch.update('PerfilPreInversionConsultor', objUpdate,
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
      if (perfilPreInversionConsultorProduccion.recordStatus == 'D') {
        batch.delete('PerfilPreInversionConsultor',
            where:
                'PerfilPreinversionId = ? AND ConsultorId = ? AND RevisionId',
            whereArgs: [
              perfilPreInversionConsultorProduccion.perfilPreInversionId,
              perfilPreInversionConsultorProduccion.consultorId,
              perfilPreInversionConsultorProduccion.revisionId,
            ]);
      } else {
        final objUpdate = {
          'perfilPreInversionId':
              perfilPreInversionConsultorProduccion.perfilPreInversionId,
          'consultorId': perfilPreInversionConsultorProduccion.consultorId,
          'revisionId': perfilPreInversionConsultorProduccion.revisionId,
          'fechaRevision': perfilPreInversionConsultorProduccion.fechaRevision,
          'recordStatus': 'R',
        };
        batch.update('PerfilPreInversionConsultor', objUpdate,
            where:
                'PerfilPreinversionId = ? AND ConsultorId = ? AND RevisionId',
            whereArgs: [
              perfilPreInversionConsultorProduccion.perfilPreInversionId,
              perfilPreInversionConsultorProduccion.consultorId,
              perfilPreInversionConsultorProduccion.revisionId,
            ]);
      }
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> deletePerfilesPreInversionesConsultoresDB(
      String perfilPreInversionId,
      String consultorId,
      String revisionId) async {
    final db = await DBConfig.database;

    final resQuery = await db.query('PerfilPreInversionConsultor',
        where:
            'PerfilPreInversionId = ? AND ConsultorId = ? AND RevisionId = ?',
        whereArgs: [perfilPreInversionId, consultorId, revisionId]);
    if (resQuery.isEmpty) return 0;
    final perfilPreInversionConsultorMap = {
      for (var e in resQuery[0].entries) e.key: e.value
    };
    final perfilPreInversionConsultorModel =
        PerfilPreInversionConsultorModel.fromJson(
            perfilPreInversionConsultorMap);

    if (perfilPreInversionConsultorModel.recordStatus == 'N') {
      final res = await db.delete('PerfilPreInversionConsultor',
          where:
              'PerfilPreInversionId = ? AND ConsultorId = ? AND RevisionId = ?',
          whereArgs: [perfilPreInversionId, consultorId, revisionId]);
      return res;
    } else {
      final objUpdate = {
        'perfilPreInversionId':
            perfilPreInversionConsultorModel.perfilPreInversionId,
        'consultorId': perfilPreInversionConsultorModel.consultorId,
        'revisionId': perfilPreInversionConsultorModel.revisionId,
        'fechaRevision': perfilPreInversionConsultorModel.fechaRevision,
        'recordStatus': 'D',
      };
      final res = await db.update(
        'PerfilPreInversionConsultor',
        objUpdate,
        where:
            'PerfilPreInversionId = ? AND ConsultorId = ? AND RevisionId = ?',
        whereArgs: [perfilPreInversionId, consultorId, revisionId],
      );
      return res;
    }
  }
}
