import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/estado_visita_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/estado_visita_model.dart';

abstract class EstadoVisitaLocalDataSource {
  Future<List<EstadoVisitaModel>> getEstadosVisitasDB();
  Future<int> saveEstadosVisitas(List<EstadoVisitaEntity> estadovisitaEntity);
}

class EstadoVisitaLocalDataSourceImpl implements EstadoVisitaLocalDataSource {
  static createEstadoVisitaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS EstadoVisita (
        EstadoVisitaId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        PRIMARY KEY(EstadoVisitaId)
      )
    ''');
  }

  @override
  Future<List<EstadoVisitaModel>> getEstadosVisitasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('EstadoVisita');

    final estadovisitasDB = List<EstadoVisitaModel>.from(
        res.map((m) => EstadoVisitaModel.fromJson(m))).toList();

    return estadovisitasDB;
  }

  @override
  Future<int> saveEstadosVisitas(
      List<EstadoVisitaEntity> estadovisitaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('EstadoVisita');

    for (var estadovisita in estadovisitaEntity) {
      batch.insert('EstadoVisita', estadovisita.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
