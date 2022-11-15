import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../../domain/entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../../models/perfil_preinversion_cofinanciador_rubro_model.dart';

abstract class PerfilPreInversionCofinanciadorRubroLocalDataSource {
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilPreInversionCofinanciadorRubrosDB();
  Future<PerfilPreInversionCofinanciadorRubroModel?>
      getPerfilPreInversionCofinanciadorRubroDB(String id);
  Future<int> savePerfilPreInversionCofinanciadorRubros(
      List<PerfilPreInversionCofinanciadorRubroEntity>
          perfilPreInversionCofinanciadorRubroEntity);
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
        FOREIGN KEY(CofinanciadorId) REFERENCES Cofinanciador(CofinanciadorId),
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId),
        FOREIGN KEY(ActividadFinancieraId) REFERENCES ActividadFinanciera(ActividadFinancieraId),
        FOREIGN KEY(DesembolsoId) REFERENCES Desembolso(DesembolsoId),
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
      getPerfilPreInversionCofinanciadorRubroDB(String id) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciadorRubro',
        where: 'PerfilPreInversionId = ?', whereArgs: [id]);

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
      batch.insert('PerfilPreInversionCofinanciadorRubro',
          perfilPreInversionCofinanciadorRubro.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
