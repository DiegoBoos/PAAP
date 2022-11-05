import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/nivel_escolar_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/nivel_escolar_model.dart';

abstract class NivelEscolarLocalDataSource {
  Future<List<NivelEscolarModel>> getNivelesEscolaresDB();
  Future<int> saveNivelesEscolares(List<NivelEscolarEntity> nivelescolarEntity);
}

class NivelEscolarLocalDataSourceImpl implements NivelEscolarLocalDataSource {
  static createNivelEscolarTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS NivelEscolar (
        NivelEscolarId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        PRIMARY KEY(NivelEscolarId)
      )
    ''');
  }

  @override
  Future<List<NivelEscolarModel>> getNivelesEscolaresDB() async {
    final db = await DBConfig.database;

    final res = await db.query('NivelEscolar');

    final nivelescolarsDB = List<NivelEscolarModel>.from(
        res.map((m) => NivelEscolarModel.fromJson(m))).toList();

    return nivelescolarsDB;
  }

  @override
  Future<int> saveNivelesEscolares(
      List<NivelEscolarEntity> nivelescolarEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('NivelEscolar');

    for (var nivelescolar in nivelescolarEntity) {
      batch.insert('NivelEscolar', nivelescolar.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
