import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../../domain/entities/perfil_preinversion_precio_entity.dart';
import '../../../models/perfil_preinversion_precio_model.dart';

abstract class PerfilPreInversionPrecioLocalDataSource {
  Future<List<PerfilPreInversionPrecioModel>> getPerfilPreInversionPreciosDB();
  Future<PerfilPreInversionPrecioModel?> getPerfilPreInversionPrecioDB(
      String id);
  Future<int> savePerfilPreInversionPrecios(
      List<PerfilPreInversionPrecioEntity> perfilPreInversionPrecioEntity);
}

class PerfilPreInversionPrecioLocalDataSourceImpl
    implements PerfilPreInversionPrecioLocalDataSource {
  static createPerfilPreInversionPrecioTable(Database db) async {
    await db.execute('''
     CREATE TABLE PerfilPreInversionPrecio (
      PerfilPreInversionId	TEXT NOT NULL,
      ProductoId	TEXT NOT NULL,
      TipoCalidadId	TEXT NOT NULL,
      Precio	TEXT,
      UnidadId	TEXT NOT NULL,
      FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId),
      FOREIGN KEY(TipoCalidadId) REFERENCES TipoCalidad(TipoCalidadId),
      FOREIGN KEY(UnidadId) REFERENCES Unidad(UnidadId),
      FOREIGN KEY(ProductoId) REFERENCES Producto(ProductoId)
    )
    ''');
  }

  @override
  Future<List<PerfilPreInversionPrecioModel>>
      getPerfilPreInversionPreciosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionPrecio');

    final perfilPreInversionPrecio = List<PerfilPreInversionPrecioModel>.from(
        res.map((m) => PerfilPreInversionPrecioModel.fromJson(m))).toList();

    return perfilPreInversionPrecio;
  }

  @override
  Future<PerfilPreInversionPrecioModel?> getPerfilPreInversionPrecioDB(
      String id) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionPrecio',
        where: 'PerfilPreInversionId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final perfilPreInversionPrecioMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilPreInversionPrecioModel =
        PerfilPreInversionPrecioModel.fromJson(perfilPreInversionPrecioMap);

    return perfilPreInversionPrecioModel;
  }

  @override
  Future<int> savePerfilPreInversionPrecios(
      List<PerfilPreInversionPrecioEntity>
          perfilPreInversionPrecioEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversionPrecio');

    for (var perfilPreInversionPrecio in perfilPreInversionPrecioEntity) {
      batch.insert(
          'PerfilPreInversionPrecio', perfilPreInversionPrecio.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
