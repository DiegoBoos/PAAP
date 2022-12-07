import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/perfil_preinversion_aliado_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/perfil_preinversion_aliado_model.dart';

abstract class PerfilPreInversionAliadoLocalDataSource {
  Future<List<PerfilPreInversionAliadoModel>> getPerfilPreInversionAliadosDB(
      String perfilPreInversionId);

  Future<int> savePerfilPreInversionAliados(
      List<PerfilPreInversionAliadoEntity> perfilPreInversionAliadoEntity);
  Future<int> savePerfilPreInversionAliadoDB(
      PerfilPreInversionAliadoEntity perfilPreInversionAliadoEntity);
  Future<List<PerfilPreInversionAliadoModel>>
      getPerfilesPreInversionesAliadosProduccionDB();
  Future<int> updatePerfilesPreInversionesAliadosProduccionDB(
      List<PerfilPreInversionAliadoEntity>
          perfilesPreInversionesAliadosProduccionEntity);
}

class PerfilPreInversionAliadoLocalDataSourceImpl
    implements PerfilPreInversionAliadoLocalDataSource {
  static createPerfilPreInversionAliadoTable(Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreInversionAliado (
        PerfilPreInversionId	TEXT NOT NULL,
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
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId)
      )
    ''');
  }

  @override
  Future<List<PerfilPreInversionAliadoModel>> getPerfilPreInversionAliadosDB(
      String perfilPreInversionId) async {
    final db = await DBConfig.database;

    String sql = '''
      select 
      PerfilPreInversionAliado.PerfilPreInversionId,
      PerfilPreInversionAliado.AliadoId,
      PerfilPreInversionAliado.ProductoId,
      PerfilPreInversionAliado.VolumenCompra,
      PerfilPreInversionAliado.UnidadId,
      PerfilPreInversionAliado.FrecuenciaId,
      PerfilPreInversionAliado.PorcentajeCompra,
      PerfilPreInversionAliado.SitioEntregaId,
      Aliado.Nombre as aliado
      from PerfilPreInversionAliado
      left join Aliado on (Aliado.AliadoId=PerfilPreInversionAliado.AliadoId)
      where PerfilPreInversionId = $perfilPreInversionId
      ''';

    final res = await db.rawQuery(sql);

    final perfilPreInversionAliadosDB =
        List<PerfilPreInversionAliadoModel>.from(
            res.map((m) => PerfilPreInversionAliadoModel.fromJson(m))).toList();

    return perfilPreInversionAliadosDB;
  }

  @override
  Future<int> savePerfilPreInversionAliados(
      List<PerfilPreInversionAliadoEntity>
          perfilPreInversionAliadoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversionAliado');

    for (var perfilPreInversionAliado in perfilPreInversionAliadoEntity) {
      batch.insert(
          'PerfilPreInversionAliado', perfilPreInversionAliado.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> savePerfilPreInversionAliadoDB(
      PerfilPreInversionAliadoEntity perfilPreInversionAliadoEntity) async {
    final db = await DBConfig.database;
    var batch = db.batch();

    final resQuery = await db.query('PerfilPreInversionAliado',
        where: 'AliadoId = ?',
        whereArgs: [perfilPreInversionAliadoEntity.aliadoId]);

    if (resQuery.isEmpty) {
      perfilPreInversionAliadoEntity.recordStatus = 'N';
      batch.insert(
          'PerfilPreInversionAliado', perfilPreInversionAliadoEntity.toJson());
    } else {
      perfilPreInversionAliadoEntity.recordStatus = 'E';
      batch.update(
          'PerfilPreInversionAliado', perfilPreInversionAliadoEntity.toJson(),
          where: 'AliadoId = ?',
          whereArgs: [perfilPreInversionAliadoEntity.aliadoId]);
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<PerfilPreInversionAliadoModel>>
      getPerfilesPreInversionesAliadosProduccionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionAliado',
        where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final perfilesPreInversionesAliadosModel =
        List<PerfilPreInversionAliadoModel>.from(
            res.map((m) => PerfilPreInversionAliadoModel.fromJson(m))).toList();

    return perfilesPreInversionesAliadosModel;
  }

  @override
  Future<int> updatePerfilesPreInversionesAliadosProduccionDB(
      List<PerfilPreInversionAliadoEntity>
          perfilesPreInversionesAliadosProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var perfilPreInversionAliadoProduccion
        in perfilesPreInversionesAliadosProduccionEntity) {
      perfilPreInversionAliadoProduccion.recordStatus = 'R';
      batch.update('PerfilPreInversionAliado',
          perfilPreInversionAliadoProduccion.toJson(),
          where: 'PerfilPreInversionId = ?',
          whereArgs: [perfilPreInversionAliadoProduccion.perfilPreInversionId]);
    }

    final res = await batch.commit();

    return res.length;
  }
}
