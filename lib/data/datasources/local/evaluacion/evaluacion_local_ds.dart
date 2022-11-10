import 'package:paap/data/models/evaluacion_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/evaluacion_entity.dart';
import '../../../../domain/db/db_config.dart';

abstract class EvaluacionLocalDataSource {
  Future<EvaluacionModel?> getEvaluacionDB(String id);
  Future<int> saveEvaluacionDB(EvaluacionEntity evaluacionEntity);
  Future<int> clearEvaluacionesDB();
}

class EvaluacionLocalDataSourceImpl implements EvaluacionLocalDataSource {
  static createEvaluacionTable(Database db) async {
    await db.execute('''
      CREATE TABLE Evaluacion (
        PerfilId	TEXT NOT NULL,
        TipoEvaluacionId	TEXT NOT NULL,
        FechaInicial	TEXT,
        FechaFinal	TEXT,
        EstadoEvaluacionId	TEXT NOT NULL,
        Observacion	TEXT,
        UsuarioId	TEXT NOT NULL,
        FechaRegistro	TEXT,
        FOREIGN KEY(EstadoEvaluacionId) REFERENCES EstadoEvaluacion(EstadoEvaluacionId),
        FOREIGN KEY(TipoEvaluacionId) REFERENCES TipoEvaluacion(TipoEvaluacionId),
        FOREIGN KEY(UsuarioId) REFERENCES Usuario(UsuarioId),
        FOREIGN KEY(PerfilId) REFERENCES Perfil(PerfilId)
      )
    ''');
  }

  @override
  Future<EvaluacionModel?> getEvaluacionDB(String id) async {
    final db = await DBConfig.database;
    final res = await db
        .query('Evaluacion', where: 'TipoEvaluacionId = ?', whereArgs: [id]);

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
  Future<int> clearEvaluacionesDB() async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Evaluacion');

    final res = await batch.commit();

    return res.length;
  }
}
