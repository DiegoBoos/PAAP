import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/tipo_visita_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/tipo_visita_model.dart';

abstract class TipoVisitaLocalDataSource {
  Future<List<TipoVisitaModel>> getTiposVisitasDB();
  Future<int> saveTiposVisitas(List<TipoVisitaEntity> tipovisitaEntity);
}

class TipoVisitaLocalDataSourceImpl implements TipoVisitaLocalDataSource {
  static createTipoVisitaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS TipoVisita (
        TipoVisitaId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        PRIMARY KEY(TipoVisitaId)
      )
    ''');
  }

  @override
  Future<List<TipoVisitaModel>> getTiposVisitasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('TipoVisita');

    final tipovisitasDB =
        List<TipoVisitaModel>.from(res.map((m) => TipoVisitaModel.fromJson(m)))
            .toList();

    return tipovisitasDB;
  }

  @override
  Future<int> saveTiposVisitas(List<TipoVisitaEntity> tipovisitaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('TipoVisita');

    for (var tipovisita in tipovisitaEntity) {
      batch.insert('TipoVisita', tipovisita.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
