import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/aliado_entity.dart';

import '../../../../domain/db/db_config.dart';
import '../../../models/aliado_model.dart';

abstract class AliadosLocalDataSource {
  Future<List<AliadoModel>> getAliadosDB();
  Future<int> saveAliadosDB(List<AliadoEntity> aliados);
}

class AliadosLocalDataSourceImpl implements AliadosLocalDataSource {
  static createAliadoTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Aliado (
	      AliadoId	TEXT NOT NULL,
	      Nombre	TEXT,
	      NombreContacto	TEXT,
	      TelefonoMovil	TEXT,
	      Correo	TEXT,
	      Ciudad	TEXT,
	      Años_x0020_Experiencia	TEXT,
	      Estado	TEXT,
	      PRIMARY KEY(AliadoId),

      )
    ''');
  }

  @override
  Future<List<AliadoModel>> getAliadosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Aliado');

    final aliadosDB =
        List<AliadoModel>.from(res.map((m) => AliadoModel.fromJson(m)))
            .toList();

    return aliadosDB;
  }

  @override
  Future<int> saveAliadosDB(List<AliadoEntity> aliadoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Aliado');

    for (var aliado in aliadoEntity) {
      batch.insert('Aliado', aliado.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
