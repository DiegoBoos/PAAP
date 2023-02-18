import 'package:sqflite/sqflite.dart';

import '../../../domain/db/db_config.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../models/perfil_preinversion_cofinanciador_rubro_model.dart';

abstract class PerfilPreInversionCofinanciadorRubroLocalDataSource {
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilPreInversionCofinanciadorRubros();

  Future<PerfilPreInversionCofinanciadorRubroModel?>
      getPerfilPreInversionCofinanciadorRubro(
          String perfilPreInversionId, String cofinanciadorId);

  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilPreInversionCofinanciadorRubrosByCofinanciador(
          String perfilPreInversionId, String cofinanciadorId);

  Future<int> savePerfilPreInversionCofinanciadorRubros(
      List<PerfilPreInversionCofinanciadorRubroEntity>
          perfilPreInversionCofinanciadorRubroEntity);

  Future<int> savePerfilPreInversionCofinanciadorRubro(
      PerfilPreInversionCofinanciadorRubroEntity
          perfilPreInversionCofinanciadorRubroEntity);

  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilesPreInversionesCofinanciadoresRubrosProduccion();

  Future<int> updatePerfilesPreInversionesCofinanciadoresRubrosProduccion(
      List<PerfilPreInversionCofinanciadorRubroEntity>
          perfilesPreInversionesCofinanciadoresRubrosProduccionEntity);
}

class PerfilPreInversionCofinanciadorRubroLocalDataSourceImpl
    implements PerfilPreInversionCofinanciadorRubroLocalDataSource {
  static createPerfilPreInversionCofinanciadorRubroTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS PerfilPreInversionCofinanciadorRubro (
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
      getPerfilPreInversionCofinanciadorRubros() async {
    final db = await DBConfig.database;

    String sql = '''
       select 
      PerfilPreInversionCofinanciadorRubro.PerfilPreInversionId,
      PerfilPreInversionCofinanciadorRubro.CofinanciadorId,
      PerfilPreInversionCofinanciadorRubro.DesembolsoId,
      PerfilPreInversionCofinanciadorRubro.ActividadFinancieraId,
      RubroId,
      Valor,
      ActividadFinanciera.Nombre as ActividadFinanciera,
      Rubro.Nombre as Rubro,
      Desembolso.Nombre as Desembolso
      from PerfilPreInversionCofinanciadorRubro
      left join ActividadFinanciera on (ActividadFinanciera.ActividadFinancieraId=PerfilPreInversionCofinanciadorRubro.ActividadFinancieraId)
      left join Rubro on (Rubro.RubroId=PerfilPreInversionCofinanciadorRubro.RubroId)
      left join Desembolso on (Desembolso.DesembolsoId=PerfilPreInversionCofinanciadorRubro.DesembolsoId)
      ''';

    final res = await db.rawQuery(sql);

    final perfilPreInversionCofinanciadorRubro =
        List<PerfilPreInversionCofinanciadorRubroModel>.from(res.map(
                (m) => PerfilPreInversionCofinanciadorRubroModel.fromJson(m)))
            .toList();

    return perfilPreInversionCofinanciadorRubro;
  }

  @override
  Future<PerfilPreInversionCofinanciadorRubroModel?>
      getPerfilPreInversionCofinanciadorRubro(
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
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilPreInversionCofinanciadorRubrosByCofinanciador(
          String perfilPreInversionId, String cofinanciadorId) async {
    final db = await DBConfig.database;

    String sql = '''
      select 
      PerfilPreInversionCofinanciadorRubro.PerfilPreInversionId,
      PerfilPreInversionCofinanciadorRubro.CofinanciadorId,
      PerfilPreInversionCofinanciadorRubro.DesembolsoId,
      PerfilPreInversionCofinanciadorRubro.ActividadFinancieraId,
      PerfilPreInversionCofinanciadorRubro.RubroId,
      Valor,
      ActividadFinanciera.Nombre as ActividadFinanciera,
      Rubro.Nombre as Rubro,
      Desembolso.Nombre as Desembolso
      from PerfilPreInversionCofinanciadorRubro
      left join ActividadFinanciera on (ActividadFinanciera.ActividadFinancieraId=PerfilPreInversionCofinanciadorRubro.ActividadFinancieraId)
      left join Rubro on (Rubro.RubroId=PerfilPreInversionCofinanciadorRubro.RubroId)
      left join Desembolso on (Desembolso.DesembolsoId=PerfilPreInversionCofinanciadorRubro.DesembolsoId)
      where PerfilPreInversionId = $perfilPreInversionId AND CofinanciadorId = $cofinanciadorId
      ''';

    final res = await db.rawQuery(sql);

    final perfilPreInversionCofinanciadorRubro =
        List<PerfilPreInversionCofinanciadorRubroModel>.from(res.map(
                (m) => PerfilPreInversionCofinanciadorRubroModel.fromJson(m)))
            .toList();

    return perfilPreInversionCofinanciadorRubro;
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
  Future<int> savePerfilPreInversionCofinanciadorRubro(
      PerfilPreInversionCofinanciadorRubroEntity
          perfilPreInversionCofinanciadorRubroEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilPreInversionCofinanciadorRubro',
        where:
            'PerfilPreInversionId = ? AND CofinanciadorId = ? AND DesembolsoId = ? AND ActividadFinancieraId = ? AND RubroId = ?',
        whereArgs: [
          perfilPreInversionCofinanciadorRubroEntity.perfilPreInversionId,
          perfilPreInversionCofinanciadorRubroEntity.cofinanciadorId,
          perfilPreInversionCofinanciadorRubroEntity.desembolsoId,
          perfilPreInversionCofinanciadorRubroEntity.actividadFinancieraId,
          perfilPreInversionCofinanciadorRubroEntity.rubroId,
        ]);

    if (resQuery.isEmpty) {
      perfilPreInversionCofinanciadorRubroEntity.recordStatus = 'N';
      batch.insert('PerfilPreInversionCofinanciadorRubro',
          perfilPreInversionCofinanciadorRubroEntity.toJson());
    } else {
      perfilPreInversionCofinanciadorRubroEntity.recordStatus = 'E';
      batch.update('PerfilPreInversionCofinanciadorRubro',
          perfilPreInversionCofinanciadorRubroEntity.toJson(),
          where:
              'PerfilPreInversionId = ? AND CofinanciadorId = ? AND DesembolsoId = ? AND ActividadFinancieraId = ? AND RubroId = ?',
          whereArgs: [
            perfilPreInversionCofinanciadorRubroEntity.perfilPreInversionId,
            perfilPreInversionCofinanciadorRubroEntity.cofinanciadorId,
            perfilPreInversionCofinanciadorRubroEntity.desembolsoId,
            perfilPreInversionCofinanciadorRubroEntity.actividadFinancieraId,
            perfilPreInversionCofinanciadorRubroEntity.rubroId,
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilesPreInversionesCofinanciadoresRubrosProduccion() async {
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
  Future<int> updatePerfilesPreInversionesCofinanciadoresRubrosProduccion(
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

    await batch.commit();
    final query = await db.query('PerfilPreInversionCofinanciadorRubro',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    return query.length;
  }
}
