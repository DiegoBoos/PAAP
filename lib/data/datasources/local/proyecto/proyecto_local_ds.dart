import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/proyecto_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/proyecto_model.dart';

abstract class ProyectoLocalDataSource {
  Future<List<ProyectoModel>> getProyectosDB();
  Future<int> saveProyectos(List<ProyectoEntity> proyectoEntity);
}

class ProyectoLocalDataSourceImpl implements ProyectoLocalDataSource {
  static createProyectoTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Proyecto (
        ProyectoId	TEXT NOT NULL,
        Nombre	TEXT,
        Objetivo	TEXT,
        FechaInicial	TEXT,
        FechaFinal	TEXT,
        FechaRegistro	TEXT,
        YearInicial	TEXT,
        YearFinal	TEXT,
        PRIMARY KEY(ProyectoId)
      )
    ''');
  }

  @override
  Future<List<ProyectoModel>> getProyectosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Proyecto');

    final proyectosDB =
        List<ProyectoModel>.from(res.map((m) => ProyectoModel.fromJson(m)))
            .toList();

    return proyectosDB;
  }

  @override
  Future<int> saveProyectos(List<ProyectoEntity> proyectoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Proyecto');

    for (var proyecto in proyectoEntity) {
      batch.insert('Proyecto', proyecto.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
