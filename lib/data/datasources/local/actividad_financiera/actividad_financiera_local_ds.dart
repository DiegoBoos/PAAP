import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/actividad_financiera_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/actividad_financiera_model.dart';

abstract class ActividadFinancieraLocalDataSource {
  Future<List<ActividadFinancieraModel>> getActividadesFinancierasDB();
  Future<int> saveActividadesFinancieras(
      List<ActividadFinancieraEntity> actividadFinancieraEntity);
}

class ActividadFinancieraLocalDataSourceImpl
    implements ActividadFinancieraLocalDataSource {
  static createActividadFinancieraTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ActividadFinanciera (
        ActividadFinancieraId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripción	TEXT,
        Activo	TEXT,
        TipoMovimientoId	TEXT,
        PRIMARY KEY(ActividadFinancieraId)
      )
    ''');
  }

  @override
  Future<List<ActividadFinancieraModel>> getActividadesFinancierasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('ActividadFinanciera');

    final actividadesFinancierasDB = List<ActividadFinancieraModel>.from(
        res.map((m) => ActividadFinancieraModel.fromJson(m))).toList();

    return actividadesFinancierasDB;
  }

  @override
  Future<int> saveActividadesFinancieras(
      List<ActividadFinancieraEntity> actividadFinancieraEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('ActividadFinanciera');

    for (var actividadFinanciera in actividadFinancieraEntity) {
      batch.insert('ActividadFinanciera', actividadFinanciera.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
