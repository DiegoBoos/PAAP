import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../../models/perfil_preinversion_cofinanciador_model.dart';

abstract class PerfilPreInversionCofinanciadorLocalDataSource {
  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilPreInversionCofinanciadoresDB();
  Future<PerfilPreInversionCofinanciadorModel?>
      getPerfilPreInversionCofinanciadorDB(String id);
  Future<int> savePerfilPreInversionCofinanciadores(
      List<PerfilPreInversionCofinanciadorEntity>
          perfilPreInversionCofinanciadorEntity);
}

class PerfilPreInversionCofinanciadorLocalDataSourceImpl
    implements PerfilPreInversionCofinanciadorLocalDataSource {
  static createPerfilPreInversionCofinanciadorTable(Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreInversionCofinanciador (
        PerfilPreInversionId	TEXT NOT NULL,
        CofinanciadorId	TEXT NOT NULL,
        monto	TEXT,
        participacion	TEXT,
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId),
        FOREIGN KEY(CofinanciadorId) REFERENCES Cofinanciador(CofinanciadorId)
      )
    ''');
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilPreInversionCofinanciadoresDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciador');

    final perfilPreInversionCofinanciador =
        List<PerfilPreInversionCofinanciadorModel>.from(res.map(
            (m) => PerfilPreInversionCofinanciadorModel.fromJson(m))).toList();

    return perfilPreInversionCofinanciador;
  }

  @override
  Future<PerfilPreInversionCofinanciadorModel?>
      getPerfilPreInversionCofinanciadorDB(String id) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionCofinanciador',
        where: 'PerfilPreInversionId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final perfilPreInversionCofinanciadorMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilPreInversionCofinanciadorModel =
        PerfilPreInversionCofinanciadorModel.fromJson(
            perfilPreInversionCofinanciadorMap);

    return perfilPreInversionCofinanciadorModel;
  }

  @override
  Future<int> savePerfilPreInversionCofinanciadores(
      List<PerfilPreInversionCofinanciadorEntity>
          perfilPreInversionCofinanciadorEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversionCofinanciador');

    for (var perfilPreInversionCofinanciador
        in perfilPreInversionCofinanciadorEntity) {
      batch.insert('PerfilPreInversionCofinanciador',
          perfilPreInversionCofinanciador.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
