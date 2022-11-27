import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/vereda_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/vereda_model.dart';

abstract class VeredaLocalDataSource {
  Future<List<VeredaModel>> getVeredasByMunicipioDB(String municipioId);
  Future<int> saveVeredas(List<VeredaEntity> veredaEntity);
}

class VeredaLocalDataSourceImpl implements VeredaLocalDataSource {
  static createVeredaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Vereda (
        VeredaId	TEXT NOT NULL,
        Nombre	TEXT,
        CodigoDane	TEXT,
        MunicipioId	TEXT,
        FOREIGN KEY(MunicipioId) REFERENCES Municipio(MunicipioId),
        PRIMARY KEY(VeredaId)
      )
    ''');
  }

  @override
  Future<List<VeredaModel>> getVeredasByMunicipioDB(String municipioId) async {
    final db = await DBConfig.database;

    final res = await db
        .query('Vereda', where: 'MunicipioId = ?', whereArgs: [municipioId]);

    final veredasDB =
        List<VeredaModel>.from(res.map((m) => VeredaModel.fromJson(m)))
            .toList();

    return veredasDB;
  }

  @override
  Future<int> saveVeredas(List<VeredaEntity> veredasEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Vereda');

    for (var vereda in veredasEntity) {
      batch.insert('Vereda', vereda.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
