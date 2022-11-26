import 'package:sqflite/sqflite.dart';

import '../../../domain/db/db_config.dart';
import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../models/perfil_preinversion_plan_negocio_model.dart';

abstract class PerfilPreInversionPlanNegocioLocalDataSource {
  Future<List<PerfilPreInversionPlanNegocioModel>>
      getPerfilPreInversionPlanNegociosDB();
  Future<PerfilPreInversionPlanNegocioModel?>
      getPerfilPreInversionPlanNegocioDB(
          String perfilPreInversionId, String rubroId, String year);
  Future<int> savePerfilPreInversionPlanNegocios(
      List<PerfilPreInversionPlanNegocioEntity>
          perfilPreInversionPlanNegocioEntity);
  Future<int> savePerfilPreInversionPlanNegocioDB(
      PerfilPreInversionPlanNegocioEntity perfilPreInversionPlanNegocioEntity);
  Future<List<PerfilPreInversionPlanNegocioModel>>
      getPerfilesPreInversionesPlanNegociosProduccionDB();
  Future<int> updatePerfilesPreInversionesPlanNegociosProduccionDB(
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
      getPerfilPreInversionPlanNegociosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionPlanNegocio');

    final perfilPreInversionPlanNegocio =
        List<PerfilPreInversionPlanNegocioModel>.from(
                res.map((m) => PerfilPreInversionPlanNegocioModel.fromJson(m)))
            .toList();

    return perfilPreInversionPlanNegocio;
  }

  @override
  Future<PerfilPreInversionPlanNegocioModel?>
      getPerfilPreInversionPlanNegocioDB(
          String perfilPreInversionId, String rubroId, String year) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionPlanNegocio',
        where: 'PerfilPreInversionId = ? AND RubroId = ? AND Year = ?',
        whereArgs: [perfilPreInversionId, rubroId, year]);

    if (res.isEmpty) return null;
    final perfilPreInversionPlanNegocioMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilPreInversionPlanNegocioModel =
        PerfilPreInversionPlanNegocioModel.fromJson(
            perfilPreInversionPlanNegocioMap);

    return perfilPreInversionPlanNegocioModel;
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
  Future<int> savePerfilPreInversionPlanNegocioDB(
      PerfilPreInversionPlanNegocioEntity
          perfilPreInversionPlanNegocioEntity) async {
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

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionPlanNegocioModel>>
      getPerfilesPreInversionesPlanNegociosProduccionDB() async {
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
  Future<int> updatePerfilesPreInversionesPlanNegociosProduccionDB(
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

    final res = await batch.commit();

    return res.length;
  }
}
