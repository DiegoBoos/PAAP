import 'package:sqflite/sqflite.dart';

import '../../../domain/db/db_config.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../models/perfil_preinversion_cofinanciador_actividad_financiera_model.dart';

abstract class PerfilPreInversionCofinanciadorActividadFinancieraLocalDataSource {
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasDB();
  Future<PerfilPreInversionCofinanciadorActividadFinancieraModel?>
      getPerfilPreInversionCofinanciadorActividadFinancieraDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String actividadFinancieraId,
          String desembolsoId);
  Future<int> savePerfilPreInversionCofinanciadorActividadesFinancieras(
      List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
          perfilPreInversionCofinanciadorActividadFinancieraEntity);
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciadorDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String actividadFinancieraId,
          String desembolsoId);
  Future<int> savePerfilPreInversionCofinanciadorActividadFinancieraDB(
      PerfilPreInversionCofinanciadorActividadFinancieraEntity
          perfilPreInversionCofinanciadorActividadFinancieraEntity);
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionDB();
  Future<int>
      updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionDB(
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionEntity);
}

class PerfilPreInversionCofinanciadorActividadFinancieraLocalDataSourceImpl
    implements
        PerfilPreInversionCofinanciadorActividadFinancieraLocalDataSource {
  static createPerfilPreInversionCofinanciadorActividadFinancieraTable(
      Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreInversionCofinanciadorActividadFinanciera (
        ActividadFinancieraId	TEXT NOT NULL,
        PerfilPreInversionId	TEXT NOT NULL,
        CofinanciadorId	TEXT NOT NULL,
        DesembolsoId	TEXT NOT NULL,
        Valor	TEXT,
        RecordStatus	TEXT,
        FOREIGN KEY(ActividadFinancieraId) REFERENCES ActividadFinanciera(ActividadFinancieraId),
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId),
        FOREIGN KEY(CofinanciadorId) REFERENCES Cofinanciador(CofinanciadorId),
        FOREIGN KEY(DesembolsoId) REFERENCES Desembolso(DesembolsoId)
      )
    ''');
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasDB() async {
    final db = await DBConfig.database;

    final res =
        await db.query('PerfilPreInversionCofinanciadorActividadFinanciera');

    final perfilPreInversionCofinanciadorActividadFinanciera =
        List<PerfilPreInversionCofinanciadorActividadFinancieraModel>.from(res
            .map((m) => PerfilPreInversionCofinanciadorActividadFinancieraModel
                .fromJson(m))).toList();

    return perfilPreInversionCofinanciadorActividadFinanciera;
  }

  @override
  Future<PerfilPreInversionCofinanciadorActividadFinancieraModel?>
      getPerfilPreInversionCofinanciadorActividadFinancieraDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String actividadFinancieraId,
          String desembolsoId) async {
    final db = await DBConfig.database;

    final res = await db.query(
        'PerfilPreInversionCofinanciadorActividadFinanciera',
        where:
            'PerfilPreInversionId = ? AND CofinanciadorId = ? AND ActividadFinancieraId = ? AND DesembolsoId = ?',
        whereArgs: [
          perfilPreInversionId,
          cofinanciadorId,
          actividadFinancieraId,
          desembolsoId
        ]);

    if (res.isEmpty) return null;
    final perfilPreInversionCofinanciadorActividadFinancieraMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilPreInversionCofinanciadorActividadFinancieraModel =
        PerfilPreInversionCofinanciadorActividadFinancieraModel.fromJson(
            perfilPreInversionCofinanciadorActividadFinancieraMap);

    return perfilPreInversionCofinanciadorActividadFinancieraModel;
  }

  @override
  Future<int> savePerfilPreInversionCofinanciadorActividadesFinancieras(
      List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
          perfilPreInversionCofinanciadorActividadFinancieraEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversionCofinanciadorActividadFinanciera');

    for (var perfilPreInversionCofinanciadorActividadFinanciera
        in perfilPreInversionCofinanciadorActividadFinancieraEntity) {
      perfilPreInversionCofinanciadorActividadFinanciera.recordStatus = 'R';
      batch.insert('PerfilPreInversionCofinanciadorActividadFinanciera',
          perfilPreInversionCofinanciadorActividadFinanciera.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciadorDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String actividadFinancieraId,
          String desembolsoId) async {
    final db = await DBConfig.database;

    final res = await db.query(
        'PerfilPreInversionCofinanciadorActividadFinanciera',
        where:
            'PerfilPreInversionId = ? AND CofinanciadorId = ? AND ActividadFinancieraId = ? AND DesembolsoId = ?',
        whereArgs: [
          perfilPreInversionId,
          cofinanciadorId,
          actividadFinancieraId,
          desembolsoId
        ]);

    final perfilPreInversionCofinanciadorActividadFinanciera =
        List<PerfilPreInversionCofinanciadorActividadFinancieraModel>.from(res
            .map((m) => PerfilPreInversionCofinanciadorActividadFinancieraModel
                .fromJson(m))).toList();

    return perfilPreInversionCofinanciadorActividadFinanciera;
  }

  @override
  Future<int> savePerfilPreInversionCofinanciadorActividadFinancieraDB(
      PerfilPreInversionCofinanciadorActividadFinancieraEntity
          perfilPreInversionCofinanciadorActividadFinancieraEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query(
        'PerfilPreInversionCofinanciadorActividadFinanciera',
        where:
            'ActividadFinancieraId = ? AND PerfilPreInversionId = ? AND ActividadFinancieraId = ? AND DesembolsoId = ?',
        whereArgs: [
          perfilPreInversionCofinanciadorActividadFinancieraEntity
              .actividadFinancieraId,
          perfilPreInversionCofinanciadorActividadFinancieraEntity
              .perfilPreInversionId,
          perfilPreInversionCofinanciadorActividadFinancieraEntity
              .actividadFinancieraId,
          perfilPreInversionCofinanciadorActividadFinancieraEntity.desembolsoId
        ]);

    if (resQuery.isEmpty) {
      perfilPreInversionCofinanciadorActividadFinancieraEntity.recordStatus =
          'N';
      batch.insert('PerfilPreInversionCofinanciadorActividadFinanciera',
          perfilPreInversionCofinanciadorActividadFinancieraEntity.toJson());
    } else {
      perfilPreInversionCofinanciadorActividadFinancieraEntity.recordStatus =
          'E';
      batch.update('PerfilPreInversionCofinanciadorActividadFinanciera',
          perfilPreInversionCofinanciadorActividadFinancieraEntity.toJson(),
          where:
              'ActividadFinancieraId = ? AND PerfilPreInversionId = ? AND ActividadFinancieraId = ? AND DesembolsoId = ?',
          whereArgs: [
            perfilPreInversionCofinanciadorActividadFinancieraEntity
                .actividadFinancieraId,
            perfilPreInversionCofinanciadorActividadFinancieraEntity
                .perfilPreInversionId,
            perfilPreInversionCofinanciadorActividadFinancieraEntity
                .actividadFinancieraId,
            perfilPreInversionCofinanciadorActividadFinancieraEntity
                .desembolsoId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query(
        'PerfilPreInversionCofinanciadorActividadFinanciera',
        where: 'RecordStatus <> ?',
        whereArgs: ['R']);

    if (res.isEmpty) return [];

    final perfilesPreInversionesCofinanciadoresActividadesFinancierasModel =
        List<PerfilPreInversionCofinanciadorActividadFinancieraModel>.from(res
            .map((m) => PerfilPreInversionCofinanciadorActividadFinancieraModel
                .fromJson(m))).toList();

    return perfilesPreInversionesCofinanciadoresActividadesFinancierasModel;
  }

  @override
  Future<int>
      updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionDB(
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var perfilPreInversionCofinanciadorActividadFinancieraProduccion
        in perfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionEntity) {
      perfilPreInversionCofinanciadorActividadFinancieraProduccion
          .recordStatus = 'R';
      batch.update('PerfilPreInversionCofinanciadorActividadFinanciera',
          perfilPreInversionCofinanciadorActividadFinancieraProduccion.toJson(),
          where:
              'ActividadFinancieraId = ? AND PerfilPreInversionId = ? AND ActividadFinancieraId = ? AND DesembolsoId = ?',
          whereArgs: [
            perfilPreInversionCofinanciadorActividadFinancieraProduccion
                .actividadFinancieraId,
            perfilPreInversionCofinanciadorActividadFinancieraProduccion
                .perfilPreInversionId,
            perfilPreInversionCofinanciadorActividadFinancieraProduccion
                .actividadFinancieraId,
            perfilPreInversionCofinanciadorActividadFinancieraProduccion
                .desembolsoId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }
}
