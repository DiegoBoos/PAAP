import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/evaluacion_entity.dart';
import '../../../domain/entities/visita_entity.dart';
import '../../../domain/db/db_config.dart';
import '../../models/visita_model.dart';

abstract class VisitaLocalDataSource {
  Future<VisitaModel> getVisitaDB(VisitaEntity visitaEntity);
  Future<List<VisitaModel>> getVisitasProduccionDB();
  Future<int> saveVisitasDB(List<VisitaEntity> visitasEntity);
  Future<int> updateVisitasProduccionDB(List<VisitaEntity> visitasEntity);
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
        RecordStatus	TEXT,
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

    if (res.isEmpty) {
      visitaEntity.recordStatus = 'N';
      await saveVisitaDB(visitaEntity);
      EvaluacionEntity newEvaluacion = EvaluacionEntity(
          evaluacionId: '0',
          perfilId: visitaEntity.perfilId,
          resumen: '',
          fortalezas: '',
          debilidades: '',
          riesgos: '',
          finalizado: 'false',
          usuarioIdCoordinador: '',
          fechaEvaluacion: '',
          preAprobado: 'false',
          recordStatus: 'N');
      await saveEvaluacionDB(newEvaluacion);
      return VisitaModel.fromJson(visitaEntity.toJson());
    }

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
      visita.recordStatus = 'R';
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
    //TODO: Estado visita por defecto 1 = Borrador
    visitaEntity.estadoVisitaId = '1';
    final res = await db.insert('Visita', visitaEntity.toJson());

    return res;
  }

  Future<int> saveEvaluacionDB(EvaluacionEntity evaluacionEntity) async {
    final db = await DBConfig.database;

    final res = await db.insert('Evaluacion', evaluacionEntity.toJson());

    return res;
  }

  @override
  Future<List<VisitaModel>> getVisitasProduccionDB() async {
    final db = await DBConfig.database;

    final res =
        await db.query('Visita', where: 'RecordStatus <> ?', whereArgs: ['R']);

    if (res.isEmpty) return [];

    final visitasModel =
        List<VisitaModel>.from(res.map((m) => VisitaModel.fromJson(m)))
            .toList();

    return visitasModel;
  }

  @override
  Future<int> updateVisitasProduccionDB(
      List<VisitaEntity> visitasProduccionEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var visitaProduccion in visitasProduccionEntity) {
      visitaProduccion.recordStatus = 'R';
      batch.update('Visita', visitaProduccion.toJson(),
          where: 'PerfilId = ? AND TipoVisitaId= ?',
          whereArgs: [
            visitaProduccion.perfilId,
            visitaProduccion.tipoVisitaId
          ]);
    }

    final res = await batch.commit();

    return res.length;
  }
}
