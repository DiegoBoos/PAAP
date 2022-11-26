import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/tipo_tenencia_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/tipo_tenencia_model.dart';

abstract class TipoTenenciaLocalDataSource {
  Future<List<TipoTenenciaModel>> getTiposTenenciasDB();
  Future<int> saveTiposTenencias(List<TipoTenenciaEntity> tipotenenciaEntity);
}

class TipoTenenciaLocalDataSourceImpl implements TipoTenenciaLocalDataSource {
  static createTipoTenenciaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS TipoTenencia (
        TipoTenenciaId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        PRIMARY KEY(TipoTenenciaId)
      )
    ''');
  }

  @override
  Future<List<TipoTenenciaModel>> getTiposTenenciasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('TipoTenencia');

    final tipotenenciasDB = List<TipoTenenciaModel>.from(
        res.map((m) => TipoTenenciaModel.fromJson(m))).toList();

    return tipotenenciasDB;
  }

  @override
  Future<int> saveTiposTenencias(
      List<TipoTenenciaEntity> tipotenenciaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('TipoTenencia');

    for (var tipotenencia in tipotenenciaEntity) {
      batch.insert('TipoTenencia', tipotenencia.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
