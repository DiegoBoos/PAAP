import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/meta_indicador_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/meta_indicador_model.dart';

abstract class MetaIndicadorLocalDataSource {
  Future<List<MetaIndicadorModel>> getMetasIndicadoresDB();
  Future<int> saveMetasIndicadores(
      List<MetaIndicadorEntity> metaIndicadorEntity);
}

class MetaIndicadorLocalDataSourceImpl implements MetaIndicadorLocalDataSource {
  static createMetaIndicadorTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS MetaIndicador (
        MetaIndicadorId	TEXT NOT NULL,
        IndicadorId	TEXT,
        Year	TEXT,
        Meta	TEXT,
        Costo	TEXT,
        Indicador	TEXT,
        PRIMARY KEY(MetaIndicadorId)
      )
    ''');
  }

  @override
  Future<List<MetaIndicadorModel>> getMetasIndicadoresDB() async {
    final db = await DBConfig.database;

    final res = await db.query('MetaIndicador');

    final metasIndicadoresDB = List<MetaIndicadorModel>.from(
        res.map((m) => MetaIndicadorModel.fromJson(m))).toList();

    return metasIndicadoresDB;
  }

  @override
  Future<int> saveMetasIndicadores(
      List<MetaIndicadorEntity> metaIndicadorEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('MetaIndicador');

    for (var metaIndicador in metaIndicadorEntity) {
      batch.insert('MetaIndicador', metaIndicador.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
