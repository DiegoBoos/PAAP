import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/producto_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/producto_model.dart';

abstract class ProductoLocalDataSource {
  Future<List<ProductoModel>> getProductosDB(String perfilPreInversionId);
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
  Future<List<ProductoModel>> getProductosDB(
      String perfilPreInversionId) async {
    final db = await DBConfig.database;

    String sql = ''' select 
    Producto.ProductoId,
    Producto.Nombre,
    Producto.Unidad,
    Producto.Simbolo,
    Producto.EsProducto,
    Producto.EsAsociado
    from PerfilPreInversion
    inner join Producto  on (Producto.ProductoId = PerfilPreInversion.ProductoId)
    where PerfilPreInversion.PerfilPreInversionId = $perfilPreInversionId
    union all
    select 
    Producto.ProductoId,
    Producto.Nombre,
    Producto.Unidad,
    Producto.Simbolo,
    Producto.EsProducto,
    Producto.EsAsociado
    from PerfilPreInversion
    inner join Producto  on (Producto.ProductoId = PerfilPreInversion.ProductoAsociadoId)
    where PerfilPreInversion.PerfilPreInversionId = $perfilPreInversionId ''';

    final res = await db.rawQuery(sql);

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
