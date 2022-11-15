import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../../domain/entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../../models/perfil_preinversion_cofinanciador_actividad_financiera_model.dart';

abstract class PerfilPreInversionCofinanciadorActividadFinancieraLocalDataSource {
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasDB();
  Future<PerfilPreInversionCofinanciadorActividadFinancieraModel?>
      getPerfilPreInversionCofinanciadorActividadFinancieraDB(String id);
  Future<int> savePerfilPreInversionCofinanciadorActividadesFinancieras(
      List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
          perfilPreInversionCofinanciadorActividadFinancieraEntity);
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
      getPerfilPreInversionCofinanciadorActividadFinancieraDB(String id) async {
    final db = await DBConfig.database;

    final res = await db.query(
        'PerfilPreInversionCofinanciadorActividadFinanciera',
        where: 'PerfilPreInversionId = ?',
        whereArgs: [id]);

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
      batch.insert('PerfilPreInversionCofinanciadorActividadFinanciera',
          perfilPreInversionCofinanciadorActividadFinanciera.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
