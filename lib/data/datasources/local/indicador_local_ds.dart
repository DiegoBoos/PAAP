import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/indicador_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/indicador_model.dart';

abstract class IndicadorLocalDataSource {
  Future<List<IndicadorModel>> getIndicadoresDB();
  Future<IndicadorModel?> getIndicadorDB(String id);
  Future<int> saveIndicadores(List<IndicadorEntity> indicadorEntity);
}

class IndicadorLocalDataSourceImpl implements IndicadorLocalDataSource {
  static createIndicadorTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Indicador (
        IndicadorId	TEXT NOT NULL,
        Nombre	TEXT,
        Meta	TEXT,
        ProductoObjetivoId	TEXT,
        Producto	TEXT,
        PRIMARY KEY(IndicadorId)
      )
    ''');
  }

  @override
  Future<List<IndicadorModel>> getIndicadoresDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Indicador');

    final indicadoresDB =
        List<IndicadorModel>.from(res.map((m) => IndicadorModel.fromJson(m)))
            .toList();

    return indicadoresDB;
  }

  @override
  Future<IndicadorModel?> getIndicadorDB(String id) async {
    final db = await DBConfig.database;

    final res =
        await db.query('Indicador', where: 'IndicadorId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final indicadorMap = {for (var e in res[0].entries) e.key: e.value};
    final indicadorModel = IndicadorModel.fromJson(indicadorMap);

    return indicadorModel;
  }

  @override
  Future<int> saveIndicadores(List<IndicadorEntity> indicadorEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Indicador');

    for (var indicador in indicadorEntity) {
      batch.insert('Indicador', indicador.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
