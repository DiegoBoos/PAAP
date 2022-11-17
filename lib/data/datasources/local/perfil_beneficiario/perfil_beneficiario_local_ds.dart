import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../../domain/entities/perfil_beneficiario_entity.dart';
import '../../../models/perfil_beneficiario_model.dart';

abstract class PerfilBeneficiarioLocalDataSource {
  Future<List<PerfilBeneficiarioModel>> getPerfilBeneficiariosDB();
  Future<PerfilBeneficiarioModel?> getPerfilBeneficiarioDB(String id);
  Future<int> savePerfilBeneficiarios(
      List<PerfilBeneficiarioEntity> beneficiarioEntity);
}

class PerfilBeneficiarioLocalDataSourceImpl
    implements PerfilBeneficiarioLocalDataSource {
  static createPerfilBeneficiarioTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS PerfilBeneficiario (
        PerfilBeneficiarioId	INTEGER,
        PerfilId	TEXT NOT NULL,
        BeneficiarioId	TEXT NOT NULL,
        MunicipioId	TEXT NOT NULL,
        VeredaId	TEXT NOT NULL,
        AreaFinca	TEXT,
        AreaProyecto	TEXT,
        TipoTenenciaId	TEXT NOT NULL,
        Experiencia	TEXT,
        Asociado	TEXT,
        ConocePerfil	TEXT,
        FueBeneficiado	TEXT,
        CualBeneficio	TEXT,
        Activo	TEXT,
        PRIMARY KEY(PerfilBeneficiarioId),
        FOREIGN KEY(PerfilId) REFERENCES Perfil(PerfilId),
        FOREIGN KEY(BeneficiarioId) REFERENCES Beneficiario(BeneficiarioId),
        FOREIGN KEY(MunicipioId) REFERENCES Municipio(MunicipioId),
        FOREIGN KEY(VeredaId) REFERENCES Vereda(VeredaId),
        FOREIGN KEY(TipoTenenciaId) REFERENCES TipoTenencia(TipoTenenciaId)
      )
    ''');
  }

  @override
  Future<List<PerfilBeneficiarioModel>> getPerfilBeneficiariosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilBeneficiario');

    final beneficiariosDB = List<PerfilBeneficiarioModel>.from(
        res.map((m) => PerfilBeneficiarioModel.fromJson(m))).toList();

    return beneficiariosDB;
  }

  @override
  Future<PerfilBeneficiarioModel?> getPerfilBeneficiarioDB(String id) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilBeneficiario',
        where: 'PerfilBeneficiarioId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final beneficiarioMap = {for (var e in res[0].entries) e.key: e.value};
    final beneficiarioModel = PerfilBeneficiarioModel.fromJson(beneficiarioMap);

    return beneficiarioModel;
  }

  @override
  Future<int> savePerfilBeneficiarios(
      List<PerfilBeneficiarioEntity> beneficiarioEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilBeneficiario');

    for (var beneficiario in beneficiarioEntity) {
      batch.insert('PerfilBeneficiario', beneficiario.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
