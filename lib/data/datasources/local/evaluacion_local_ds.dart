import 'package:paap/data/models/evaluacion_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/evaluacion_entity.dart';
import '../../db/db_config.dart';

abstract class EvaluacionLocalDataSource {
  Future<EvaluacionModel?> getEvaluacionDB(String perfilId);
  Future<List<EvaluacionModel>> getEvaluacionesProduccionDB();
  Future<int> saveEvaluacionDB(EvaluacionEntity evaluacionEntity);
  Future<int> saveEvaluacionesDB(List<EvaluacionEntity> evaluacionEntity);
  Future<List<String>> updateEvaluacionesProduccionDB(
      List<EvaluacionEntity> evaluacionesEntity);
  Future<int> clearEvaluacionesDB();
}

class EvaluacionLocalDataSourceImpl implements EvaluacionLocalDataSource {
  static createEvaluacionTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Evaluacion (
        EvaluacionId	INTEGER,
        PerfilId	TEXT NOT NULL,
        Resumen	TEXT NOT NULL,
        Fortalezas	TEXT,
        Debilidades	TEXT,
        Riesgos	TEXT NOT NULL,
        Finalizado	TEXT,
        UsuarioIdCoordinador	TEXT NOT NULL,
        FechaEvaluacion	TEXT,
        PreAprobado	TEXT,
        RecordStatus	TEXT,
        RemoteEvaluacionId	INTEGER,
        PRIMARY KEY(EvaluacionId AUTOINCREMENT)
      )
    ''');
  }

  @override
  Future<EvaluacionModel?> getEvaluacionDB(String perfilId) async {
    final db = await DBConfig.database;

    final res = await db
        .query('Evaluacion', where: 'PerfilId = ?', whereArgs: [perfilId]);

    if (res.isEmpty) return null;
    final evaluacionMap = {for (var e in res[0].entries) e.key: e.value};
    final evaluacionModel = EvaluacionModel.fromJson(evaluacionMap);

    return evaluacionModel;
  }

  @override
  Future<int> saveEvaluacionDB(EvaluacionEntity evaluacionEntity) async {
    final db = await DBConfig.database;
    if (evaluacionEntity.recordStatus != 'N') {
      evaluacionEntity.recordStatus = 'E';
    }
    final res = await db.update('Evaluacion', evaluacionEntity.toJson(),
        where: 'EvaluacionId = ?', whereArgs: [evaluacionEntity.evaluacionId]);

    return res;
  }

  @override
  Future<int> saveEvaluacionesDB(
      List<EvaluacionEntity> evaluacionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Evaluacion');

    for (var evaluacion in evaluacionEntity) {
      evaluacion.recordStatus = 'R';
      evaluacion.remoteEvaluacionId = evaluacion.evaluacionId;

      batch.insert('Evaluacion', evaluacion.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<EvaluacionModel>> getEvaluacionesProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db
        .query('Evaluacion', where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final evaluacionesModel =
        List<EvaluacionModel>.from(res.map((m) => EvaluacionModel.fromJson(m)))
            .toList();

    /* for (var evaluacion in evaluacionesModel) {
      if (evaluacion.recordStatus == 'N') {
        evaluacion.evaluacionId = '0';
      }
    } */

    return evaluacionesModel;
  }

  @override
  Future<List<String>> updateEvaluacionesProduccionDB(
      List<EvaluacionEntity> evaluacionesProduccionEntity) async {
    List<String> perfilIdsEvaluacionesNews = [];
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var evaluacionProduccion in evaluacionesProduccionEntity) {
      if (evaluacionProduccion.recordStatus == 'N') {
        perfilIdsEvaluacionesNews.add(evaluacionProduccion.perfilId!);
        batch.delete('Evaluacion',
            where: 'EvaluacionId = ?',
            whereArgs: [evaluacionProduccion.evaluacionId]);
        batch.delete('EvaluacionRespuesta',
            where: 'EvaluacionId = ?',
            whereArgs: [evaluacionProduccion.evaluacionId]);
      } else {
        evaluacionProduccion.recordStatus = 'R';
        batch.update('Evaluacion', evaluacionProduccion.toJson(),
            where: 'EvaluacionId = ?',
            whereArgs: [evaluacionProduccion.evaluacionId]);
      }
    }

    await batch.commit();

    return perfilIdsEvaluacionesNews;
  }

  @override
  Future<int> clearEvaluacionesDB() async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Evaluacion');

    final res = await batch.commit();

    return res.length;
  }
}
