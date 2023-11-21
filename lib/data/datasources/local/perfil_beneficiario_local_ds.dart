import 'package:sqflite/sqflite.dart';

import '../../db/db_config.dart';
import '../../../domain/entities/perfil_beneficiario_entity.dart';
import '../../models/perfil_beneficiario_model.dart';

abstract class PerfilBeneficiarioLocalDataSource {
  Future<List<PerfilBeneficiarioModel>> getPerfilBeneficiariosDB();
  Future<List<PerfilBeneficiarioModel>> getPerfilesBeneficiariosProduccionDB();
  Future<PerfilBeneficiarioModel?> getPerfilBeneficiarioDB(
      String perfilId, String beneficiarioId);
  Future<int> savePerfilBeneficiarios(
      List<PerfilBeneficiarioEntity> perfilesBeneficiariosEntity);
  Future<int> savePerfilBeneficiarioDB(
      PerfilBeneficiarioEntity perfilBeneficiarioEntity);
  Future<int> updatePerfilesBeneficiariosProduccionDB(
      List<PerfilBeneficiarioEntity> perfilesBeneficiariosEntity);
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
        RecordStatus	TEXT,
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
  Future<PerfilBeneficiarioModel?> getPerfilBeneficiarioDB(
      String perfilId, String beneficiarioId) async {
    final db = await DBConfig.database;
    final res = await db.query('PerfilBeneficiario',
        where: 'PerfilId = ? AND BeneficiarioId = ?',
        whereArgs: [perfilId, beneficiarioId]);

    if (res.isEmpty) return null;

    final perfilBeneficiarioMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilBeneficiarioModel =
        PerfilBeneficiarioModel.fromJson(perfilBeneficiarioMap);

    return perfilBeneficiarioModel;
  }

  @override
  Future<int> savePerfilBeneficiarios(
      List<PerfilBeneficiarioEntity> perfilesBeneficiariosEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilBeneficiario');

    for (var perfilBeneficiario in perfilesBeneficiariosEntity) {
      perfilBeneficiario.recordStatus = 'R';
      batch.insert('PerfilBeneficiario', perfilBeneficiario.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> savePerfilBeneficiarioDB(
      PerfilBeneficiarioEntity perfilBeneficiarioEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilBeneficiario',
        where: 'PerfilId = ? AND BeneficiarioId = ?',
        whereArgs: [
          perfilBeneficiarioEntity.perfilId,
          perfilBeneficiarioEntity.beneficiarioId
        ]);

    if (resQuery.isEmpty) {
      perfilBeneficiarioEntity.recordStatus = 'N';
      batch.insert('PerfilBeneficiario', perfilBeneficiarioEntity.toJson());
    } else {
      perfilBeneficiarioEntity.recordStatus = 'E';
      batch.update('PerfilBeneficiario', perfilBeneficiarioEntity.toJson(),
          where: 'PerfilId = ? AND BeneficiarioId = ?',
          whereArgs: [
            perfilBeneficiarioEntity.perfilId,
            perfilBeneficiarioEntity.beneficiarioId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilBeneficiarioModel>>
      getPerfilesBeneficiariosProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilBeneficiario',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final perfilesBeneficiariosModel = List<PerfilBeneficiarioModel>.from(
        res.map((m) => PerfilBeneficiarioModel.fromJson(m))).toList();

    return perfilesBeneficiariosModel;
  }

  @override
  Future<int> updatePerfilesBeneficiariosProduccionDB(
      List<PerfilBeneficiarioEntity>
          perfilesBeneficiariosProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var perfilBeneficiarioProduccion
        in perfilesBeneficiariosProduccionEntity) {
      perfilBeneficiarioProduccion.recordStatus = 'R';
      batch.update('PerfilBeneficiario', perfilBeneficiarioProduccion.toJson(),
          where: 'PerfilId = ? AND BeneficiarioId = ?',
          whereArgs: [
            perfilBeneficiarioProduccion.perfilId,
            perfilBeneficiarioProduccion.beneficiarioId
          ]);
    }

    await batch.commit();
    final query = await db.query('PerfilBeneficiario',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    return query.length;
  }
}
