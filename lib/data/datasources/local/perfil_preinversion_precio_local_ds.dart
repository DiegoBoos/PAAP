import 'package:sqflite/sqflite.dart';

import '../../../domain/db/db_config.dart';
import '../../../domain/entities/perfil_preinversion_precio_entity.dart';
import '../../models/perfil_preinversion_precio_model.dart';

abstract class PerfilPreInversionPrecioLocalDataSource {
  Future<List<PerfilPreInversionPrecioModel>> getPerfilPreInversionPrecios();

  Future<List<PerfilPreInversionPrecioModel>> getPerfilesPreInversionesPrecios(
      String perfilPreInversionId);

  Future<PerfilPreInversionPrecioModel?> getPerfilPreInversionPrecio(
      String perfilPreInversionId);

  Future<int> savePerfilPreInversionPrecios(
      List<PerfilPreInversionPrecioEntity> perfilPreInversionPrecioEntity);

  Future<int> savePerfilPreInversionPrecio(
      PerfilPreInversionPrecioEntity perfilPreInversionPrecioEntity);

  Future<List<PerfilPreInversionPrecioModel>>
      getPerfilesPreInversionesPreciosProduccion();

  Future<int> deletePerfilesPreInversionesPreciosDB(
      String perfilPreInversionId, String productoId, String tipoCalidadId);

  Future<int> updatePerfilesPreInversionesPreciosProduccion(
      List<PerfilPreInversionPrecioEntity>
          perfilesPreInversionesPreciosProduccionEntity);
}

class PerfilPreInversionPrecioLocalDataSourceImpl
    implements PerfilPreInversionPrecioLocalDataSource {
  static createPerfilPreInversionPrecioTable(Database db) async {
    await db.execute('''
     CREATE TABLE IF NOT EXISTS PerfilPreInversionPrecio (
      PerfilPreInversionId	TEXT NOT NULL,
      ProductoId	TEXT NOT NULL,
      TipoCalidadId	TEXT NOT NULL,
      Precio	TEXT,
      UnidadId	TEXT NOT NULL,
      RecordStatus	TEXT,
      FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId),
      FOREIGN KEY(TipoCalidadId) REFERENCES TipoCalidad(TipoCalidadId),
      FOREIGN KEY(UnidadId) REFERENCES Unidad(UnidadId),
      FOREIGN KEY(ProductoId) REFERENCES Producto(ProductoId)
    )
    ''');
  }

  @override
  Future<List<PerfilPreInversionPrecioModel>>
      getPerfilPreInversionPrecios() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionPrecio');

    final perfilPreInversionPrecio = List<PerfilPreInversionPrecioModel>.from(
        res.map((m) => PerfilPreInversionPrecioModel.fromJson(m))).toList();

    return perfilPreInversionPrecio;
  }

  @override
  Future<List<PerfilPreInversionPrecioModel>> getPerfilesPreInversionesPrecios(
      String perfilPreInversionId) async {
    final db = await DBConfig.database;

    String sql = '''
      select 
      PerfilPreInversionPrecio.PerfilPreInversionId,
      PerfilPreInversionPrecio.ProductoId,
      PerfilPreInversionPrecio.UnidadId,
      PerfilPreInversionPrecio.TipoCalidadId,
      PerfilPreInversionPrecio.Precio,
      Producto.Nombre as Producto,
      Unidad.Nombre as Unidad,
      TipoCalidad.Nombre as TipoCalidad
      from PerfilPreInversionPrecio
      left join Producto on (Producto.ProductoId=PerfilPreInversionPrecio.ProductoId)
      left join Unidad on (Unidad.UnidadId=PerfilPreInversionPrecio.UnidadId)
      left join TipoCalidad on (TipoCalidad.TipoCalidadId=PerfilPreInversionPrecio.TipoCalidadId)
      where PerfilPreInversionPrecio.PerfilPreInversionId = $perfilPreInversionId
      ''';

    final res = await db.rawQuery(sql);

    if (res.isEmpty) return [];

    final perfilPreInversionPrecio = List<PerfilPreInversionPrecioModel>.from(
        res.map((m) => PerfilPreInversionPrecioModel.fromJson(m))).toList();

    return perfilPreInversionPrecio;
  }

  @override
  Future<PerfilPreInversionPrecioModel?> getPerfilPreInversionPrecio(
      String perfilPreInversionId) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionPrecio',
        where: 'PerfilPreInversionId = ?', whereArgs: [perfilPreInversionId]);

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
      perfilPreInversionPrecio.recordStatus = 'R';
      batch.insert(
          'PerfilPreInversionPrecio', perfilPreInversionPrecio.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> savePerfilPreInversionPrecio(
      PerfilPreInversionPrecioEntity perfilPreInversionPrecioEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilPreInversionPrecio',
        where:
            'PerfilPreinversionId = ? AND ProductoId = ? AND TipoCalidadId = ?',
        whereArgs: [
          perfilPreInversionPrecioEntity.perfilPreInversionId,
          perfilPreInversionPrecioEntity.productoId,
          perfilPreInversionPrecioEntity.tipoCalidadId,
        ]);

    if (resQuery.isEmpty) {
      perfilPreInversionPrecioEntity.recordStatus = 'N';
      batch.insert(
          'PerfilPreInversionPrecio', perfilPreInversionPrecioEntity.toJson());
    } else {
      perfilPreInversionPrecioEntity.recordStatus = 'E';
      batch.update(
          'PerfilPreInversionPrecio', perfilPreInversionPrecioEntity.toJson(),
          where:
              'PerfilPreinversionId = ? AND ProductoId = ? AND TipoCalidadId = ?',
          whereArgs: [
            perfilPreInversionPrecioEntity.perfilPreInversionId,
            perfilPreInversionPrecioEntity.productoId,
            perfilPreInversionPrecioEntity.tipoCalidadId,
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionPrecioModel>>
      getPerfilesPreInversionesPreciosProduccion() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionPrecio',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final perfilesPreInversionesPreciosModel =
        List<PerfilPreInversionPrecioModel>.from(
            res.map((m) => PerfilPreInversionPrecioModel.fromJson(m))).toList();

    return perfilesPreInversionesPreciosModel;
  }

  @override
  Future<int> updatePerfilesPreInversionesPreciosProduccion(
      List<PerfilPreInversionPrecioEntity>
          perfilesPreInversionesPreciosProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var perfilPreInversionPrecioProduccion
        in perfilesPreInversionesPreciosProduccionEntity) {
      perfilPreInversionPrecioProduccion.recordStatus = 'R';
      batch.update('PerfilPreInversionPrecio',
          perfilPreInversionPrecioProduccion.toJson(),
          where:
              'PerfilPreinversionId = ? AND ProductoId = ? AND TipoCalidadId = ?',
          whereArgs: [
            perfilPreInversionPrecioProduccion.perfilPreInversionId,
            perfilPreInversionPrecioProduccion.productoId,
            perfilPreInversionPrecioProduccion.tipoCalidadId,
          ]);
    }

    final query = await db.query('PerfilPreInversionPrecio',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    await batch.commit();

    return query.length;
  }

  @override
  Future<int> deletePerfilesPreInversionesPreciosDB(String perfilPreInversionId,
      String productoId, String tipoCalidadId) async {
    final db = await DBConfig.database;

    final resQuery = await db.query('PerfilPreInversionPrecio',
        where:
            'PerfilPreInversionId = ? AND PrecioId = ? AND TipoCalidadId = ?',
        whereArgs: [perfilPreInversionId, productoId, tipoCalidadId]);
    if (resQuery.isEmpty) return 0;
    final perfilPreInversionPrecioMap = {
      for (var e in resQuery[0].entries) e.key: e.value
    };
    final perfilPreInversionPrecioModel =
        PerfilPreInversionPrecioModel.fromJson(perfilPreInversionPrecioMap);

    if (perfilPreInversionPrecioModel.recordStatus == 'N') {
      final res = await db.delete('PerfilPreInversionPrecio',
          where:
              'PerfilPreInversionId = ? AND PrecioId = ? AND TipoCalidadId = ?',
          whereArgs: [perfilPreInversionId, productoId, tipoCalidadId]);
      return res;
    } else {
      final objUpdate = {
        'perfilPreInversionId':
            perfilPreInversionPrecioModel.perfilPreInversionId,
        'ProductoId': perfilPreInversionPrecioModel.productoId,
        'TipoCalidadId': perfilPreInversionPrecioModel.tipoCalidadId,
        'Precio': perfilPreInversionPrecioModel.precio,
        'UnidadId': perfilPreInversionPrecioModel.unidadId,
        'recordStatus': 'D',
      };
      final res = await db.update(
        'PerfilPreInversionPrecio',
        objUpdate,
        where:
            'PerfilPreInversionId = ? AND PrecioId = ? AND TipoCalidadId = ?',
        whereArgs: [perfilPreInversionId, productoId, tipoCalidadId],
      );
      return res;
    }
  }
}
