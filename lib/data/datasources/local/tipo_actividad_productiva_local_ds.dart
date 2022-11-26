import 'package:sqflite/sqflite.dart';

import '../../../domain/db/db_config.dart';
import '../../../domain/entities/tipo_actividad_productiva_entity.dart';
import '../../models/tipo_actividad_productiva_model.dart';

abstract class TipoActividadProductivaLocalDataSource {
  Future<List<TipoActividadProductivaModel>> getTiposActividadesProductivasDB();
  Future<int> saveTiposActividadesProductivas(
      List<TipoActividadProductivaEntity> tipoActividadProductivaEntity);
}

class TipoActividadProductivaLocalDataSourceImpl
    implements TipoActividadProductivaLocalDataSource {
  static createTipoActividadProductivaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS TipoActividadProductiva (
        TipoActividadProductivaId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        TipoProyectoId	TEXT,
        FOREIGN KEY(TipoProyectoId) REFERENCES TipoProyecto(TipoProyectoId),
        PRIMARY KEY(TipoActividadProductivaId)
      )
    ''');
  }

  @override
  Future<List<TipoActividadProductivaModel>>
      getTiposActividadesProductivasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('TipoActividadProductiva');

    final tipoactividadproductivaesDB = List<TipoActividadProductivaModel>.from(
        res.map((m) => TipoActividadProductivaModel.fromJson(m))).toList();

    return tipoactividadproductivaesDB;
  }

  @override
  Future<int> saveTiposActividadesProductivas(
      List<TipoActividadProductivaEntity> tipoActividadProductivaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('TipoActividadProductiva');

    for (var tipoactividadproductiva in tipoActividadProductivaEntity) {
      batch.insert('TipoActividadProductiva', tipoactividadproductiva.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
