import 'package:paap/domain/entities/convocatoria_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../models/convocatoria.dart';

abstract class ConvocatoriaLocalDataSource {
  Future<List<ConvocatoriaModel>> getConvocatoriasDB();
  Future<ConvocatoriaModel> saveConvocatoria(
      ConvocatoriaEntity convocatoriaEntity);
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
  Future<ConvocatoriaModel> saveConvocatoria(
      ConvocatoriaEntity convocatoriaEntity) async {
    final db = await DBConfig.database;

    final menuJson = convocatoriaEntity.toJson();
    await db.insert('Convocatoria', menuJson);

    return ConvocatoriaModel.fromJson(menuJson);
  }
}
