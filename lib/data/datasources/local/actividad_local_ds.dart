import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/actividad_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/actividad_model.dart';

abstract class ActividadLocalDataSource {
  Future<List<ActividadModel>> getActividadesDB();
  Future<ActividadModel?> getActividadDB(String id);
  Future<int> saveActividades(List<ActividadEntity> actividadEntity);
}

class ActividadLocalDataSourceImpl implements ActividadLocalDataSource {
  static createActividadTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Actividad (
        ActividadId	TEXT NOT NULL,
        Nombre	TEXT,
        IndicadorId	TEXT,
        Indicador	TEXT,
        PRIMARY KEY(ActividadId)
      )
    ''');
  }

  @override
  Future<List<ActividadModel>> getActividadesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Actividad');

    final actividadesDB =
        List<ActividadModel>.from(res.map((m) => ActividadModel.fromJson(m)))
            .toList();

    return actividadesDB;
  }

  @override
  Future<ActividadModel?> getActividadDB(String id) async {
    final db = await DBConfig.database;

    final res =
        await db.query('Actividad', where: 'ActividadId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final actividadMap = {for (var e in res[0].entries) e.key: e.value};
    final actividadModel = ActividadModel.fromJson(actividadMap);

    return actividadModel;
  }

  @override
  Future<int> saveActividades(List<ActividadEntity> actividadEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Actividad');

    for (var actividad in actividadEntity) {
      batch.insert('Actividad', actividad.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
