import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/tipo_movimiento_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/tipo_movimiento_model.dart';

abstract class TipoMovimientoLocalDataSource {
  Future<List<TipoMovimientoModel>> getTiposMovimientosDB();
  Future<int> saveTiposMovimientos(
      List<TipoMovimientoEntity> tipomovimientoEntity);
}

class TipoMovimientoLocalDataSourceImpl
    implements TipoMovimientoLocalDataSource {
  static createTipoMovimientoTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS TipoMovimiento (
        TipoMovimientoId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        PRIMARY KEY(TipoMovimientoId)
      )
    ''');
  }

  @override
  Future<List<TipoMovimientoModel>> getTiposMovimientosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('TipoMovimiento');

    final tipomovimientosDB = List<TipoMovimientoModel>.from(
        res.map((m) => TipoMovimientoModel.fromJson(m))).toList();

    return tipomovimientosDB;
  }

  @override
  Future<int> saveTiposMovimientos(
      List<TipoMovimientoEntity> tipomovimientoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('TipoMovimiento');

    for (var tipomovimiento in tipomovimientoEntity) {
      batch.insert('TipoMovimiento', tipomovimiento.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
