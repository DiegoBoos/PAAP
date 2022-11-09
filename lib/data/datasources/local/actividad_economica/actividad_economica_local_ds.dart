import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/actividad_economica_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/actividad_economica_model.dart';

abstract class ActividadEconomicaLocalDataSource {
  Future<List<ActividadEconomicaModel>> getActividadesEconomicasDB();
  Future<int> saveActividadesEconomicas(
      List<ActividadEconomicaEntity> actividadEconomicaEntity);
}

class ActividadEconomicaLocalDataSourceImpl
    implements ActividadEconomicaLocalDataSource {
  static createActividadEconomicaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ActividadEconomica (
        ActividadEconomicaId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        PRIMARY KEY(ActividadEconomicaId)
      )
    ''');
  }

  @override
  Future<List<ActividadEconomicaModel>> getActividadesEconomicasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('ActividadEconomica');

    final actividadesEconomicasDB = List<ActividadEconomicaModel>.from(
        res.map((m) => ActividadEconomicaModel.fromJson(m))).toList();

    return actividadesEconomicasDB;
  }

  @override
  Future<int> saveActividadesEconomicas(
      List<ActividadEconomicaEntity> actividadEconomicaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('ActividadEconomica');

    for (var actividadEconomica in actividadEconomicaEntity) {
      batch.insert('ActividadEconomica', actividadEconomica.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
