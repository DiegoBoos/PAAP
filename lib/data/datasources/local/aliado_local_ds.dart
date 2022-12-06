import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/aliado_entity.dart';

import '../../../domain/db/db_config.dart';
import '../../models/aliado_model.dart';

abstract class AliadosLocalDataSource {
  Future<List<AliadoModel>> getAliadosDB();
  Future<AliadoModel?> getAliadoDB(String id);
  Future<int> saveAliadosDB(List<AliadoEntity> aliados);
  Future<int> saveAliadoDB(AliadoEntity aliadoEntity);
  Future<List<AliadoModel>> getAliadosProduccionDB();
  Future<int> updateAliadosProduccionDB(
      List<AliadoEntity> aliadosProduccionEntity);
}

class AliadosLocalDataSourceImpl implements AliadosLocalDataSource {
  static createAliadoTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Aliado (
        AliadoId TEXT NOT NULL,
        Nombre TEXT,
        FechaCreacion TEXT,
        NombreContacto TEXT,
        Direccion TEXT,
        TelefonoFijo TEXT,
        TelefonoMovil TEXT,
        Correo TEXT,
        MunicipioId TEXT NOT NULL,
        Experiencia TEXT,
        FechaActivacion TEXT,
        FechaDesactivacion TEXT,
        FechaCambio TEXT,
        Activo TEXT,
        RecordStatus	TEXT,
	      FOREIGN KEY(MunicipioId) REFERENCES Municipio(MunicipioId),
	      PRIMARY KEY(AliadoId)
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
  Future<AliadoModel?> getAliadoDB(String id) async {
    final db = await DBConfig.database;

    final res =
        await db.query('Aliado', where: 'AliadoId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final aliadoMap = {for (var e in res[0].entries) e.key: e.value};
    final aliadoModel = AliadoModel.fromJson(aliadoMap);

    return aliadoModel;
  }

  @override
  Future<int> saveAliadosDB(List<AliadoEntity> aliadoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Aliado');

    for (var aliado in aliadoEntity) {
      aliado.recordStatus = 'R';
      batch.insert('Aliado', aliado.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveAliadoDB(AliadoEntity aliadoEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('Aliado',
        where: 'AliadoId = ?', whereArgs: [aliadoEntity.aliadoId]);

    if (resQuery.isEmpty) {
      aliadoEntity.recordStatus = 'N';
      batch.insert('Aliado', aliadoEntity.toJson());
    } else {
      aliadoEntity.recordStatus = 'E';
      batch.update('Aliado', aliadoEntity.toJson(),
          where: 'AliadoId = ?', whereArgs: [aliadoEntity.aliadoId]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<AliadoModel>> getAliadosProduccionDB() async {
    final db = await DBConfig.database;

    final res =
        await db.query('Aliado', where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final aliadosModel =
        List<AliadoModel>.from(res.map((m) => AliadoModel.fromJson(m)))
            .toList();

    return aliadosModel;
  }

  @override
  Future<int> updateAliadosProduccionDB(
      List<AliadoEntity> aliadosProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var aliadoProduccion in aliadosProduccionEntity) {
      aliadoProduccion.recordStatus = 'R';
      batch.update('Aliado', aliadoProduccion.toJson(),
          where: 'AliadoId = ?', whereArgs: [aliadoProduccion.aliadoId]);
    }

    final res = await batch.commit();

    return res.length;
  }
}
