import 'package:sqflite/sqflite.dart';

import '../../../../domain/entities/evaluacion_entity.dart';
import '../../../../domain/entities/visita_entity.dart';
import '../../../../domain/db/db_config.dart';
import '../../../models/visita_model.dart';

abstract class VisitaLocalDataSource {
  Future<VisitaModel> getVisitaDB(VisitaEntity visitaEntity);
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
    await db.execute('''
      CREATE TABLE VisitaProduccion (
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
  Future<VisitaModel> getVisitaDB(VisitaEntity visitaEntity) async {
    final db = await DBConfig.database;
    final res = await db.query('Visita',
        where: 'PerfilId = ? AND TipoVisitaId = ?',
        whereArgs: [visitaEntity.perfilId, visitaEntity.tipoVisitaId]);

    final resProduccion = await db.query('VisitaProduccion',
        where: 'PerfilId = ? AND TipoVisitaId = ?',
        whereArgs: [visitaEntity.perfilId, visitaEntity.tipoVisitaId]);

    if (res.isEmpty && resProduccion.isEmpty) {
      await saveVisitaDB(visitaEntity);
      EvaluacionEntity newEvaluacion = EvaluacionEntity(
          evaluacionId: '',
          perfilId: visitaEntity.perfilId,
          resumen: '',
          fortalezas: '',
          debilidades: '',
          riesgos: '',
          finalizado: 'false',
          usuarioIdCoordinador: '',
          fechaEvaluacion: '',
          preAprobado: 'false');
      await saveEvaluacionDB(newEvaluacion);
      return VisitaModel.fromJson(visitaEntity.toJson());
    }

    final visitaMap = {
      for (var e in res.isNotEmpty ? res[0].entries : resProduccion[0].entries)
        e.key: e.value
    };
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
  Future<int> clearVisitasDB() async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('Visita');

    final res = await batch.commit();

    return res.length;
  }

  Future<int> saveVisitaDB(VisitaEntity visitaEntity) async {
    final db = await DBConfig.database;

    final res = await db.insert('VisitaProduccion', visitaEntity.toJson());

    return res;
  }

  Future<int> saveEvaluacionDB(EvaluacionEntity evaluacionEntity) async {
    final db = await DBConfig.database;

    final res =
        await db.insert('EvaluacionProduccion', evaluacionEntity.toJson());

    return res;
  }
}
