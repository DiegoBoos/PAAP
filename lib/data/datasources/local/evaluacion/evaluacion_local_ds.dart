import 'package:paap/data/models/evaluacion_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/evaluacion_entity.dart';
import '../../../../domain/db/db_config.dart';

abstract class EvaluacionLocalDataSource {
  Future<EvaluacionModel?> getEvaluacionDB(String perfilId);
  Future<int> saveEvaluacionDB(EvaluacionEntity evaluacionEntity);
  Future<int> saveEvaluacionesDB(List<EvaluacionEntity> evaluacionEntity);
  Future<int> clearEvaluacionesDB();
}

class EvaluacionLocalDataSourceImpl implements EvaluacionLocalDataSource {
  static createEvaluacionTable(Database db) async {
    await db.execute('''
      CREATE TABLE Evaluacion (
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
        PRIMARY KEY(EvaluacionId)
      )
    ''');
    await db.execute('''
      CREATE TABLE EvaluacionProduccion (
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

    var batch = db.batch();
    batch.delete('Evaluacion');

    batch.insert('Evaluacion', evaluacionEntity.toJson());

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveEvaluacionesDB(
      List<EvaluacionEntity> evaluacionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Evaluacion');

    for (var evaluacion in evaluacionEntity) {
      batch.insert('Evaluacion', evaluacion.toJson());
    }

    final res = await batch.commit();

    return res.length;
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
