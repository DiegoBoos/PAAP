import 'package:sqflite/sqflite.dart';

import '../../db/db_config.dart';
import '../../../domain/entities/alianza_experiencia_agricola_entity.dart';
import '../../models/alianza_experiencia_agricola_model.dart';

abstract class AlianzaExperienciaAgricolaLocalDataSource {
  Future<List<AlianzaExperienciaAgricolaModel>>
      getAlianzasExperienciasAgricolasDB();
  Future<AlianzaExperienciaAgricolaModel?> getAlianzaExperienciaAgricolaDB(
      String tipoActividadProductivaId, String beneficiarioId);
  Future<List<AlianzaExperienciaAgricolaModel>>
      getAlianzasExperienciasAgricolasProduccionDB();
  Future<int> saveAlianzasExperienciasAgricolasDB(
      List<AlianzaExperienciaAgricolaEntity>
          alianzasExperienciasAgricolasEntity);
  Future<int> saveAlianzaExperienciaAgricolaDB(
      AlianzaExperienciaAgricolaEntity alianzaExperienciaAgricolaEntity);
  Future<int> updateAlianzasExperienciasAgricolasProduccionDB(
      List<AlianzaExperienciaAgricolaEntity>
          alianzasExperienciasAgricolasEntity);
}

class AlianzaExperienciaAgricolaLocalDataSourceImpl
    implements AlianzaExperienciaAgricolaLocalDataSource {
  static createAlianzaExperienciaAgricolaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS AlianzaExperienciaAgricola (
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
  Future<List<AlianzaExperienciaAgricolaModel>>
      getAlianzasExperienciasAgricolasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('AlianzaExperienciaAgricola');

    final alianzasExperienciasAgricolasDB =
        List<AlianzaExperienciaAgricolaModel>.from(
                res.map((m) => AlianzaExperienciaAgricolaModel.fromJson(m)))
            .toList();

    return alianzasExperienciasAgricolasDB;
  }

  @override
  Future<AlianzaExperienciaAgricolaModel?> getAlianzaExperienciaAgricolaDB(
      String tipoActividadProductivaId, String beneficiarioId) async {
    final db = await DBConfig.database;

    final res = await db.query('AlianzaExperienciaAgricola',
        where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
        whereArgs: [tipoActividadProductivaId, beneficiarioId]);

    if (res.isEmpty) return null;
    final alianzaExperienciaAgricolaMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final alianzaExperienciaAgricolaModel =
        AlianzaExperienciaAgricolaModel.fromJson(alianzaExperienciaAgricolaMap);

    return alianzaExperienciaAgricolaModel;
  }

  @override
  Future<int> saveAlianzasExperienciasAgricolasDB(
      List<AlianzaExperienciaAgricolaEntity>
          alianzasExperienciasAgricolasEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('AlianzaExperienciaAgricola');

    for (var alianzaExperienciaAgricola
        in alianzasExperienciasAgricolasEntity) {
      alianzaExperienciaAgricola.recordStatus = 'R';
      batch.insert(
          'AlianzaExperienciaAgricola', alianzaExperienciaAgricola.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveAlianzaExperienciaAgricolaDB(
      AlianzaExperienciaAgricolaEntity alianzaExperienciaAgricolaEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('AlianzaExperienciaAgricola',
        where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
        whereArgs: [
          alianzaExperienciaAgricolaEntity.tipoActividadProductivaId,
          alianzaExperienciaAgricolaEntity.beneficiarioId
        ]);

    if (resQuery.isEmpty) {
      alianzaExperienciaAgricolaEntity.recordStatus = 'N';
      batch.insert('AlianzaExperienciaAgricola',
          alianzaExperienciaAgricolaEntity.toJson());
    } else {
      alianzaExperienciaAgricolaEntity.recordStatus = 'E';
      batch.update('AlianzaExperienciaAgricola',
          alianzaExperienciaAgricolaEntity.toJson(),
          where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
          whereArgs: [
            alianzaExperienciaAgricolaEntity.tipoActividadProductivaId,
            alianzaExperienciaAgricolaEntity.beneficiarioId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<AlianzaExperienciaAgricolaModel>>
      getAlianzasExperienciasAgricolasProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('AlianzaExperienciaAgricola',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final alianzasExperienciasAgricolasModel =
        List<AlianzaExperienciaAgricolaModel>.from(
                res.map((m) => AlianzaExperienciaAgricolaModel.fromJson(m)))
            .toList();

    return alianzasExperienciasAgricolasModel;
  }

  @override
  Future<int> updateAlianzasExperienciasAgricolasProduccionDB(
      List<AlianzaExperienciaAgricolaEntity>
          alianzasExperienciasAgricolasProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var alianzaExperienciaAgricolaProduccion
        in alianzasExperienciasAgricolasProduccionEntity) {
      alianzaExperienciaAgricolaProduccion.recordStatus = 'R';
      batch.update('AlianzaExperienciaAgricola',
          alianzaExperienciaAgricolaProduccion.toJson(),
          where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
          whereArgs: [
            alianzaExperienciaAgricolaProduccion.tipoActividadProductivaId,
            alianzaExperienciaAgricolaProduccion.beneficiarioId
          ]);
    }

    await batch.commit();

    final query = await db.query('AlianzaExperienciaAgricola',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    return query.length;
  }
}
