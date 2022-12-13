import 'package:sqflite/sqflite.dart';

import '../../../domain/db/db_config.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../models/perfil_preinversion_cofinanciador_actividad_financiera_model.dart';

abstract class PerfilPreInversionCofinanciadorActividadFinancieraLocalDataSource {
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilPreInversionCofinanciadorActividadesFinancieras();

  Future<PerfilPreInversionCofinanciadorActividadFinancieraModel?>
      getPerfilPreInversionCofinanciadorActividadFinanciera(
    String perfilPreInversionId,
    String cofinanciadorId,
  );

  Future<int> savePerfilPreInversionCofinanciadorActividadesFinancieras(
      List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
          perfilPreInversionCofinanciadorActividadFinancieraEntity);

  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
          String perfilPreInversionId, String cofinanciadorId);

  Future<int> savePerfilPreInversionCofinanciadorActividadFinanciera(
      PerfilPreInversionCofinanciadorActividadFinancieraEntity
          perfilPreInversionCofinanciadorActividadFinancieraEntity);

  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccion();

  Future<int>
      updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccion(
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
      getPerfilPreInversionCofinanciadorActividadesFinancieras() async {
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
      getPerfilPreInversionCofinanciadorActividadFinanciera(
    String perfilPreInversionId,
    String cofinanciadorId,
  ) async {
    final db = await DBConfig.database;

    final res = await db.query(
        'PerfilPreInversionCofinanciadorActividadFinanciera',
        where: 'PerfilPreInversionId = ? AND CofinanciadorId = ?',
        whereArgs: [perfilPreInversionId, cofinanciadorId]);

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
      getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
          String perfilPreInversionId, String cofinanciadorId) async {
    final db = await DBConfig.database;

    String sql = '''
      select
      PerfilPreInversionCofinanciadorActividadFinanciera.ActividadFinancieraId,
      PerfilPreInversionCofinanciadorActividadFinanciera.PerfilPreInversionId,
      PerfilPreInversionCofinanciadorActividadFinanciera.CofinanciadorId,
      PerfilPreInversionCofinanciadorActividadFinanciera.DesembolsoId,
      Valor,
      ActividadFinanciera.Nombre as ActividadFinanciera,
      Desembolso.Nombre as Desembolso
      from PerfilPreInversionCofinanciadorActividadFinanciera
      left join ActividadFinanciera on (ActividadFinanciera.ActividadFinancieraId=PerfilPreInversionCofinanciadorActividadFinanciera.ActividadFinancieraId)
      left join Desembolso on (Desembolso.DesembolsoId=PerfilPreInversionCofinanciadorActividadFinanciera.DesembolsoId)
      where PerfilPreInversionCofinanciadorActividadFinanciera.PerfilPreInversionId = $perfilPreInversionId 
      AND PerfilPreInversionCofinanciadorActividadFinanciera.CofinanciadorId = $cofinanciadorId
      ''';

    final res = await db.rawQuery(sql);

    final perfilPreInversionCofinanciadorActividadFinanciera =
        List<PerfilPreInversionCofinanciadorActividadFinancieraModel>.from(res
            .map((m) => PerfilPreInversionCofinanciadorActividadFinancieraModel
                .fromJson(m))).toList();

    return perfilPreInversionCofinanciadorActividadFinanciera;
  }

  @override
  Future<int> savePerfilPreInversionCofinanciadorActividadFinanciera(
      PerfilPreInversionCofinanciadorActividadFinancieraEntity
          perfilPreInversionCofinanciadorActividadFinancieraEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query(
        'PerfilPreInversionCofinanciadorActividadFinanciera',
        where:
            'ActividadFinancieraId = ? AND PerfilPreInversionId = ? AND CofinanciadorId = ? AND DesembolsoId = ?',
        whereArgs: [
          perfilPreInversionCofinanciadorActividadFinancieraEntity
              .actividadFinancieraId,
          perfilPreInversionCofinanciadorActividadFinancieraEntity
              .perfilPreInversionId,
          perfilPreInversionCofinanciadorActividadFinancieraEntity
              .cofinanciadorId,
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
              'ActividadFinancieraId = ? AND PerfilPreInversionId = ? AND CofinanciadorId = ? AND DesembolsoId = ?',
          whereArgs: [
            perfilPreInversionCofinanciadorActividadFinancieraEntity
                .actividadFinancieraId,
            perfilPreInversionCofinanciadorActividadFinancieraEntity
                .perfilPreInversionId,
            perfilPreInversionCofinanciadorActividadFinancieraEntity
                .cofinanciadorId,
            perfilPreInversionCofinanciadorActividadFinancieraEntity
                .desembolsoId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccion() async {
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
      updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccion(
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
              'ActividadFinancieraId = ? AND PerfilPreInversionId = ? AND CofinanciadorId = ? AND DesembolsoId = ?',
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

    await batch.commit();
    final query = await db.query(
        'PerfilPreInversionCofinanciadorActividadFinanciera',
        where: 'RecordStatus <> ?',
        whereArgs: ['R']);

    return query.length;
  }
}
