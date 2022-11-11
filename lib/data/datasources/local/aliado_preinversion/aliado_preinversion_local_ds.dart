import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/aliado_preinversion_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/aliado_preinversion_model.dart';

abstract class AliadoPreinversionLocalDataSource {
  Future<List<AliadoPreinversionModel>> getAliadosPreinversionDB();
  Future<AliadoPreinversionModel?> getAliadoPreinversionDB(String id);
  Future<int> saveAliadosPreinversion(
      List<AliadoPreinversionEntity> aliadoPreinversionEntity);
}

class AliadoPreinversionLocalDataSourceImpl
    implements AliadoPreinversionLocalDataSource {
  static createAliadoPreinversionTable(Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreinversionAliado (
        PerfilPreInversionId	INTEGER NOT NULL,
        AliadoId	INTEGER NOT NULL,
        ProductoId	INTEGER NOT NULL,
        VolumenCompra	INTEGER,
        UnidadId	INTEGER NOT NULL,
        FrecuenciaId	INTEGER NOT NULL,
        PorcentajeCompra	INTEGER,
        SitioEntregaId	INTEGER,
        FOREIGN KEY(ProductoId) REFERENCES Producto(ProductoId),
        FOREIGN KEY(UnidadId) REFERENCES Unidad(UnidadId),
        FOREIGN KEY(FrecuenciaId) REFERENCES Frecuencia(FrecuenciaId),
        FOREIGN KEY(AliadoId) REFERENCES Aliado(AliadoId),
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreinversion(PerfilPreInversionId)
      )
    ''');
  }

  @override
  Future<List<AliadoPreinversionModel>> getAliadosPreinversionDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreinversionAliado');

    final aliadospreinversionDB = List<AliadoPreinversionModel>.from(
        res.map((m) => AliadoPreinversionModel.fromJson(m))).toList();

    return aliadospreinversionDB;
  }

  @override
  Future<AliadoPreinversionModel?> getAliadoPreinversionDB(String id) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreinversionAliado',
        where: 'PerfilPreInversionId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final aliadoPreinversionMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final aliadoPreinversionModel =
        AliadoPreinversionModel.fromJson(aliadoPreinversionMap);

    return aliadoPreinversionModel;
  }

  @override
  Future<int> saveAliadosPreinversion(
      List<AliadoPreinversionEntity> aliadoPreinversionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreinversionAliado');

    for (var aliadoPreinversion in aliadoPreinversionEntity) {
      batch.insert('PerfilPreinversionAliado', aliadoPreinversion.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
