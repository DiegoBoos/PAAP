import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/revision_entity.dart';
import '../../db/db_config.dart';
import '../../models/revision_model.dart';

abstract class RevisionLocalDataSource {
  Future<List<RevisionModel>> getRevisionesDB();
  Future<int> saveRevisiones(List<RevisionEntity> revisionEntity);
}

class RevisionLocalDataSourceImpl implements RevisionLocalDataSource {
  static createRevisionTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Revision (
        RevisionId	TEXT NOT NULL,
        Nombre	TEXT,
        PRIMARY KEY(RevisionId)
      )
    ''');
  }

  @override
  Future<List<RevisionModel>> getRevisionesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Revision');

    final revisionesDB =
        List<RevisionModel>.from(res.map((m) => RevisionModel.fromJson(m)))
            .toList();

    return revisionesDB;
  }

  @override
  Future<int> saveRevisiones(List<RevisionEntity> revisionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Revision');

    for (var revision in revisionEntity) {
      batch.insert('Revision', revision.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
