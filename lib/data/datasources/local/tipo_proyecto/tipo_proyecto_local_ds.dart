import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/tipo_proyecto_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/tipo_proyecto_model.dart';

abstract class TipoProyectoLocalDataSource {
  Future<List<TipoProyectoModel>> getTiposProyectosDB();
  Future<int> saveTiposProyectos(List<TipoProyectoEntity> tipoproyectoEntity);
}

class TipoProyectoLocalDataSourceImpl implements TipoProyectoLocalDataSource {
  static createTipoProyectoTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS TipoProyecto (
        TipoProyectoId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        PRIMARY KEY(TipoProyectoId)
      )
    ''');
  }

  @override
  Future<List<TipoProyectoModel>> getTiposProyectosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('TipoProyecto');

    final tipoproyectosDB = List<TipoProyectoModel>.from(
        res.map((m) => TipoProyectoModel.fromJson(m))).toList();

    return tipoproyectosDB;
  }

  @override
  Future<int> saveTiposProyectos(
      List<TipoProyectoEntity> tipoproyectoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('TipoProyecto');

    for (var tipoproyecto in tipoproyectoEntity) {
      batch.insert('TipoProyecto', tipoproyecto.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
