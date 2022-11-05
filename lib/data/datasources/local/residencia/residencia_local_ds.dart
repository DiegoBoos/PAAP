import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/residencia_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/residencia_model.dart';

abstract class ResidenciaLocalDataSource {
  Future<List<ResidenciaModel>> getResidenciasDB();
  Future<int> saveResidencias(List<ResidenciaEntity> residenciaEntity);
}

class ResidenciaLocalDataSourceImpl implements ResidenciaLocalDataSource {
  static createResidenciaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Residencia (
        ResidenciaId	TEXT NOT NULL,
        Nombre	TEXT,
        PRIMARY KEY(ResidenciaId)
      )
    ''');
  }

  @override
  Future<List<ResidenciaModel>> getResidenciasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Residencia');

    final residenciasDB =
        List<ResidenciaModel>.from(res.map((m) => ResidenciaModel.fromJson(m)))
            .toList();

    return residenciasDB;
  }

  @override
  Future<int> saveResidencias(List<ResidenciaEntity> residenciaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Residencia');

    for (var residencia in residenciaEntity) {
      batch.insert('Residencia', residencia.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
