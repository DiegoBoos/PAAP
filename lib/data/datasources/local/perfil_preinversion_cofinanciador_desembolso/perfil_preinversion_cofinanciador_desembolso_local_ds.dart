import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../../domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../../models/perfil_preinversion_cofinanciador_desembolso_model.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsoLocalDataSource {
  Future<List<PerfilPreInversionCofinanciadorDesembolsoModel>>
      getPerfilPreInversionCofinanciadorDesembolsosDB();
  Future<PerfilPreInversionCofinanciadorDesembolsoModel?>
      getPerfilPreInversionCofinanciadorDesembolsoDB(String id);
  Future<int> savePerfilPreInversionCofinanciadorDesembolsos(
      List<PerfilPreInversionCofinanciadorDesembolsoEntity>
          perfilPreInversionCofinanciadorDesembolsoEntity);
}

class PerfilPreInversionCofinanciadorDesembolsoLocalDataSourceImpl
    implements PerfilPreInversionCofinanciadorDesembolsoLocalDataSource {
  static createPerfilPreInversionCofinanciadorDesembolsoTable(
      Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreInversionCofinanciadorDesembolso (
        PerfilPreInversionId	TEXT NOT NULL,
        CofinanciadorId	TEXT NOT NULL,
        DesembolsoId	TEXT NOT NULL,
        Fecha	TEXT,
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId),
        FOREIGN KEY(CofinanciadorId) REFERENCES Cofinanciador(CofinanciadorId),
        FOREIGN KEY(DesembolsoId) REFERENCES Desembolso(DesembolsoId)
      )
    ''');
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorDesembolsoModel>>
      getPerfilPreInversionCofinanciadorDesembolsosDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciadorDesembolso');

    final perfilPreInversionCofinanciadorDesembolso =
        List<PerfilPreInversionCofinanciadorDesembolsoModel>.from(res.map((m) =>
                PerfilPreInversionCofinanciadorDesembolsoModel.fromJson(m)))
            .toList();

    return perfilPreInversionCofinanciadorDesembolso;
  }

  @override
  Future<PerfilPreInversionCofinanciadorDesembolsoModel?>
      getPerfilPreInversionCofinanciadorDesembolsoDB(String id) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciadorDesembolso',
        where: 'PerfilPreInversionId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final perfilPreInversionCofinanciadorDesembolsoMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilPreInversionCofinanciadorDesembolsoModel =
        PerfilPreInversionCofinanciadorDesembolsoModel.fromJson(
            perfilPreInversionCofinanciadorDesembolsoMap);

    return perfilPreInversionCofinanciadorDesembolsoModel;
  }

  @override
  Future<int> savePerfilPreInversionCofinanciadorDesembolsos(
      List<PerfilPreInversionCofinanciadorDesembolsoEntity>
          perfilPreInversionCofinanciadorDesembolsoEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversionCofinanciadorDesembolso');

    for (var perfilPreInversionCofinanciadorDesembolso
        in perfilPreInversionCofinanciadorDesembolsoEntity) {
      batch.insert('PerfilPreInversionCofinanciadorDesembolso',
          perfilPreInversionCofinanciadorDesembolso.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
