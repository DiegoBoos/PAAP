import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/municipio_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/municipio_model.dart';

abstract class MunicipioLocalDataSource {
  Future<List<MunicipioModel>> getMunicipiosDB();
  Future<List<MunicipioModel>> getMunicipiosByDepartamentoDB(
      String departamentoId);
  Future<int> saveMunicipios(List<MunicipioEntity> municipioEntity);
}

class MunicipioLocalDataSourceImpl implements MunicipioLocalDataSource {
  static createMunicipioTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Municipio (
        MunicipioId	TEXT NOT NULL,
        Nombre	TEXT,
        DepartamentoId	TEXT,
        PRIMARY KEY(MunicipioId),
        FOREIGN KEY(DepartamentoId) REFERENCES Departamento(DepartamentoId)
      )
    ''');
  }

  @override
  Future<List<MunicipioModel>> getMunicipiosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Municipio');

    final municipiosDB =
        List<MunicipioModel>.from(res.map((m) => MunicipioModel.fromJson(m)))
            .toList();

    return municipiosDB;
  }

  @override
  Future<List<MunicipioModel>> getMunicipiosByDepartamentoDB(
      String departamentoId) async {
    final db = await DBConfig.database;

    final res = await db.query('Municipio',
        where: 'DepartamentoId = ?', whereArgs: [departamentoId]);

    final municipiosDB =
        List<MunicipioModel>.from(res.map((m) => MunicipioModel.fromJson(m)))
            .toList();

    return municipiosDB;
  }

  @override
  Future<int> saveMunicipios(List<MunicipioEntity> municipiosEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Municipio');

    for (var municipio in municipiosEntity) {
      batch.insert('Municipio', municipio.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
