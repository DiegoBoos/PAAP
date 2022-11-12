import 'package:paap/data/models/evaluacion_respuesta_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/evaluacion_respuesta_entity.dart';
import '../../../../domain/db/db_config.dart';

abstract class EvaluacionRespuestaLocalDataSource {
  Future<EvaluacionRespuestaModel?> getEvaluacionRespuestaDB(
      String criterioId, String evaluacionId);
  Future<int> saveEvaluacionRespuestaDB(
      EvaluacionRespuestaEntity evaluacionRespuestaEntity);
  Future<int> saveEvaluacionesRespuestasDB(
      List<EvaluacionRespuestaEntity> evaluacionRespuestaEntity);
  Future<int> clearEvaluacionesRespuestasDB();
}

class EvaluacionRespuestaLocalDataSourceImpl
    implements EvaluacionRespuestaLocalDataSource {
  static createEvaluacionRespuestaTable(Database db) async {
    await db.execute('''
      CREATE TABLE EvaluacionRespuesta (
        CriterioId	TEXT NOT NULL,
        EvaluacionId	TEXT NOT NULL,
        OpcionId	TEXT NOT NULL,
        Observacion	TEXT
      )
    ''');
  }

  @override
  Future<EvaluacionRespuestaModel?> getEvaluacionRespuestaDB(
      String criterioId, String evaluacionId) async {
    final db = await DBConfig.database;
    final res = await db.query('EvaluacionRespuesta',
        where: 'CriterioId = ? AND EvaluacionId = ?',
        whereArgs: [criterioId, evaluacionId]);

    if (res.isEmpty) return null;
    final evaluacionRespuestaMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final evaluacionRespuestaModel =
        EvaluacionRespuestaModel.fromJson(evaluacionRespuestaMap);

    return evaluacionRespuestaModel;
  }

  @override
  Future<int> saveEvaluacionRespuestaDB(
      EvaluacionRespuestaEntity evaluacionRespuestaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('EvaluacionRespuesta');

    batch.insert('EvaluacionRespuesta', evaluacionRespuestaEntity.toJson());

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
      batch.insert('EvaluacionRespuesta', evaluacionRespuesta.toJson());
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
