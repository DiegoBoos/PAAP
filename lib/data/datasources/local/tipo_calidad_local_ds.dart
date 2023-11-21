import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/tipo_calidad_entity.dart';
import '../../db/db_config.dart';
import '../../models/tipo_calidad_model.dart';

abstract class TipoCalidadLocalDataSource {
  Future<List<TipoCalidadModel>> getTiposCalidadesDB();
  Future<int> saveTiposCalidades(List<TipoCalidadEntity> tipocalidadEntity);
}

class TipoCalidadLocalDataSourceImpl implements TipoCalidadLocalDataSource {
  static createTipoCalidadTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS TipoCalidad (
        TipoCalidadId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        PRIMARY KEY(TipoCalidadId)
      )
    ''');
  }

  @override
  Future<List<TipoCalidadModel>> getTiposCalidadesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('TipoCalidad');

    final tipocalidadesDB = List<TipoCalidadModel>.from(
        res.map((m) => TipoCalidadModel.fromJson(m))).toList();

    return tipocalidadesDB;
  }

  @override
  Future<int> saveTiposCalidades(
      List<TipoCalidadEntity> tipocalidadEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('TipoCalidad');

    for (var tipocalidad in tipocalidadEntity) {
      batch.insert('TipoCalidad', tipocalidad.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
