import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/beneficiario_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/beneficiario_model.dart';

abstract class BeneficiarioLocalDataSource {
  Future<List<BeneficiarioModel>> getBeneficiariosDB();
  Future<BeneficiarioModel?> getBeneficiarioDB(String id);
  Future<int> saveBeneficiarios(List<BeneficiarioEntity> beneficiarioEntity);
}

class BeneficiarioLocalDataSourceImpl implements BeneficiarioLocalDataSource {
  static createBeneficiarioTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Beneficiario (
        BeneficiarioId	TEXT NOT NULL,
        Nombre1	TEXT,
        Nombre2	TEXT,
        Apellido1	TEXT,
        Apellido2	TEXT,
        GeneroId	TEXT,
        FechaNacimiento	TEXT,
        FechaExpedicionDocumento	TEXT,
        GrupoEspecialId	TEXT,
        TelefonoMovil	TEXT,
        Activo	TEXT,
        TipoIdentificacionId	TEXT,
        PRIMARY KEY(BeneficiarioId)
      )
    ''');
  }

  @override
  Future<List<BeneficiarioModel>> getBeneficiariosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Beneficiario');

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
      batch.insert('Beneficiario', beneficiario.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
