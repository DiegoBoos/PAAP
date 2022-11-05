import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/estado_civil_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/estado_civil_model.dart';

abstract class EstadoCivilLocalDataSource {
  Future<List<EstadoCivilModel>> getEstadosCivilesDB();
  Future<int> saveEstadosCiviles(List<EstadoCivilEntity> estadocivilEntity);
}

class EstadoCivilLocalDataSourceImpl implements EstadoCivilLocalDataSource {
  static createEstadoCivilTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS EstadoCivil (
        EstadoCivilId	TEXT NOT NULL,
        Nombre	TEXT,
        TieneConyuge	TEXT,
        PRIMARY KEY(EstadoCivilId)
      )
    ''');
  }

  @override
  Future<List<EstadoCivilModel>> getEstadosCivilesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('EstadoCivil');

    final estadocivilsDB = List<EstadoCivilModel>.from(
        res.map((m) => EstadoCivilModel.fromJson(m))).toList();

    return estadocivilsDB;
  }

  @override
  Future<int> saveEstadosCiviles(
      List<EstadoCivilEntity> estadocivilEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('EstadoCivil');

    for (var estadocivil in estadocivilEntity) {
      batch.insert('EstadoCivil', estadocivil.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
