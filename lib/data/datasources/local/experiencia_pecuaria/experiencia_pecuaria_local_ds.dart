import 'package:sqflite/sqflite.dart';

import '../../../../../domain/db/db_config.dart';
import '../../../../domain/entities/experiencia_pecuaria_entity.dart';
import '../../../models/experiencia_pecuaria_model.dart';

abstract class ExperienciaPecuariaLocalDataSource {
  Future<List<ExperienciaPecuariaModel>> getExperienciasPecuariasDB();
  Future<List<ExperienciaPecuariaModel>> getExperienciasPecuariasProduccionDB();
  Future<ExperienciaPecuariaModel?> getExperienciaPecuariaDB(String id);
  Future<int> saveExperienciasPecuarias(
      List<ExperienciaPecuariaEntity> experienciasPecuariasEntity);
  Future<int> saveExperienciaPecuariaDB(
      ExperienciaPecuariaEntity experienciaPecuariaEntity);
  Future<int> updateExperienciasPecuariasProduccionDB(
      List<ExperienciaPecuariaEntity> experienciasPecuariasEntity);
}

class ExperienciaPecuariaLocalDataSourceImpl
    implements ExperienciaPecuariaLocalDataSource {
  static createExperienciaPecuariaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ExperienciaPecuaria (
        TipoActividadProductivaId TEXT NOT NULL,
        BeneficiarioId TEXT NOT NULL, 
        FrecuenciaId TEXT NOT NULL,
        CantidadAnimales TEXT,
        CantidadCria TEXT,
        CantidadLevante TEXT,
        CantidadCeba TEXT,
        CantidadLeche TEXT,
        ValorJornal TEXT,
        CostosInsumos TEXT,
        Ingresos TEXT,
        RecordStatus TEXT,
        FOREIGN KEY(TipoActividadProductivaId) REFERENCES TipoActividadProductiva(TipoActividadProductivaId),
        FOREIGN KEY(BeneficiarioId) REFERENCES Beneficiario(BeneficiarioId),
        FOREIGN KEY(FrecuenciaId) REFERENCES Frecuencia(FrecuenciaId)
      )
    ''');
  }

  @override
  Future<List<ExperienciaPecuariaModel>> getExperienciasPecuariasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('ExperienciaPecuaria');

    final experienciasPecuariasDB = List<ExperienciaPecuariaModel>.from(
        res.map((m) => ExperienciaPecuariaModel.fromJson(m))).toList();

    return experienciasPecuariasDB;
  }

  @override
  Future<ExperienciaPecuariaModel?> getExperienciaPecuariaDB(String id) async {
    final db = await DBConfig.database;

    final res = await db.query('ExperienciaPecuaria',
        where: 'ExperienciaPecuariaId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final experienciaPecuariaMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final experienciaPecuariaModel =
        ExperienciaPecuariaModel.fromJson(experienciaPecuariaMap);

    return experienciaPecuariaModel;
  }

  @override
  Future<int> saveExperienciasPecuarias(
      List<ExperienciaPecuariaEntity> experienciasPecuariasEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('ExperienciaPecuaria');

    for (var experienciaPecuaria in experienciasPecuariasEntity) {
      experienciaPecuaria.recordStatus = 'R';
      batch.insert('ExperienciaPecuaria', experienciaPecuaria.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveExperienciaPecuariaDB(
      ExperienciaPecuariaEntity experienciaPecuariaEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('ExperienciaPecuaria',
        where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
        whereArgs: [
          experienciaPecuariaEntity.tipoActividadProductivaId,
          experienciaPecuariaEntity.beneficiarioId
        ]);

    if (resQuery.isEmpty) {
      experienciaPecuariaEntity.recordStatus = 'N';
      batch.insert('ExperienciaPecuaria', experienciaPecuariaEntity.toJson());
    } else {
      experienciaPecuariaEntity.recordStatus = 'E';
      batch.update('ExperienciaPecuaria', experienciaPecuariaEntity.toJson(),
          where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
          whereArgs: [
            experienciaPecuariaEntity.tipoActividadProductivaId,
            experienciaPecuariaEntity.beneficiarioId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<ExperienciaPecuariaModel>>
      getExperienciasPecuariasProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('ExperienciaPecuaria',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final experienciasPecuariasModel = List<ExperienciaPecuariaModel>.from(
        res.map((m) => ExperienciaPecuariaModel.fromJson(m))).toList();

    return experienciasPecuariasModel;
  }

  @override
  Future<int> updateExperienciasPecuariasProduccionDB(
      List<ExperienciaPecuariaEntity>
          experienciasPecuariasProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var experienciaPecuariaProduccion
        in experienciasPecuariasProduccionEntity) {
      experienciaPecuariaProduccion.recordStatus = 'R';
      batch.update(
          'ExperienciaPecuaria', experienciaPecuariaProduccion.toJson(),
          where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
          whereArgs: [
            experienciaPecuariaProduccion.tipoActividadProductivaId,
            experienciaPecuariaProduccion.beneficiarioId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }
}
