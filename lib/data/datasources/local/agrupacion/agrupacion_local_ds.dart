import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/agrupacion_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/agrupacion_model.dart';

abstract class AgrupacionLocalDataSource {
  Future<List<AgrupacionModel>> getAgrupacionesDB(String convocatoriaId);
  Future<int> saveAgrupaciones(List<AgrupacionEntity> agrupacionEntity);
}

class AgrupacionLocalDataSourceImpl implements AgrupacionLocalDataSource {
  static createAgrupacionTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Agrupacion (
        AgrupacionId	TEXT NOT NULL,
        Nombre	TEXT,
        Descripcion	TEXT,
        ConvocatoriaId	TEXT,
        PRIMARY KEY(AgrupacionId),
        FOREIGN KEY(ConvocatoriaId) REFERENCES Convocatoria(ConvocatoriaId)
      )
    ''');
  }

  @override
  Future<List<AgrupacionModel>> getAgrupacionesDB(String convocatoriaId) async {
    final db = await DBConfig.database;

    final res = await db.query('Agrupacion',
        where: 'ConvocatoriaId = ?', whereArgs: [convocatoriaId]);

    final agrupacionsDB =
        List<AgrupacionModel>.from(res.map((m) => AgrupacionModel.fromJson(m)))
            .toList();

    return agrupacionsDB;
  }

  @override
  Future<int> saveAgrupaciones(List<AgrupacionEntity> agrupacionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Agrupacion');

    for (var agrupacion in agrupacionEntity) {
      batch.insert('Agrupacion', agrupacion.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
