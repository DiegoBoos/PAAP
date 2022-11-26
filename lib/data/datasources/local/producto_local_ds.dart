import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/producto_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/producto_model.dart';

abstract class ProductoLocalDataSource {
  Future<List<ProductoModel>> getProductosDB();
  Future<int> saveProductos(List<ProductoEntity> productoEntity);
}

class ProductoLocalDataSourceImpl implements ProductoLocalDataSource {
  static createProductoTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Producto (
        ProductoId	TEXT,
        Nombre	TEXT,
        Unidad	TEXT,
        Simbolo	TEXT,
        EsProducto	TEXT,
        EsAsociado	TEXT,
        PRIMARY KEY(ProductoId)
      )
    ''');
  }

  @override
  Future<List<ProductoModel>> getProductosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Producto');

    final productosDB =
        List<ProductoModel>.from(res.map((m) => ProductoModel.fromJson(m)))
            .toList();

    return productosDB;
  }

  @override
  Future<int> saveProductos(List<ProductoEntity> productoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Producto');

    for (var producto in productoEntity) {
      batch.insert('Producto', producto.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
