import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/grupo_especial_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/grupo_especial_model.dart';

abstract class GrupoEspecialLocalDataSource {
  Future<List<GrupoEspecialModel>> getGruposEspecialesDB();
  Future<int> saveGruposEspeciales(
      List<GrupoEspecialEntity> gruposespecialesEntity);
}

class GrupoEspecialLocalDataSourceImpl implements GrupoEspecialLocalDataSource {
  static createGrupoEspecialTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS GrupoEspecial (
        GrupoEspecialId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        PRIMARY KEY(GrupoEspecialId)
      )
    ''');
  }

  @override
  Future<List<GrupoEspecialModel>> getGruposEspecialesDB() async {
    final db = await DBConfig.database;

    final res = await db.query('GrupoEspecial');

    final gruposespecialessDB = List<GrupoEspecialModel>.from(
        res.map((m) => GrupoEspecialModel.fromJson(m))).toList();

    return gruposespecialessDB;
  }

  @override
  Future<int> saveGruposEspeciales(
      List<GrupoEspecialEntity> gruposespecialesEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('GrupoEspecial');

    for (var gruposespeciales in gruposespecialesEntity) {
      batch.insert('GrupoEspecial', gruposespeciales.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
