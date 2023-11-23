import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/beneficiario_entity.dart';
import '../../db/db_config.dart';
import '../../models/beneficiario_model.dart';

abstract class BeneficiarioLocalDataSource {
  Future<List<BeneficiarioModel>> getBeneficiariosDB(String perfilId);
  Future<List<BeneficiarioModel>> getBeneficiariosProduccionDB();
  Future<BeneficiarioModel?> getBeneficiarioDB(String id);
  Future<int> saveBeneficiarioDB(BeneficiarioEntity beneficiarioEntity);
  Future<int> saveBeneficiarios(List<BeneficiarioEntity> beneficiarioEntity);
  Future<int> updateBeneficiariosProduccionDB(
      List<BeneficiarioEntity> beneficiariosEntity);
}

class BeneficiarioLocalDataSourceImpl implements BeneficiarioLocalDataSource {
  static createBeneficiarioTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Beneficiario (
        BeneficiarioId	TEXT NOT NULL,
        TipoIdentificacionId	TEXT,
        FechaExpedicionDocumento	TEXT,
        FechaNacimiento	TEXT,
        Edad	INTEGER,
        Nombre1	TEXT,
        Nombre2	TEXT,
        Apellido1	TEXT,
        Apellido2	TEXT,
        GeneroId	TEXT,
        GrupoEspecialId	TEXT,
        TelefonoMovil	TEXT,
        Activo	TEXT,
        RecordStatus	TEXT,
        PRIMARY KEY(BeneficiarioId)
      )
    ''');
  }

  @override
  Future<List<BeneficiarioModel>> getBeneficiariosDB(String perfilId) async {
    final db = await DBConfig.database;
    String sql = '''
      select
      Beneficiario.BeneficiarioId,
      Beneficiario.TipoIdentificacionId,
      Beneficiario.FechaExpedicionDocumento,
      Beneficiario.FechaNacimiento,
      cast(strftime('%Y.%m%d', 'now') - strftime('%Y.%m%d', Beneficiario.FechaNacimiento ) as int) as Edad,
      Beneficiario.Nombre1,
      Beneficiario.Nombre2,
      Beneficiario.Apellido1,
      Beneficiario.Apellido2,
      Beneficiario.GeneroId,
      Beneficiario.GrupoEspecialId,
      Beneficiario.TelefonoMovil,
      Beneficiario.Activo
      from Beneficiario
    ''';

    final res = await db.rawQuery(sql);

    final beneficiariosDB = List<BeneficiarioModel>.from(
        res.map((m) => BeneficiarioModel.fromJson(m))).toList();

    return beneficiariosDB;
  }

  @override
  Future<BeneficiarioModel?> getBeneficiarioDB(String id) async {
    final db = await DBConfig.database;

    final res = await db
        .query('Beneficiario', where: 'BeneficiarioId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final beneficiarioMap = {for (var e in res[0].entries) e.key: e.value};
    final beneficiarioModel = BeneficiarioModel.fromJson(beneficiarioMap);

    return beneficiarioModel;
  }

  @override
  Future<int> saveBeneficiarios(
      List<BeneficiarioEntity> beneficiarioEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Beneficiario');

    for (var beneficiario in beneficiarioEntity) {
      beneficiario.recordStatus = 'R';
      batch.insert('Beneficiario', beneficiario.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveBeneficiarioDB(BeneficiarioEntity beneficiarioEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('Beneficiario',
        where: 'BeneficiarioId = ?',
        whereArgs: [beneficiarioEntity.beneficiarioId]);

    if (resQuery.isEmpty) {
      beneficiarioEntity.recordStatus = 'N';
      batch.insert('Beneficiario', beneficiarioEntity.toJson());
    } else {
      beneficiarioEntity.recordStatus = 'E';
      batch.update('Beneficiario', beneficiarioEntity.toJson(),
          where: 'BeneficiarioId = ?',
          whereArgs: [beneficiarioEntity.beneficiarioId]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<BeneficiarioModel>> getBeneficiariosProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db
        .query('Beneficiario', where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final beneficiariosModel = List<BeneficiarioModel>.from(
        res.map((m) => BeneficiarioModel.fromJson(m))).toList();

    return beneficiariosModel;
  }

  @override
  Future<int> updateBeneficiariosProduccionDB(
      List<BeneficiarioEntity> beneficiariosProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var beneficiarioProduccion in beneficiariosProduccionEntity) {
      beneficiarioProduccion.recordStatus = 'R';
      batch.update('Beneficiario', beneficiarioProduccion.toJson(),
          where: 'BeneficiarioId = ?',
          whereArgs: [beneficiarioProduccion.beneficiarioId]);
    }

    final res = await batch.commit();

    return res.length;
  }
}
