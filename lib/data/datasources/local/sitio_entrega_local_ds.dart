import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/sitio_entrega_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/sitio_entrega_model.dart';

abstract class SitioEntregaLocalDataSource {
  Future<List<SitioEntregaModel>> getSitiosEntregasDB();
  Future<int> saveSitiosEntregas(List<SitioEntregaEntity> sitioEntregaEntity);
}

class SitioEntregaLocalDataSourceImpl implements SitioEntregaLocalDataSource {
  static createSitioEntregaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS SitioEntrega (
        SitioEntregaId	TEXT NOT NULL,
        Nombre	TEXT,
        PRIMARY KEY(SitioEntregaId)
      )
    ''');
  }

  @override
  Future<List<SitioEntregaModel>> getSitiosEntregasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('SitioEntrega');

    final sitiosEntregasDB = List<SitioEntregaModel>.from(
        res.map((m) => SitioEntregaModel.fromJson(m))).toList();

    return sitiosEntregasDB;
  }

  @override
  Future<int> saveSitiosEntregas(
      List<SitioEntregaEntity> sitioEntregaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('SitioEntrega');

    for (var sitioEntrega in sitioEntregaEntity) {
      batch.insert('SitioEntrega', sitioEntrega.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
