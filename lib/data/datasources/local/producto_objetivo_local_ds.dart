import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/producto_objetivo_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/producto_objetivo_model.dart';

abstract class ProductoObjetivoLocalDataSource {
  Future<List<ProductoObjetivoModel>> getProductosObjetivosDB();
  Future<int> saveProductosObjetivos(
      List<ProductoObjetivoEntity> productoObjetivoEntity);
}

class ProductoObjetivoLocalDataSourceImpl
    implements ProductoObjetivoLocalDataSource {
  static createProductoObjetivoTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ProductoObjetivo (
        ProductoObjetivoId	TEXT NOT NULL,
        Nombre	TEXT,
        UnidadId	TEXT,
        ObjetivoId	TEXT,
        Objetivo	TEXT,
        Proyecto	TEXT,
        Unidad	TEXT,
        PRIMARY KEY(ProductoObjetivoId)
      )
    ''');
  }

  @override
  Future<List<ProductoObjetivoModel>> getProductosObjetivosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('ProductoObjetivo');

    final productosProductoObjetivosDB = List<ProductoObjetivoModel>.from(
        res.map((m) => ProductoObjetivoModel.fromJson(m))).toList();

    return productosProductoObjetivosDB;
  }

  @override
  Future<int> saveProductosObjetivos(
      List<ProductoObjetivoEntity> productoObjetivoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('ProductoObjetivo');

    for (var productoObjetivo in productoObjetivoEntity) {
      batch.insert('ProductoObjetivo', productoObjetivo.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
