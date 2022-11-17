import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../domain/entities/experiencia_pecuaria_entity.dart';
import '../../models/experiencia_pecuaria_model.dart';

abstract class ExperienciaPecuariaLocalDataSource {
  Future<List<ExperienciaPecuariaModel>> getExperienciasPecuariasDB();
  Future<ExperienciaPecuariaModel?> getExperienciaPecuariaDB(String id);
  Future<int> saveExperienciasPecuarias(
      List<ExperienciaPecuariaEntity> experienciaPecuariaEntity);
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
      List<ExperienciaPecuariaEntity> experienciaPecuariaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('ExperienciaPecuaria');

    for (var experienciaPecuaria in experienciaPecuariaEntity) {
      batch.insert('ExperienciaPecuaria', experienciaPecuaria.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
