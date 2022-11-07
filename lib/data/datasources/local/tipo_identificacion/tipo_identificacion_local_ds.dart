import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/tipo_identificacion_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/tipo_identificacion_model.dart';

abstract class TipoIdentificacionLocalDataSource {
  Future<List<TipoIdentificacionModel>> getTipoIdentificacionesDB();
  Future<int> saveTipoIdentificaciones(
      List<TipoIdentificacionEntity> tipoIdentificacionEntity);
}

class TipoIdentificacionLocalDataSourceImpl
    implements TipoIdentificacionLocalDataSource {
  static createTipoIdentificacionTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS TipoIdentificacion (
        TipoIdentificacionId	TEXT NOT NULL,
        Nombre	TEXT,
        PRIMARY KEY(TipoIdentificacionId)
      )
    ''');
  }

  @override
  Future<List<TipoIdentificacionModel>> getTipoIdentificacionesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('TipoIdentificacion');

    final tipoIdentificacionesDB = List<TipoIdentificacionModel>.from(
        res.map((m) => TipoIdentificacionModel.fromJson(m))).toList();

    return tipoIdentificacionesDB;
  }

  @override
  Future<int> saveTipoIdentificaciones(
      List<TipoIdentificacionEntity> tipoIdentificacionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('TipoIdentificacion');

    for (var tipoIdentificacion in tipoIdentificacionEntity) {
      batch.insert('TipoIdentificacion', tipoIdentificacion.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
