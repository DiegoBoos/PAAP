import 'package:sqflite/sqflite.dart';

import '../../db/db_config.dart';
import '../../../domain/entities/experiencia_agricola_entity.dart';
import '../../models/experiencia_agricola_model.dart';

abstract class ExperienciaAgricolaLocalDataSource {
  Future<List<ExperienciaAgricolaModel>> getExperienciasAgricolasDB();
  Future<ExperienciaAgricolaModel?> getExperienciaAgricolaDB(
      String tipoActividadProductivaId, String beneficiarioId);
  Future<List<ExperienciaAgricolaModel>> getExperienciasAgricolasProduccionDB();
  Future<int> saveExperienciasAgricolasDB(
      List<ExperienciaAgricolaEntity> experienciasAgricolasEntity);
  Future<int> saveExperienciaAgricolaDB(
      ExperienciaAgricolaEntity experienciaAgricolaEntity);
  Future<int> updateExperienciasAgricolasProduccionDB(
      List<ExperienciaAgricolaEntity> experienciasAgricolasEntity);
}

class ExperienciaAgricolaLocalDataSourceImpl
    implements ExperienciaAgricolaLocalDataSource {
  static createExperienciaAgricolaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ExperienciaAgricola (
        TipoActividadProductivaId TEXT NOT NULL,
        BeneficiarioId TEXT NOT NULL,
        FrecuenciaId TEXT NOT NULL,
        AreaCultivo TEXT,
        CantidadProducida TEXT,
        CantidadVendida TEXT,
        CantidadAutoconsumo TEXT,
        CostoImplementacion TEXT,
        ValorJornal TEXT,
        TotalIngresoNeto TEXT,
        AreaPasto TEXT,
        AreaSinUso TEXT,
        AreaReservaConservacion TEXT,
        AreaImplementacion TEXT,
        TotalAreaPredio TEXT,
        RecordStatus TEXT,
        FOREIGN KEY(TipoActividadProductivaId) REFERENCES TipoActividadProductiva(TipoActividadProductivaId),
        FOREIGN KEY(BeneficiarioId) REFERENCES Beneficiario(BeneficiarioId),
        FOREIGN KEY(FrecuenciaId) REFERENCES Frecuencia(FrecuenciaId)
      )
    ''');
  }

  @override
  Future<List<ExperienciaAgricolaModel>> getExperienciasAgricolasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('ExperienciaAgricola');

    final experienciasAgricolasDB = List<ExperienciaAgricolaModel>.from(
        res.map((m) => ExperienciaAgricolaModel.fromJson(m))).toList();

    return experienciasAgricolasDB;
  }

  @override
  Future<ExperienciaAgricolaModel?> getExperienciaAgricolaDB(
      String tipoActividadProductivaId, String beneficiarioId) async {
    final db = await DBConfig.database;

    final res = await db.query('ExperienciaAgricola',
        where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
        whereArgs: [tipoActividadProductivaId, beneficiarioId]);

    if (res.isEmpty) return null;
    final experienciaAgricolaMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final experienciaAgricolaModel =
        ExperienciaAgricolaModel.fromJson(experienciaAgricolaMap);

    return experienciaAgricolaModel;
  }

  @override
  Future<int> saveExperienciasAgricolasDB(
      List<ExperienciaAgricolaEntity> experienciasAgricolasEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('ExperienciaAgricola');

    for (var experienciaAgricola in experienciasAgricolasEntity) {
      experienciaAgricola.recordStatus = 'R';
      batch.insert('ExperienciaAgricola', experienciaAgricola.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveExperienciaAgricolaDB(
      ExperienciaAgricolaEntity experienciaAgricolaEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('ExperienciaAgricola',
        where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
        whereArgs: [
          experienciaAgricolaEntity.tipoActividadProductivaId,
          experienciaAgricolaEntity.beneficiarioId
        ]);

    if (resQuery.isEmpty) {
      experienciaAgricolaEntity.recordStatus = 'N';
      batch.insert('ExperienciaAgricola', experienciaAgricolaEntity.toJson());
    } else {
      experienciaAgricolaEntity.recordStatus = 'E';
      batch.update('ExperienciaAgricola', experienciaAgricolaEntity.toJson(),
          where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
          whereArgs: [
            experienciaAgricolaEntity.tipoActividadProductivaId,
            experienciaAgricolaEntity.beneficiarioId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<ExperienciaAgricolaModel>>
      getExperienciasAgricolasProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('ExperienciaAgricola',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final experienciasAgricolasModel = List<ExperienciaAgricolaModel>.from(
        res.map((m) => ExperienciaAgricolaModel.fromJson(m))).toList();

    return experienciasAgricolasModel;
  }

  @override
  Future<int> updateExperienciasAgricolasProduccionDB(
      List<ExperienciaAgricolaEntity>
          experienciasAgricolasProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var experienciaAgricolaProduccion
        in experienciasAgricolasProduccionEntity) {
      experienciaAgricolaProduccion.recordStatus = 'R';
      batch.update(
          'ExperienciaAgricola', experienciaAgricolaProduccion.toJson(),
          where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
          whereArgs: [
            experienciaAgricolaProduccion.tipoActividadProductivaId,
            experienciaAgricolaProduccion.beneficiarioId
          ]);
    }

    await batch.commit();
    final query = await db.query('ExperienciaAgricola',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    return query.length;
  }
}
