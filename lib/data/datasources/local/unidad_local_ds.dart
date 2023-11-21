import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/unidad_entity.dart';
import '../../db/db_config.dart';
import '../../models/unidad_model.dart';

abstract class UnidadLocalDataSource {
  Future<List<UnidadModel>> getUnidadesDB();
  Future<int> saveUnidades(List<UnidadEntity> unidadEntity);
}

class UnidadLocalDataSourceImpl implements UnidadLocalDataSource {
  static createUnidadTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Unidad (
        UnidadId	TEXT NOT NULL,
        Nombre	TEXT,
        Simbolo	TEXT,
        PRIMARY KEY(UnidadId)
      )
    ''');
  }

  @override
  Future<List<UnidadModel>> getUnidadesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Unidad');

    final unidadsDB =
        List<UnidadModel>.from(res.map((m) => UnidadModel.fromJson(m)))
            .toList();

    return unidadsDB;
  }

  @override
  Future<int> saveUnidades(List<UnidadEntity> unidadEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Unidad');

    for (var unidad in unidadEntity) {
      batch.insert('Unidad', unidad.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
