import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/rubro_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/rubro_model.dart';

abstract class RubroLocalDataSource {
  Future<List<RubroModel>> getRubrosDB();
  Future<int> saveRubros(List<RubroEntity> rubroEntity);
}

class RubroLocalDataSourceImpl implements RubroLocalDataSource {
  static createRubroTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Rubro (
        RubroId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        Activo	TEXT,
        ActividadFinancieraId	TEXT,
        PRIMARY KEY(RubroId)
      )
    ''');
  }

  @override
  Future<List<RubroModel>> getRubrosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Rubro');

    final rubrosDB =
        List<RubroModel>.from(res.map((m) => RubroModel.fromJson(m))).toList();

    return rubrosDB;
  }

  @override
  Future<int> saveRubros(List<RubroEntity> rubroEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Rubro');

    for (var rubro in rubroEntity) {
      batch.insert('Rubro', rubro.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
