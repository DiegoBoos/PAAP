import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/frecuencia_model.dart';

abstract class FrecuenciaLocalDataSource {
  Future<List<FrecuenciaModel>> getFrecuenciasDB();
  Future<int> saveFrecuencias(List<FrecuenciaEntity> frecuenciaEntity);
}

class FrecuenciaLocalDataSourceImpl implements FrecuenciaLocalDataSource {
  static createFrecuenciaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Frecuencia (
        FrecuenciaId	TEXT NOT NULL,
        Nombre	TEXT,
        PRIMARY KEY(FrecuenciaId)
      )
    ''');
  }

  @override
  Future<List<FrecuenciaModel>> getFrecuenciasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Frecuencia');

    final frecuenciasDB =
        List<FrecuenciaModel>.from(res.map((m) => FrecuenciaModel.fromJson(m)))
            .toList();

    return frecuenciasDB;
  }

  @override
  Future<int> saveFrecuencias(List<FrecuenciaEntity> frecuenciaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Frecuencia');

    for (var frecuencia in frecuenciaEntity) {
      batch.insert('Frecuencia', frecuencia.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
