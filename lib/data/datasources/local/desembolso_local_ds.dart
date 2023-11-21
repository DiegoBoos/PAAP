import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/desembolso_entity.dart';
import '../../db/db_config.dart';
import '../../models/desembolso_model.dart';

abstract class DesembolsoLocalDataSource {
  Future<List<DesembolsoModel>> getDesembolsosDB();
  Future<int> saveDesembolsos(List<DesembolsoEntity> desembolsoEntity);
}

class DesembolsoLocalDataSourceImpl implements DesembolsoLocalDataSource {
  static createDesembolsoTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Desembolso (
        DesembolsoId	TEXT NOT NULL,
        Nombre	TEXT,
        PRIMARY KEY(DesembolsoId)
      )
    ''');
  }

  @override
  Future<List<DesembolsoModel>> getDesembolsosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Desembolso');

    final desembolsosDB =
        List<DesembolsoModel>.from(res.map((m) => DesembolsoModel.fromJson(m)))
            .toList();

    return desembolsosDB;
  }

  @override
  Future<int> saveDesembolsos(List<DesembolsoEntity> desembolsoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Desembolso');

    for (var desembolso in desembolsoEntity) {
      batch.insert('Desembolso', desembolso.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
