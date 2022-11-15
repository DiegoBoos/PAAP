import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/perfil_preinversion_aliado_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/perfil_preinversion_aliado_model.dart';

abstract class PerfilPreInversionAliadoLocalDataSource {
  Future<List<PerfilPreInversionAliadoModel>> getPerfilPreInversionAliadosDB();
  Future<PerfilPreInversionAliadoModel?> getPerfilPreInversionAliadoDB(
      String id);
  Future<int> savePerfilPreInversionAliados(
      List<PerfilPreInversionAliadoEntity> perfilPreInversionAliadoEntity);
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
        FOREIGN KEY(ProductoId) REFERENCES Producto(ProductoId),
        FOREIGN KEY(UnidadId) REFERENCES Unidad(UnidadId),
        FOREIGN KEY(FrecuenciaId) REFERENCES Frecuencia(FrecuenciaId),
        FOREIGN KEY(AliadoId) REFERENCES Aliado(AliadoId),
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId)
      )
    ''');
  }

  @override
  Future<List<PerfilPreInversionAliadoModel>>
      getPerfilPreInversionAliadosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionAliado');

    final perfilPreInversionAliadosDB =
        List<PerfilPreInversionAliadoModel>.from(
            res.map((m) => PerfilPreInversionAliadoModel.fromJson(m))).toList();

    return perfilPreInversionAliadosDB;
  }

  @override
  Future<PerfilPreInversionAliadoModel?> getPerfilPreInversionAliadoDB(
      String id) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionAliado',
        where: 'PerfilPreInversionId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final perfilPreInversionAliadoMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilPreInversionAliadoModel =
        PerfilPreInversionAliadoModel.fromJson(perfilPreInversionAliadoMap);

    return perfilPreInversionAliadoModel;
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
}
