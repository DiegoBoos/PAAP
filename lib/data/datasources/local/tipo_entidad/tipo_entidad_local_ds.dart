import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/tipo_entidad_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/tipo_entidad_model.dart';

abstract class TipoEntidadLocalDataSource {
  Future<List<TipoEntidadModel>> getTiposEntidadesDB();
  Future<int> saveTiposEntidades(List<TipoEntidadEntity> tipoEntidadEntity);
}

class TipoEntidadLocalDataSourceImpl implements TipoEntidadLocalDataSource {
  static createTipoEntidadTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS TipoEntidad (
        TipoEntidadId	TEXT NOT NULL,
        Nombre	TEXT,
        PRIMARY KEY(TipoEntidadId)
      )
    ''');
  }

  @override
  Future<List<TipoEntidadModel>> getTiposEntidadesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('TipoEntidad');

    final tipoEntidadesDB = List<TipoEntidadModel>.from(
        res.map((m) => TipoEntidadModel.fromJson(m))).toList();

    return tipoEntidadesDB;
  }

  @override
  Future<int> saveTiposEntidades(
      List<TipoEntidadEntity> tipoEntidadEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('TipoEntidad');

    for (var tipoEntidad in tipoEntidadEntity) {
      batch.insert('TipoEntidad', tipoEntidad.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
