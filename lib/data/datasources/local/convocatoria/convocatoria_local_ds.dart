import 'package:paap/domain/entities/convocatoria_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../models/convocatoria.dart';

abstract class ConvocatoriaLocalDataSource {
  Future<List<ConvocatoriaModel>> getConvocatoriasDB();
  Future<int> saveConvocatoria(List<ConvocatoriaEntity> convocatoriaEntity);
}

class ConvocatoriaLocalDataSourceImpl implements ConvocatoriaLocalDataSource {
  static createConvocatoriaTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Convocatoria (
        ConvocatoriaId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        FechaInicial	TEXT,
        FechaFinal	TEXT,
        Recursos	TEXT,
        PRIMARY KEY(ConvocatoriaId)
      )
    ''');
  }

  @override
  Future<List<ConvocatoriaModel>> getConvocatoriasDB() async {
    final db = await DBConfig.database;

    final res = await db.query('Convocatoria');

    final convocatoriasDB = List<ConvocatoriaModel>.from(
        res.map((m) => ConvocatoriaModel.fromJson(m))).toList();

    return convocatoriasDB;
  }

  @override
  Future<int> saveConvocatoria(
      List<ConvocatoriaEntity> convocatoriaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    batch.delete('Convocatoria');

    for (var convocatoria in convocatoriaEntity) {
      batch.insert('Convocatoria', convocatoria.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
