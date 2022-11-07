import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/cofinanciador_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/cofinanciador_model.dart';

abstract class CofinanciadorLocalDataSource {
  Future<List<CofinanciadorModel>> getCofinanciadoresDB();
  Future<int> saveCofinanciadores(
      List<CofinanciadorEntity> cofinanciadorEntity);
}

class CofinanciadorLocalDataSourceImpl implements CofinanciadorLocalDataSource {
  static createCofinanciadorTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Cofinanciador (
        ID	TEXT NOT NULL,
        Nombre	TEXT,
        Teléfono_x0020_Fijo	TEXT,
        Teléfono_x0020_Móvil	TEXT,
        Correo	TEXT,
        Dirección	TEXT,
        Tipo_x0020_Entidad	TEXT,
        Departamento	TEXT,
        Municipio	TEXT,
        PRIMARY KEY(ID)
      )
    ''');
  }

  @override
  Future<List<CofinanciadorModel>> getCofinanciadoresDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Cofinanciador');

    final cofinanciadoresDB = List<CofinanciadorModel>.from(
        res.map((m) => CofinanciadorModel.fromJson(m))).toList();

    return cofinanciadoresDB;
  }

  @override
  Future<int> saveCofinanciadores(
      List<CofinanciadorEntity> cofinanciadorEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Cofinanciador');

    for (var cofinanciador in cofinanciadorEntity) {
      batch.insert('Cofinanciador', cofinanciador.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
