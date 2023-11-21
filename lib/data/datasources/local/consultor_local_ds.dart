import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/consultor_entity.dart';
import '../../db/db_config.dart';
import '../../models/consultor_model.dart';

abstract class ConsultorLocalDataSource {
  Future<List<ConsultorModel>> getConsultoresDB();
  Future<ConsultorModel?> getConsultorDB(String id);
  Future<int> saveConsultores(List<ConsultorEntity> consultorEntity);
}

class ConsultorLocalDataSourceImpl implements ConsultorLocalDataSource {
  static createConsultorTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Consultor (
        ConsultorId	TEXT NOT NULL,
        Nombre1	TEXT,
        Nombre2	TEXT,
        Apellido1	TEXT,
        Apellido2	TEXT,
        GeneroId	TEXT,
        FechaNacimiento	TEXT,
        FechaExpedicionDocumento	TEXT,
        Direccion	TEXT,
        TelefonoFijo	TEXT,
        TelefonoMovil	TEXT,
        Experiencia	TEXT,
        Activo	TEXT,
        UsuarioId	TEXT,
        Consultor	TEXT,
        PRIMARY KEY(ConsultorId)
      )
    ''');
  }

  @override
  Future<List<ConsultorModel>> getConsultoresDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Consultor');

    final consultoresDB =
        List<ConsultorModel>.from(res.map((m) => ConsultorModel.fromJson(m)))
            .toList();

    return consultoresDB;
  }

  @override
  Future<ConsultorModel?> getConsultorDB(String id) async {
    final db = await DBConfig.database;

    final res =
        await db.query('Consultor', where: 'ConsultorId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final consultorMap = {for (var e in res[0].entries) e.key: e.value};
    final consultorModel = ConsultorModel.fromJson(consultorMap);

    return consultorModel;
  }

  @override
  Future<int> saveConsultores(List<ConsultorEntity> consultorEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Consultor');

    for (var consultor in consultorEntity) {
      batch.insert('Consultor', consultor.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
