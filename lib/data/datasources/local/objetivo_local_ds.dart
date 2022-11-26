import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/objetivo_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/objetivo_model.dart';

abstract class ObjetivoLocalDataSource {
  Future<List<ObjetivoModel>> getObjetivosDB();
  Future<int> saveObjetivos(List<ObjetivoEntity> objetivoEntity);
}

class ObjetivoLocalDataSourceImpl implements ObjetivoLocalDataSource {
  static createObjetivoTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Objetivo (
        ObjetivoId	TEXT NOT NULL,
        Nombre	TEXT,
        FechaRegistro	TEXT,
        ProyectoId	TEXT,
        Proyecto	TEXT,
        PRIMARY KEY(ObjetivoId)
      )
    ''');
  }

  @override
  Future<List<ObjetivoModel>> getObjetivosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Objetivo');

    final objetivosDB =
        List<ObjetivoModel>.from(res.map((m) => ObjetivoModel.fromJson(m)))
            .toList();

    return objetivosDB;
  }

  @override
  Future<int> saveObjetivos(List<ObjetivoEntity> objetivoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Objetivo');

    for (var objetivo in objetivoEntity) {
      batch.insert('Objetivo', objetivo.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
