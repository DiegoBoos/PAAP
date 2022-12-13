import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../domain/entities/alianza_experiencia_pecuaria_entity.dart';
import '../../models/alianza_experiencia_pecuaria_model.dart';

abstract class AlianzaExperienciaPecuariaLocalDataSource {
  Future<List<AlianzaExperienciaPecuariaModel>>
      getAlianzasExperienciasPecuariasDB();
  Future<List<AlianzaExperienciaPecuariaModel>>
      getAlianzasExperienciasPecuariasProduccionDB();
  Future<AlianzaExperienciaPecuariaModel?> getAlianzaExperienciaPecuariaDB(
      String tipoActividadProductivaId, String beneficiarioId);
  Future<int> saveAlianzasExperienciasPecuarias(
      List<AlianzaExperienciaPecuariaEntity>
          alianzasExperienciasPecuariasEntity);
  Future<int> saveAlianzaExperienciaPecuariaDB(
      AlianzaExperienciaPecuariaEntity alianzaExperienciaPecuariaEntity);
  Future<int> updateAlianzasExperienciasPecuariasProduccionDB(
      List<AlianzaExperienciaPecuariaEntity>
          alianzasExperienciasPecuariasEntity);
}

class AlianzaExperienciaPecuariaLocalDataSourceImpl
    implements AlianzaExperienciaPecuariaLocalDataSource {
  static createAlianzaExperienciaPecuariaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS AlianzaExperienciaPecuaria (
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
  Future<List<AlianzaExperienciaPecuariaModel>>
      getAlianzasExperienciasPecuariasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('AlianzaExperienciaPecuaria');

    final experienciasPecuariasDB = List<AlianzaExperienciaPecuariaModel>.from(
        res.map((m) => AlianzaExperienciaPecuariaModel.fromJson(m))).toList();

    return experienciasPecuariasDB;
  }

  @override
  Future<AlianzaExperienciaPecuariaModel?> getAlianzaExperienciaPecuariaDB(
      String tipoActividadProductivaId, String beneficiarioId) async {
    final db = await DBConfig.database;

    final res = await db.query('AlianzaExperienciaPecuaria',
        where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
        whereArgs: [tipoActividadProductivaId, beneficiarioId]);

    if (res.isEmpty) return null;
    final alianzaExperienciaPecuariaMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final alianzaExperienciaPecuariaModel =
        AlianzaExperienciaPecuariaModel.fromJson(alianzaExperienciaPecuariaMap);

    return alianzaExperienciaPecuariaModel;
  }

  @override
  Future<int> saveAlianzasExperienciasPecuarias(
      List<AlianzaExperienciaPecuariaEntity>
          alianzasExperienciasPecuariasEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('AlianzaExperienciaPecuaria');

    for (var alianzaExperienciaPecuaria
        in alianzasExperienciasPecuariasEntity) {
      alianzaExperienciaPecuaria.recordStatus = 'R';
      batch.insert(
          'AlianzaExperienciaPecuaria', alianzaExperienciaPecuaria.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveAlianzaExperienciaPecuariaDB(
      AlianzaExperienciaPecuariaEntity alianzaExperienciaPecuariaEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('AlianzaExperienciaPecuaria',
        where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
        whereArgs: [
          alianzaExperienciaPecuariaEntity.tipoActividadProductivaId,
          alianzaExperienciaPecuariaEntity.beneficiarioId
        ]);

    if (resQuery.isEmpty) {
      alianzaExperienciaPecuariaEntity.recordStatus = 'N';
      batch.insert('AlianzaExperienciaPecuaria',
          alianzaExperienciaPecuariaEntity.toJson());
    } else {
      alianzaExperienciaPecuariaEntity.recordStatus = 'E';
      batch.update('AlianzaExperienciaPecuaria',
          alianzaExperienciaPecuariaEntity.toJson(),
          where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
          whereArgs: [
            alianzaExperienciaPecuariaEntity.tipoActividadProductivaId,
            alianzaExperienciaPecuariaEntity.beneficiarioId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<AlianzaExperienciaPecuariaModel>>
      getAlianzasExperienciasPecuariasProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('AlianzaExperienciaPecuaria',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final experienciasPecuariasModel =
        List<AlianzaExperienciaPecuariaModel>.from(
                res.map((m) => AlianzaExperienciaPecuariaModel.fromJson(m)))
            .toList();

    return experienciasPecuariasModel;
  }

  @override
  Future<int> updateAlianzasExperienciasPecuariasProduccionDB(
      List<AlianzaExperienciaPecuariaEntity>
          experienciasPecuariasProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var alianzaExperienciaPecuariaProduccion
        in experienciasPecuariasProduccionEntity) {
      alianzaExperienciaPecuariaProduccion.recordStatus = 'R';
      batch.update('AlianzaExperienciaPecuaria',
          alianzaExperienciaPecuariaProduccion.toJson(),
          where: 'TipoActividadProductivaId = ? AND BeneficiarioId = ?',
          whereArgs: [
            alianzaExperienciaPecuariaProduccion.tipoActividadProductivaId,
            alianzaExperienciaPecuariaProduccion.beneficiarioId
          ]);
    }

    await batch.commit();

    final query = await db.query('AlianzaExperienciaPecuaria',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    return query.length;
  }
}
