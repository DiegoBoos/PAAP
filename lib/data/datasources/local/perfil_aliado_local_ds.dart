import 'package:sqflite/sqflite.dart';

import '../../db/db_config.dart';
import '../../../domain/entities/perfil_aliado_entity.dart';
import '../../models/perfil_aliado_model.dart';

abstract class PerfilAliadoLocalDataSource {
  Future<List<PerfilAliadoModel>> getPerfilAliadosDB(String perfilId);
  Future<List<PerfilAliadoModel>> getPerfilesAliadosProduccionDB();
  Future<PerfilAliadoModel?> getPerfilAliadoDB(
      String perfilId, String aliadoId);
  Future<int> savePerfilAliados(List<PerfilAliadoEntity> perfilesAliadosEntity);
  Future<int> savePerfilAliadoDB(PerfilAliadoEntity perfilAliadoEntity);
  Future<int> updatePerfilesAliadosProduccionDB(
      List<PerfilAliadoEntity> perfilesAliadosEntity);
}

class PerfilAliadoLocalDataSourceImpl implements PerfilAliadoLocalDataSource {
  static createPerfilAliadoTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS PerfilAliado (
        PerfilId	TEXT NOT NULL,
        AliadoId	TEXT NOT NULL,
        ProductoId	TEXT NOT NULL,
        VolumenCompra	TEXT,
        UnidadId	TEXT NOT NULL,
        FrecuenciaId	TEXT NOT NULL,
        PorcentajeCompra	TEXT,
        SitioEntregaId	TEXT,
        RecordStatus	TEXT,
        FOREIGN KEY(ProductoId) REFERENCES Producto(ProductoId),
        FOREIGN KEY(UnidadId) REFERENCES Unidad(UnidadId),
        FOREIGN KEY(FrecuenciaId) REFERENCES Frecuencia(FrecuenciaId),
        FOREIGN KEY(AliadoId) REFERENCES Aliado(AliadoId),
        FOREIGN KEY(PerfilId) REFERENCES Perfil(ID)
      )
    ''');
  }

  @override
  Future<List<PerfilAliadoModel>> getPerfilAliadosDB(String perfilId) async {
    final db = await DBConfig.database;

    String sql = '''
      select 
      PerfilAliado.PerfilId,
      PerfilAliado.AliadoId,
      PerfilAliado.ProductoId,
      PerfilAliado.VolumenCompra,
      PerfilAliado.UnidadId,
      PerfilAliado.FrecuenciaId,
      PerfilAliado.PorcentajeCompra,
      PerfilAliado.SitioEntregaId,
      Aliado.Nombre as aliado
      from PerfilAliado
      left join Aliado on (Aliado.AliadoId=PerfilAliado.AliadoId)
      where PerfilId = $perfilId
      ''';

    final res = await db.rawQuery(sql);

    final aliadosDB = List<PerfilAliadoModel>.from(
        res.map((m) => PerfilAliadoModel.fromJson(m))).toList();

    return aliadosDB;
  }

  @override
  Future<PerfilAliadoModel?> getPerfilAliadoDB(
      String perfilId, String aliadoId) async {
    final db = await DBConfig.database;
    final res = await db.query('PerfilAliado',
        where: 'PerfilId = ? AND AliadoId = ?',
        whereArgs: [perfilId, aliadoId]);

    if (res.isEmpty) return null;

    final perfilAliadoMap = {for (var e in res[0].entries) e.key: e.value};
    final perfilAliadoModel = PerfilAliadoModel.fromJson(perfilAliadoMap);

    return perfilAliadoModel;
  }

  @override
  Future<int> savePerfilAliados(
      List<PerfilAliadoEntity> perfilesAliadosEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilAliado');

    for (var perfilAliado in perfilesAliadosEntity) {
      perfilAliado.recordStatus = 'R';
      batch.insert('PerfilAliado', perfilAliado.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> savePerfilAliadoDB(PerfilAliadoEntity perfilAliadoEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilAliado',
        where: 'PerfilId = ? AND AliadoId = ?',
        whereArgs: [perfilAliadoEntity.perfilId, perfilAliadoEntity.aliadoId]);

    if (resQuery.isEmpty) {
      perfilAliadoEntity.recordStatus = 'N';
      batch.insert('PerfilAliado', perfilAliadoEntity.toJson());
    } else {
      perfilAliadoEntity.recordStatus = 'E';
      batch.update('PerfilAliado', perfilAliadoEntity.toJson(),
          where: 'PerfilId = ? AND AliadoId = ?',
          whereArgs: [
            perfilAliadoEntity.perfilId,
            perfilAliadoEntity.aliadoId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilAliadoModel>> getPerfilesAliadosProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db
        .query('PerfilAliado', where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final perfilesAliadosModel = List<PerfilAliadoModel>.from(
        res.map((m) => PerfilAliadoModel.fromJson(m))).toList();

    return perfilesAliadosModel;
  }

  @override
  Future<int> updatePerfilesAliadosProduccionDB(
      List<PerfilAliadoEntity> perfilesAliadosProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var perfilAliadoProduccion in perfilesAliadosProduccionEntity) {
      perfilAliadoProduccion.recordStatus = 'R';
      batch.update('PerfilAliado', perfilAliadoProduccion.toJson(),
          where: 'PerfilId = ? AND AliadoId = ?',
          whereArgs: [
            perfilAliadoProduccion.perfilId,
            perfilAliadoProduccion.aliadoId
          ]);
    }

    await batch.commit();
    final query = await db
        .query('PerfilAliado', where: 'RecordStatus <> ?', whereArgs: ['R']);

    return query.length;
  }
}
