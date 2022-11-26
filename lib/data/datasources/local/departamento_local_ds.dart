import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/departamento_model.dart';

abstract class DepartamentoLocalDataSource {
  Future<List<DepartamentoModel>> getDepartamentosDB();
  Future<int> saveDepartamentos(List<DepartamentoEntity> departamentoEntity);
}

class DepartamentoLocalDataSourceImpl implements DepartamentoLocalDataSource {
  static createDepartamentoTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Departamento (
        DepartamentoId	TEXT NOT NULL,
        Nombre	TEXT,
        PaisId	TEXT,
        PRIMARY KEY(DepartamentoId)
      )
    ''');
  }

  @override
  Future<List<DepartamentoModel>> getDepartamentosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Departamento');

    final departamentosDB = List<DepartamentoModel>.from(
        res.map((m) => DepartamentoModel.fromJson(m))).toList();

    return departamentosDB;
  }

  @override
  Future<int> saveDepartamentos(
      List<DepartamentoEntity> departamentoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Departamento');

    for (var departamento in departamentoEntity) {
      batch.insert('Departamento', departamento.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
