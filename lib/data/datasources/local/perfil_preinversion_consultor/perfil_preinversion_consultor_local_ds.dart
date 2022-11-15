import 'package:sqflite/sqflite.dart';

import '../../../../domain/db/db_config.dart';
import '../../../../domain/entities/perfil_preinversion_consultor_entity.dart';
import '../../../models/perfil_preinversion_consultor_model.dart';

abstract class PerfilPreInversionConsultorLocalDataSource {
  Future<List<PerfilPreInversionConsultorModel>>
      getPerfilPreInversionConsultoresDB();
  Future<PerfilPreInversionConsultorModel?> getPerfilPreInversionConsultorDB(
      String id);
  Future<int> savePerfilPreInversionConsultores(
      List<PerfilPreInversionConsultorEntity>
          perfilPreInversionConsultorEntity);
}

class PerfilPreInversionConsultorLocalDataSourceImpl
    implements PerfilPreInversionConsultorLocalDataSource {
  static createPerfilPreInversionConsultorTable(Database db) async {
    await db.execute('''
      CREATE TABLE PerfilPreInversionConsultor (
        PerfilPreInversionId	TEXT NOT NULL,
        ConsultorId	TEXT NOT NULL,
        RevisionId	TEXT,
        FechaRevision	TEXT,
        FOREIGN KEY(PerfilPreInversionId) REFERENCES PerfilPreInversion(PerfilPreInversionId),
        FOREIGN KEY(ConsultorId) REFERENCES Consultor(ConsultorId)
        FOREIGN KEY(RevisionId) REFERENCES Revision(RevisionId)
      )
    ''');
  }

  @override
  Future<List<PerfilPreInversionConsultorModel>>
      getPerfilPreInversionConsultoresDB() async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionConsultor');

    final perfilPreInversionConsultor =
        List<PerfilPreInversionConsultorModel>.from(
                res.map((m) => PerfilPreInversionConsultorModel.fromJson(m)))
            .toList();

    return perfilPreInversionConsultor;
  }

  @override
  Future<PerfilPreInversionConsultorModel?> getPerfilPreInversionConsultorDB(
      String id) async {
    final db = await DBConfig.database;

    final res = await db.query('PerfilPreInversionConsultor',
        where: 'PerfilPreInversionId = ?', whereArgs: [id]);

    if (res.isEmpty) return null;
    final perfilPreInversionConsultorMap = {
      for (var e in res[0].entries) e.key: e.value
    };
    final perfilPreInversionConsultorModel =
        PerfilPreInversionConsultorModel.fromJson(
            perfilPreInversionConsultorMap);

    return perfilPreInversionConsultorModel;
  }

  @override
  Future<int> savePerfilPreInversionConsultores(
      List<PerfilPreInversionConsultorEntity>
          perfilPreInversionConsultorEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();
    batch.delete('PerfilPreInversionConsultor');

    for (var perfilPreInversionConsultor in perfilPreInversionConsultorEntity) {
      batch.insert(
          'PerfilPreInversionConsultor', perfilPreInversionConsultor.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
