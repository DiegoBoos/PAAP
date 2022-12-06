import 'package:paap/data/models/evaluacion_respuesta_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/evaluacion_entity.dart';
import '../../../domain/entities/evaluacion_respuesta_entity.dart';
import '../../../domain/db/db_config.dart';

abstract class EvaluacionRespuestaLocalDataSource {
  Future<List<EvaluacionRespuestaModel>> getEvaluacionesRespuestasDB(
      String criterioId, String evaluacionId);
  Future<EvaluacionRespuestaModel?> getEvaluacionRespuestaDB(
      String criterioId, String evaluacionId);
  Future<List<EvaluacionRespuestaModel>>
      getEvaluacionesRespuestasProduccionDB();
  Future<int> saveEvaluacionRespuestaDB(
      EvaluacionRespuestaEntity evaluacionRespuestaEntity, String perfilId);
  Future<int> saveEvaluacionesRespuestasDB(
      List<EvaluacionRespuestaEntity> evaluacionRespuestaEntity);
  Future<int> updateEvaluacionesRespuestasProduccionDB(
      List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity);
  Future<int> clearEvaluacionesRespuestasDB();
  updateRespuestaRemoteEvaluacionIdDB(List<EvaluacionEntity> evaluaciones);
}

class EvaluacionRespuestaLocalDataSourceImpl
    implements EvaluacionRespuestaLocalDataSource {
  static createEvaluacionRespuestaTable(Database db) async {
    await db.execute('''
      CREATE TABLE EvaluacionRespuesta (
        CriterioId	TEXT NOT NULL,
        EvaluacionId	TEXT NOT NULL,
        OpcionId	TEXT NOT NULL,
        Observacion	TEXT,
        RecordStatus	TEXT,
        RemoteEvaluacionId	TEXT
      )
    ''');
  }

  @override
  Future<List<EvaluacionRespuestaModel>> getEvaluacionesRespuestasDB(
      String criterioId, String evaluacionId) async {
    final db = await DBConfig.database;

    final res = await db.query('EvaluacionRespuesta',
        where: 'CriterioId = ? AND EvaluacionId = ?',
        whereArgs: [criterioId, evaluacionId]);

    if (res.isEmpty) return [];

    final evaluacionesRespuestasModel = List<EvaluacionRespuestaModel>.from(
        res.map((m) => EvaluacionRespuestaModel.fromJson(m))).toList();

    return evaluacionesRespuestasModel;
  }

  @override
  Future<EvaluacionRespuestaModel?> getEvaluacionRespuestaDB(
      String criterioId, String evaluacionId) async {
    final db = await DBConfig.database;
    final res = await db.query('EvaluacionRespuesta',
        where: 'CriterioId = ? AND EvaluacionId = ?',
        whereArgs: [criterioId, evaluacionId]);

    if (res.isEmpty) {
      return EvaluacionRespuestaModel(
          criterioId: criterioId,
          evaluacionId: evaluacionId,
          opcionId: '',
          observacion: '',
          recordStatus: 'N');
    }
    final evaluacionRespuestaMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final evaluacionRespuestaModel =
        EvaluacionRespuestaModel.fromJson(evaluacionRespuestaMap);

    return evaluacionRespuestaModel;
  }

  @override
  Future<int> updateRespuestaRemoteEvaluacionIdDB(
      List<EvaluacionEntity> evaluaciones) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    for (var evaluacion in evaluaciones) {
      final objUpdate = {'RemoteEvaluacionId': evaluacion.remoteEvaluacionId};
      await db.update(
        'EvaluacionRespuesta',
        objUpdate,
        where: 'EvaluacionId = ?',
        whereArgs: [evaluacion.evaluacionId],
      );
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveEvaluacionRespuestaDB(
      EvaluacionRespuestaEntity evaluacionRespuestaEntity,
      String perfilId) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('EvaluacionRespuesta',
        where: 'CriterioId = ? AND EvaluacionId = ?',
        whereArgs: [
          evaluacionRespuestaEntity.criterioId,
          evaluacionRespuestaEntity.evaluacionId
        ]);

    if (resQuery.isEmpty) {
      evaluacionRespuestaEntity.recordStatus = 'N';
      batch.insert('EvaluacionRespuesta', evaluacionRespuestaEntity.toJson());
    } else {
      evaluacionRespuestaEntity.recordStatus = 'E';
      batch.update('EvaluacionRespuesta', evaluacionRespuestaEntity.toJson(),
          where: 'CriterioId = ? AND EvaluacionId = ?',
          whereArgs: [
            evaluacionRespuestaEntity.criterioId,
            evaluacionRespuestaEntity.evaluacionId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveEvaluacionesRespuestasDB(
      List<EvaluacionRespuestaEntity> evaluacionRespuestaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    batch.delete('EvaluacionRespuesta');

    for (var evaluacionRespuesta in evaluacionRespuestaEntity) {
      evaluacionRespuesta.recordStatus = 'R';
      evaluacionRespuesta.remoteEvaluacionId = evaluacionRespuesta.evaluacionId;
      batch.insert('EvaluacionRespuesta', evaluacionRespuesta.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<EvaluacionRespuestaModel>>
      getEvaluacionesRespuestasProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('EvaluacionRespuesta',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final evaluacionesRespuestasModel = List<EvaluacionRespuestaModel>.from(
        res.map((m) => EvaluacionRespuestaModel.fromJson(m))).toList();

    List<EvaluacionRespuestaModel> evaluacionesRespuestas = [];
    for (var evaluacion in evaluacionesRespuestasModel) {
      evaluacion.evaluacionId = evaluacion.remoteEvaluacionId;
      evaluacionesRespuestas.add(evaluacion);
    }

    return evaluacionesRespuestas;
  }

  @override
  Future<int> updateEvaluacionesRespuestasProduccionDB(
      List<EvaluacionRespuestaEntity>
          evaluacionesRespuestasProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var evaluacionRespuestaProduccion
        in evaluacionesRespuestasProduccionEntity) {
      evaluacionRespuestaProduccion.recordStatus = 'R';
      batch.update(
          'EvaluacionRespuesta', evaluacionRespuestaProduccion.toJson(),
          where: 'EvaluacionId = ? AND CriterioId',
          whereArgs: [
            evaluacionRespuestaProduccion.evaluacionId,
            evaluacionRespuestaProduccion.criterioId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> clearEvaluacionesRespuestasDB() async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('EvaluacionRespuesta');

    final res = await batch.commit();

    return res.length;
  }
}
