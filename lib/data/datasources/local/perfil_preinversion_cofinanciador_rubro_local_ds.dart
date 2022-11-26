import 'package:sqflite/sqflite.dart';

import '../../../domain/db/db_config.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../models/perfil_preinversion_cofinanciador_rubro_model.dart';

abstract class PerfilPreInversionCofinanciadorRubroLocalDataSource {
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilPreInversionCofinanciadorRubrosDB();
  Future<PerfilPreInversionCofinanciadorRubroModel?>
      getPerfilPreInversionCofinanciadorRubroDB(
          String perfilPreInversionId, String cofinanciadorId);
  Future<int> savePerfilPreInversionCofinanciadorRubros(
      List<PerfilPreInversionCofinanciadorRubroEntity>
          perfilPreInversionCofinanciadorRubroEntity);

  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilPreInversionCofinanciadorRubrosByCofinanciadorDB(
          String perfilPreInversionId, String cofinanciadorId);
  Future<int> savePerfilPreInversionCofinanciadorRubroDB(
      PerfilPreInversionCofinanciadorRubroEntity
          perfilPreInversionCofinanciadorRubroEntity);
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilesPreInversionesCofinanciadoresRubrosProduccionDB();
  Future<int> updatePerfilesPreInversionesCofinanciadoresRubrosProduccionDB(
      List<PerfilPreInversionCofinanciadorRubroEntity>
          perfilesPreInversionesCofinanciadoresRubrosProduccionEntity);
}

class PerfilPreInversionCofinanciadorRubroLocalDataSourceImpl
    implements PerfilPreInversionCofinanciadorRubroLocalDataSource {
  static createPerfilPreInversionCofinanciadorRubroTable(Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreInversionCofinanciadorRubro (
        PerfilPreInversionId	TEXT NOT NULL,
        CofinanciadorId	TEXT NOT NULL,
        DesembolsoId	TEXT NOT NULL,
        ActividadFinancieraId	TEXT NOT NULL,
        RubroId	TEXT NOT NULL,
        Valor	TEXT,
        RecordStatus	TEXT,
        FOREIGN KEY(CofinanciadorId) REFERENCES Cofinanciador(CofinanciadorId),
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId),
        FOREIGN KEY(ActividadFinancieraId) REFERENCES ActividadFinanciera(ActividadFinancieraId),
        FOREIGN KEY(RubroId) REFERENCES Rubro(RubroId)
      )
    ''');
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilPreInversionCofinanciadorRubrosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciadorRubro');

    final perfilPreInversionCofinanciadorRubro =
        List<PerfilPreInversionCofinanciadorRubroModel>.from(res.map(
                (m) => PerfilPreInversionCofinanciadorRubroModel.fromJson(m)))
            .toList();

    return perfilPreInversionCofinanciadorRubro;
  }

  @override
  Future<PerfilPreInversionCofinanciadorRubroModel?>
      getPerfilPreInversionCofinanciadorRubroDB(
          String perfilPreInversionId, String cofinanciadorId) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciadorRubro',
        where: 'PerfilPreInversionId = ? AND CofinanciadorId = ?',
        whereArgs: [perfilPreInversionId, cofinanciadorId]);

    if (res.isEmpty) return null;
    final perfilPreInversionCofinanciadorRubroMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilPreInversionCofinanciadorRubroModel =
        PerfilPreInversionCofinanciadorRubroModel.fromJson(
            perfilPreInversionCofinanciadorRubroMap);

    return perfilPreInversionCofinanciadorRubroModel;
  }

  @override
  Future<int> savePerfilPreInversionCofinanciadorRubros(
      List<PerfilPreInversionCofinanciadorRubroEntity>
          perfilPreInversionCofinanciadorRubroEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversionCofinanciadorRubro');

    for (var perfilPreInversionCofinanciadorRubro
        in perfilPreInversionCofinanciadorRubroEntity) {
      perfilPreInversionCofinanciadorRubro.recordStatus = 'R';
      batch.insert('PerfilPreInversionCofinanciadorRubro',
          perfilPreInversionCofinanciadorRubro.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilPreInversionCofinanciadorRubrosByCofinanciadorDB(
          String perfilPreInversionId, String cofinanciadorId) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciadorRubro',
        where: 'PerfilPreInversionId = ? AND CofinanciadorId = ?',
        whereArgs: [perfilPreInversionId, cofinanciadorId]);

    final perfilPreInversionCofinanciadorRubro =
        List<PerfilPreInversionCofinanciadorRubroModel>.from(res.map(
                (m) => PerfilPreInversionCofinanciadorRubroModel.fromJson(m)))
            .toList();

    return perfilPreInversionCofinanciadorRubro;
  }

  @override
  Future<int> savePerfilPreInversionCofinanciadorRubroDB(
      PerfilPreInversionCofinanciadorRubroEntity
          perfilPreInversionCofinanciadorRubroEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilPreInversionCofinanciadorRubro',
        where: 'RubroId = ? AND PerfilPreInversionId = ?',
        whereArgs: [
          perfilPreInversionCofinanciadorRubroEntity.rubroId,
          perfilPreInversionCofinanciadorRubroEntity.perfilPreInversionId
        ]);

    if (resQuery.isEmpty) {
      perfilPreInversionCofinanciadorRubroEntity.recordStatus = 'N';
      batch.insert('PerfilPreInversionCofinanciadorRubro',
          perfilPreInversionCofinanciadorRubroEntity.toJson());
    } else {
      perfilPreInversionCofinanciadorRubroEntity.recordStatus = 'E';
      batch.update('PerfilPreInversionCofinanciadorRubro',
          perfilPreInversionCofinanciadorRubroEntity.toJson(),
          where: 'RubroId = ? AND PerfilPreInversionId = ?',
          whereArgs: [
            perfilPreInversionCofinanciadorRubroEntity.rubroId,
            perfilPreInversionCofinanciadorRubroEntity.perfilPreInversionId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilesPreInversionesCofinanciadoresRubrosProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciadorRubro',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final perfilesPreInversionesCofinanciadoresRubrosModel =
        List<PerfilPreInversionCofinanciadorRubroModel>.from(res.map(
                (m) => PerfilPreInversionCofinanciadorRubroModel.fromJson(m)))
            .toList();

    return perfilesPreInversionesCofinanciadoresRubrosModel;
  }

  @override
  Future<int> updatePerfilesPreInversionesCofinanciadoresRubrosProduccionDB(
      List<PerfilPreInversionCofinanciadorRubroEntity>
          perfilesPreInversionesCofinanciadoresRubrosProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var perfilPreInversionCofinanciadorRubroProduccion
        in perfilesPreInversionesCofinanciadoresRubrosProduccionEntity) {
      perfilPreInversionCofinanciadorRubroProduccion.recordStatus = 'R';
      batch.update('PerfilPreInversionCofinanciadorRubro',
          perfilPreInversionCofinanciadorRubroProduccion.toJson(),
          where: 'RubroId = ? AND PerfilPreInversionId = ?',
          whereArgs: [
            perfilPreInversionCofinanciadorRubroProduccion.rubroId,
            perfilPreInversionCofinanciadorRubroProduccion.perfilPreInversionId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }
}
