import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../domain/entities/experiencia_agricola_entity.dart';
import '../../models/experiencia_agricola_model.dart';

abstract class ExperienciaAgricolaLocalDataSource {
  Future<List<ExperienciaAgricolaModel>> getExperienciasAgricolasDB();
  Future<ExperienciaAgricolaModel?> getExperienciaAgricolaDB(String id);
  Future<int> saveExperienciasAgricolas(
      List<ExperienciaAgricolaEntity> experienciaAgricolaEntity);
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
  Future<ExperienciaAgricolaModel?> getExperienciaAgricolaDB(String id) async {
    final db = await DBConfig.database;

    final res = await db.query('ExperienciaAgricola',
        where: 'ExperienciaAgricolaId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final experienciaAgricolaMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final experienciaAgricolaModel =
        ExperienciaAgricolaModel.fromJson(experienciaAgricolaMap);

    return experienciaAgricolaModel;
  }

  @override
  Future<int> saveExperienciasAgricolas(
      List<ExperienciaAgricolaEntity> experienciaAgricolaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('ExperienciaAgricola');

    for (var experienciaAgricola in experienciaAgricolaEntity) {
      batch.insert('ExperienciaAgricola', experienciaAgricola.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
