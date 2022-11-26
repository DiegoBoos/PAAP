import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/criterio_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/criterio_model.dart';

abstract class CriterioLocalDataSource {
  Future<List<CriterioModel>> getCriteriosDB(String agrupacionId);
  Future<int> saveCriterios(List<CriterioEntity> criterioEntity);
}

class CriterioLocalDataSourceImpl implements CriterioLocalDataSource {
  static createCriterioTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Criterio (
        CriterioId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        Variable	TEXT,
        ValorMaximo	TEXT,
        AgrupacionId	TEXT,
        PRIMARY KEY(CriterioId),
        FOREIGN KEY(AgrupacionId) REFERENCES Agrupacion(AgrupacionId)
      )
    ''');
  }

  @override
  Future<List<CriterioModel>> getCriteriosDB(String agrupacionId) async {
    final db = await DBConfig.database;

    final res = await db.query('Criterio',
        where: 'AgrupacionId = ?', whereArgs: [agrupacionId]);

    final criteriosDB =
        List<CriterioModel>.from(res.map((m) => CriterioModel.fromJson(m)))
            .toList();

    return criteriosDB;
  }

  @override
  Future<int> saveCriterios(List<CriterioEntity> criterioEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Criterio');

    for (var criterio in criterioEntity) {
      batch.insert('Criterio', criterio.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
