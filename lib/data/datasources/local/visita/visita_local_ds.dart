import 'package:paap/data/models/visita_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/visita_entity.dart';
import '../../../../domain/db/db_config.dart';

abstract class VisitaLocalDataSource {
  Future<VisitaModel?> getVisitaDB(String perfilId, String tipoVisitaId);
  Future<int> saveVisitaDB(VisitaEntity visitaEntity);
  Future<int> saveVisitasDB(List<VisitaEntity> visitasEntity);
  Future<int> clearVisitasDB();
}

class VisitaLocalDataSourceImpl implements VisitaLocalDataSource {
  static createVisitaTable(Database db) async {
    await db.execute('''
      CREATE TABLE Visita (
        PerfilId	TEXT NOT NULL,
        TipoVisitaId	TEXT NOT NULL,
        FechaInicial	TEXT,
        FechaFinal	TEXT,
        EstadoVisitaId	TEXT NOT NULL,
        Observacion	TEXT,
        UsuarioId	TEXT NOT NULL,
        FechaRegistro	TEXT,
        FOREIGN KEY(EstadoVisitaId) REFERENCES EstadoVisita(EstadoVisitaId),
        FOREIGN KEY(TipoVisitaId) REFERENCES TipoVisita(TipoVisitaId),
        FOREIGN KEY(UsuarioId) REFERENCES Usuario(UsuarioId),
        FOREIGN KEY(PerfilId) REFERENCES Perfil(PerfilId)
      )
    ''');
  }

  @override
  Future<VisitaModel?> getVisitaDB(String perfilId, String tipoVisitaId) async {
    final db = await DBConfig.database;
    final res = await db.query('Visita',
        where: 'PerfilId = ? AND TipoVisitaId = ?',
        whereArgs: [perfilId, tipoVisitaId]);

    if (res.isEmpty) return null;
    final visitaMap = {for (var e in res[0].entries) e.key: e.value};
    final visitaModel = VisitaModel.fromJson(visitaMap);

    return visitaModel;
  }

  @override
  Future<int> saveVisitasDB(List<VisitaEntity> visitasEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Visita');

    for (var visita in visitasEntity) {
      batch.insert('Visita', visita.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveVisitaDB(VisitaEntity visitaEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Visita');

    batch.insert('Visita', visitaEntity.toJson());

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> clearVisitasDB() async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Visita');

    final res = await batch.commit();

    return res.length;
  }
}
