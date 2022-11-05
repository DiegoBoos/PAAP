import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/alianza_entity.dart';

import '../../../../domain/db/db_config.dart';
import '../../../models/alianza_model.dart';

abstract class AlianzasLocalDataSource {
  Future<List<AlianzaModel>> getAlianzasDB();
  Future<int> saveAlianzasDB(List<AlianzaEntity> alianzas);
}

class AlianzasLocalDataSourceImpl implements AlianzasLocalDataSource {
  static createAlianzaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Alianza (
	      ID	TEXT NOT NULL,
	      Nombre	TEXT,
	      Abreviatura	TEXT,
	      Valor_x0020_Proyécto	TEXT,
	      Incentivo_x0020_Módular	TEXT,
	      Ubicación	TEXT,
	      Categorización	TEXT,
	      PRIMARY KEY(AlianzaId),

      )
    ''');
  }

  @override
  Future<List<AlianzaModel>> getAlianzasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Alianza');

    final alianzasDB =
        List<AlianzaModel>.from(res.map((m) => AlianzaModel.fromJson(m)))
            .toList();

    return alianzasDB;
  }

  @override
  Future<int> saveAlianzasDB(List<AlianzaEntity> alianzaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Alianza');

    for (var alianza in alianzaEntity) {
      batch.insert('Alianza', alianza.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
