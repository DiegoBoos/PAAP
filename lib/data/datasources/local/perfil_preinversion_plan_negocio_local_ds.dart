import 'package:sqflite/sqflite.dart';

import '../../../domain/db/db_config.dart';
import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../models/perfil_preinversion_plan_negocio_model.dart';
import '../../models/v_perfil_preinversion_plan_negocio_model.dart';

abstract class PerfilPreInversionPlanNegocioLocalDataSource {
  Future<List<PerfilPreInversionPlanNegocioModel>>
      getPerfilPreInversionPlanNegocios();

  Future<List<VPerfilPreInversionPlanNegocioModel>>
      getVPerfilesPreInversionesPlanNegocios(
          String perfilPreInversionId, String tipoMovimientoId);

  Future<int> savePerfilPreInversionPlanNegocios(
      List<PerfilPreInversionPlanNegocioEntity>
          perfilPreInversionPlanNegocioEntity);

  Future<VPerfilPreInversionPlanNegocioModel> savePerfilPreInversionPlanNegocio(
      PerfilPreInversionPlanNegocioEntity perfilPreInversionPlanNegocioEntity,
      String tipoMovimientoId);

  Future<List<PerfilPreInversionPlanNegocioModel>>
      getPerfilesPreInversionesPlanNegociosProduccion();

  Future<int> updatePerfilesPreInversionesPlanNegociosProduccion(
      List<PerfilPreInversionPlanNegocioEntity>
          perfilesPreInversionesPlanNegociosProduccionEntity);
}

class PerfilPreInversionPlanNegocioLocalDataSourceImpl
    implements PerfilPreInversionPlanNegocioLocalDataSource {
  static createPerfilPreInversionPlanNegocioTable(Database db) async {
    await db.execute('''
     CREATE TABLE PerfilPreInversionPlanNegocio (
      PerfilPreInversionId	TEXT NOT NULL,
      RubroId	TEXT NOT NULL,
      Year	TEXT NOT NULL,
      Valor	TEXT,
      Cantidad	TEXT NOT NULL,
      UnidadId	TEXT NOT NULL,
      ProductoId	TEXT NOT NULL,
      TipoCalidadId	TEXT NOT NULL,
      RecordStatus	TEXT
    )
    ''');
  }

  @override
  Future<List<PerfilPreInversionPlanNegocioModel>>
      getPerfilPreInversionPlanNegocios() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionPlanNegocio');

    final perfilPreInversionPlanNegocio =
        List<PerfilPreInversionPlanNegocioModel>.from(
                res.map((m) => PerfilPreInversionPlanNegocioModel.fromJson(m)))
            .toList();

    return perfilPreInversionPlanNegocio;
  }

  @override
  Future<List<VPerfilPreInversionPlanNegocioModel>>
      getVPerfilesPreInversionesPlanNegocios(
          String perfilPreInversionId, String tipoMovimientoId) async {
    final db = await DBConfig.database;

    String sql = ''' 
    select 
    ActividadFinanciera.ActividadFinancieraId as ActividadFinancieraId,
    ActividadFinanciera.Nombre as ActividadFinanciera,
    PerfilPreInversionPlanNegocio.RubroId,
    Rubro.Nombre as Rubro,
    Unidad.UnidadId as UnidadId,
    Unidad.Nombre as Unidad,
    Year,
    Cantidad,
    Valor,
    Producto.productoId as ProductoId,
    TipoCalidad.tipoCalidadId as TipoCalidadId,
    round(PerfilPreInversionPlanNegocio.Valor / ( SELECT  SUM(Valor)
    FROM  PerfilPreInversionPlanNegocio
    WHERE TipoMovimiento.TipoMovimientoId = $tipoMovimientoId) * 100, 3)
    as Porcentaje
    from PerfilPreInversionPlanNegocio
    inner join Rubro on (PerfilPreInversionPlanNegocio.RubroId=Rubro.RubroId)
    inner join ActividadFinanciera on(rubro.ActividadFinancieraId=ActividadFinanciera.ActividadFinancieraId)
    inner join TipoMovimiento on(TipoMovimiento.TipoMovimientoId=ActividadFinanciera.TipoMovimientoId)
    inner join Unidad on(unidad.UnidadId=PerfilPreInversionPlanNegocio.UnidadId)
    left join Producto on(Producto.ProductoId=PerfilPreInversionPlanNegocio.ProductoId)
    left join TipoCalidad on(TipoCalidad.TipoCalidadId=PerfilPreInversionPlanNegocio.TipoCalidadId)
    where TipoMovimiento.TipoMovimientoId = $tipoMovimientoId AND PerfilPreInversionPlanNegocio.PerfilPreInversionId = $perfilPreInversionId
    ''';

    final res = await db.rawQuery(sql);

    if (res.isEmpty) return [];

    final perfilesPreInversionesPlanNegociosModel =
        List<VPerfilPreInversionPlanNegocioModel>.from(
                res.map((m) => VPerfilPreInversionPlanNegocioModel.fromJson(m)))
            .toList();

    return perfilesPreInversionesPlanNegociosModel;
  }

  @override
  Future<int> savePerfilPreInversionPlanNegocios(
      List<PerfilPreInversionPlanNegocioEntity>
          perfilPreInversionPlanNegocioEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversionPlanNegocio');

    for (var perfilPreInversionPlanNegocio
        in perfilPreInversionPlanNegocioEntity) {
      perfilPreInversionPlanNegocio.recordStatus = 'R';
      batch.insert('PerfilPreInversionPlanNegocio',
          perfilPreInversionPlanNegocio.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<VPerfilPreInversionPlanNegocioModel> savePerfilPreInversionPlanNegocio(
      PerfilPreInversionPlanNegocioEntity perfilPreInversionPlanNegocioEntity,
      String tipoMovimientoId) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilPreInversionPlanNegocio',
        where: 'PerfilPreInversionId = ? AND RubroId = ? AND Year = ?',
        whereArgs: [
          perfilPreInversionPlanNegocioEntity.perfilPreInversionId,
          perfilPreInversionPlanNegocioEntity.rubroId,
          perfilPreInversionPlanNegocioEntity.year
        ]);

    if (resQuery.isEmpty) {
      perfilPreInversionPlanNegocioEntity.recordStatus = 'N';
      batch.insert('PerfilPreInversionPlanNegocio',
          perfilPreInversionPlanNegocioEntity.toJson());
    } else {
      perfilPreInversionPlanNegocioEntity.recordStatus = 'E';
      batch.update('PerfilPreInversionPlanNegocio',
          perfilPreInversionPlanNegocioEntity.toJson(),
          where: 'PerfilPreInversionId = ? AND RubroId = ? AND Year = ?',
          whereArgs: [
            perfilPreInversionPlanNegocioEntity.perfilPreInversionId,
            perfilPreInversionPlanNegocioEntity.rubroId,
            perfilPreInversionPlanNegocioEntity.year
          ]);
    }

    await batch.commit();

    String sql = ''' 
    select 
    ActividadFinanciera.ActividadFinancieraId as ActividadFinancieraId,
    ActividadFinanciera.Nombre as ActividadFinanciera,
    PerfilPreInversionPlanNegocio.RubroId,
    Rubro.Nombre as Rubro,
    Unidad.UnidadId as UnidadId,
    Unidad.Nombre as Unidad,
    Year,
    Cantidad,
    Valor,
    Producto.productoId as ProductoId,
    TipoCalidad.tipoCalidadId as TipoCalidadId,
    round(PerfilPreInversionPlanNegocio.Valor / ( SELECT  SUM(Valor)
    FROM  PerfilPreInversionPlanNegocio
    WHERE TipoMovimiento.TipoMovimientoId = $tipoMovimientoId) * 100, 3)
    as Porcentaje
    from PerfilPreInversionPlanNegocio
    inner join Rubro on (PerfilPreInversionPlanNegocio.RubroId=Rubro.RubroId)
    inner join ActividadFinanciera on(rubro.ActividadFinancieraId=ActividadFinanciera.ActividadFinancieraId)
    inner join TipoMovimiento on(TipoMovimiento.TipoMovimientoId=ActividadFinanciera.TipoMovimientoId)
    inner join Unidad on(unidad.UnidadId=PerfilPreInversionPlanNegocio.UnidadId)
    left join Producto on(Producto.ProductoId=PerfilPreInversionPlanNegocio.ProductoId)
    left join TipoCalidad on(TipoCalidad.TipoCalidadId=PerfilPreInversionPlanNegocio.TipoCalidadId)
    where TipoMovimiento.TipoMovimientoId = $tipoMovimientoId AND PerfilPreInversionPlanNegocio.PerfilPreInversionId = ${perfilPreInversionPlanNegocioEntity.perfilPreInversionId}
    ''';

    final res = await db.rawQuery(sql);

    final vPerfilPreInversionPlanNegocioMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final vPerfilPreInversionPlanNegocioModel =
        VPerfilPreInversionPlanNegocioModel.fromJson(
            vPerfilPreInversionPlanNegocioMap);

    return vPerfilPreInversionPlanNegocioModel;
  }

  @override
  Future<List<PerfilPreInversionPlanNegocioModel>>
      getPerfilesPreInversionesPlanNegociosProduccion() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionPlanNegocio',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final perfilesPreInversionesPlanNegociosModel =
        List<PerfilPreInversionPlanNegocioModel>.from(
                res.map((m) => PerfilPreInversionPlanNegocioModel.fromJson(m)))
            .toList();

    return perfilesPreInversionesPlanNegociosModel;
  }

  @override
  Future<int> updatePerfilesPreInversionesPlanNegociosProduccion(
      List<PerfilPreInversionPlanNegocioEntity>
          perfilesPreInversionesPlanNegociosProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var perfilPreInversionPlanNegocioProduccion
        in perfilesPreInversionesPlanNegociosProduccionEntity) {
      perfilPreInversionPlanNegocioProduccion.recordStatus = 'R';
      batch.update('PerfilPreInversionPlanNegocio',
          perfilPreInversionPlanNegocioProduccion.toJson(),
          where: 'PerfilPreInversionId = ? AND RubroId = ? AND Year = ?',
          whereArgs: [
            perfilPreInversionPlanNegocioProduccion.perfilPreInversionId,
            perfilPreInversionPlanNegocioProduccion.rubroId,
            perfilPreInversionPlanNegocioProduccion.year
          ]);
    }

    await batch.commit();
    final query = await db.query('PerfilPreInversionPlanNegocio',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    return query.length;
  }
}
