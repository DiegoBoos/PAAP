import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/beneficio_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/beneficio_model.dart';

abstract class BeneficioLocalDataSource {
  Future<List<BeneficioModel>> getBeneficiosDB();
  Future<int> saveBeneficios(List<BeneficioEntity> beneficioEntity);
}

class BeneficioLocalDataSourceImpl implements BeneficioLocalDataSource {
  static createBeneficioTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Beneficio (
        BeneficioId	TEXT NOT NULL,
        Nombre	TEXT,
        PRIMARY KEY(BeneficioId)
      )
    ''');
  }

  @override
  Future<List<BeneficioModel>> getBeneficiosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Beneficio');

    final beneficiosDB =
        List<BeneficioModel>.from(res.map((m) => BeneficioModel.fromJson(m)))
            .toList();

    return beneficiosDB;
  }

  @override
  Future<int> saveBeneficios(List<BeneficioEntity> beneficioEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Beneficio');

    for (var beneficio in beneficioEntity) {
      batch.insert('Beneficio', beneficio.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
