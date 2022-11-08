import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/tipo_discapacidad_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/tipo_discapacidad_model.dart';

abstract class TipoDiscapacidadLocalDataSource {
  Future<List<TipoDiscapacidadModel>> getTiposCalidadesDB();
  Future<int> saveTiposCalidades(
      List<TipoDiscapacidadEntity> tipoDiscapacidadEntity);
}

class TipoDiscapacidadLocalDataSourceImpl
    implements TipoDiscapacidadLocalDataSource {
  static createTipoDiscapacidadTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS TipoDiscapacidad (
        TipoDiscapacidadId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        PRIMARY KEY(TipoDiscapacidadId)
      )
    ''');
  }

  @override
  Future<List<TipoDiscapacidadModel>> getTiposCalidadesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('TipoDiscapacidad');

    final tipodiscapacidadesDB = List<TipoDiscapacidadModel>.from(
        res.map((m) => TipoDiscapacidadModel.fromJson(m))).toList();

    return tipodiscapacidadesDB;
  }

  @override
  Future<int> saveTiposCalidades(
      List<TipoDiscapacidadEntity> tipoDiscapacidadEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('TipoDiscapacidad');

    for (var tipodiscapacidad in tipoDiscapacidadEntity) {
      batch.insert('TipoDiscapacidad', tipodiscapacidad.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
