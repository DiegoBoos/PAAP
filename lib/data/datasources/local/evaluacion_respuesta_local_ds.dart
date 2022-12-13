import 'package:paap/data/models/evaluacion_respuesta_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/evaluacion_entity.dart';
import '../../../domain/entities/evaluacion_respuesta_entity.dart';
import '../../../domain/db/db_config.dart';

abstract class EvaluacionRespuestaLocalDataSource {
  Future<List<EvaluacionRespuestaModel>> getEvaluacionesRespuestas(
      String criterioId, String evaluacionId);

  Future<EvaluacionRespuestaModel?> getEvaluacionRespuesta(
      String criterioId, String evaluacionId);

  Future<EvaluacionRespuestaModel> getEvaluacionRespuestaOpcion(
      String criterioId, String evaluacionId, String opcionId);

  Future<int> saveEvaluacionRespuesta(
      EvaluacionRespuestaEntity evaluacionRespuestaEntity, String perfilId);

  Future<int> saveEvaluacionesRespuestas(
      List<EvaluacionRespuestaEntity> evaluacionRespuestaEntity);

  Future<List<EvaluacionRespuestaModel>> getEvaluacionesRespuestasProduccion();

  Future<int> updateEvaluacionesRespuestasProduccion(
      List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity);

  Future<int> clearEvaluacionesRespuestas();
  updateRespuestaRemoteEvaluacionId(List<EvaluacionEntity> evaluaciones);
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
  Future<List<EvaluacionRespuestaModel>> getEvaluacionesRespuestas(
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
  Future<EvaluacionRespuestaModel?> getEvaluacionRespuesta(
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
  Future<EvaluacionRespuestaModel> getEvaluacionRespuestaOpcion(
      String criterioId, String evaluacionId, String opcionId) async {
    final db = await DBConfig.database;
    final res = await db.query('EvaluacionRespuesta',
        where: 'CriterioId = ? AND EvaluacionId = ? AND OpcionId = ?',
        whereArgs: [criterioId, evaluacionId, opcionId]);

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
  Future<int> updateRespuestaRemoteEvaluacionId(
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
  Future<int> saveEvaluacionRespuesta(
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
      if (evaluacionRespuestaEntity.recordStatus != 'N') {
        evaluacionRespuestaEntity.recordStatus = 'E';
      }
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
  Future<int> saveEvaluacionesRespuestas(
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
      getEvaluacionesRespuestasProduccion() async {
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
  Future<int> updateEvaluacionesRespuestasProduccion(
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

    await batch.commit();
    final query = await db.query('EvaluacionRespuesta',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    return query.length;
  }

  @override
  Future<int> clearEvaluacionesRespuestas() async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('EvaluacionRespuesta');

    final res = await batch.commit();

    return res.length;
  }
}
