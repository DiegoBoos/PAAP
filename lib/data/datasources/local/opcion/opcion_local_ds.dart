import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/opcion_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/opcion_model.dart';

abstract class OpcionLocalDataSource {
  Future<List<OpcionModel>> getOpcionesDB(String criterioId);
  Future<int> saveOpciones(List<OpcionEntity> opcionEntity);
}

class OpcionLocalDataSourceImpl implements OpcionLocalDataSource {
  static createOpcionTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Opcion (
        OpcionId	TEXT NOT NULL,
        Nombre	TEXT,
        Calificacion	TEXT,
        CriterioId	TEXT,
        PRIMARY KEY(OpcionId)
      )
    ''');
  }

  @override
  Future<List<OpcionModel>> getOpcionesDB(String criterioId) async {
    final db = await DBConfig.database;

    final res = await db
        .query('Opcion', where: 'CriterioId = ?', whereArgs: [criterioId]);

    final opcionsDB =
        List<OpcionModel>.from(res.map((m) => OpcionModel.fromJson(m)))
            .toList();

    return opcionsDB;
  }

  @override
  Future<int> saveOpciones(List<OpcionEntity> opcionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Opcion');

    for (var opcion in opcionEntity) {
      batch.insert('Opcion', opcion.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
