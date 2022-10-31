import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/genero_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/genero_model.dart';

abstract class GeneroLocalDataSource {
  Future<List<GeneroModel>> getGenerosDB();
  Future<int> saveGeneros(List<GeneroEntity> generoEntity);
}

class GeneroLocalDataSourceImpl implements GeneroLocalDataSource {
  static createGeneroTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Genero (
        GeneroId	TEXT NOT NULL,
        Nombre	TEXT,
        PRIMARY KEY(GeneroId)
      )
    ''');
  }

  @override
  Future<List<GeneroModel>> getGenerosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Genero');

    final generosDB =
        List<GeneroModel>.from(res.map((m) => GeneroModel.fromJson(m)))
            .toList();

    return generosDB;
  }

  @override
  Future<int> saveGeneros(List<GeneroEntity> generoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Genero');

    for (var genero in generoEntity) {
      batch.insert('Genero', genero.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
