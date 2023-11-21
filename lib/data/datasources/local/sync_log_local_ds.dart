import 'package:paap/domain/entities/sync_log_entity.dart';

import '../../db/db_config.dart';
import '../../models/sync_log_model.dart';

abstract class SyncLogLocalDataSource {
  Future<List<SyncLogModel>> getSyncLogsDB();
  Future<int> forceSyncDB(List<SyncLogEntity> syncLogsEntity);
}

class SyncLogLocalDataSourceImpl implements SyncLogLocalDataSource {
  @override
  Future<List<SyncLogModel>> getSyncLogsDB() async {
    final db = await DBConfig.database;

    String sql = '''
      SELECT 'Aliado' as Tabla, Count(*) as CantidadRegistros from Aliado WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'AlianzaBeneficiario' as Tabla, Count(*) as CantidadRegistros from AlianzaBeneficiario WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'AlianzaExperienciaAgricola' as Tabla, Count(*) as CantidadRegistros from AlianzaExperienciaAgricola WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'AlianzaExperienciaPecuaria' as Tabla, Count(*) as CantidadRegistros from AlianzaExperienciaPecuaria WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'Beneficiario' as Tabla, Count(*) as CantidadRegistros from Beneficiario WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'Evaluacion' as Tabla, Count(*) as CantidadRegistros from Evaluacion WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'EvaluacionRespuesta' as Tabla, Count(*) as CantidadRegistros from EvaluacionRespuesta WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'ExperienciaAgricola' as Tabla, Count(*) as CantidadRegistros from ExperienciaAgricola WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'ExperienciaPecuaria' as Tabla, Count(*) as CantidadRegistros from ExperienciaPecuaria WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'PerfilBeneficiario' as Tabla, Count(*) as CantidadRegistros from PerfilBeneficiario WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'PerfilPreInversionAliado' as Tabla, Count(*) as CantidadRegistros from PerfilPreInversionAliado WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'PerfilPreInversionBeneficiario' as Tabla, Count(*) as CantidadRegistros from PerfilPreInversionBeneficiario WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'PerfilPreInversionCofinanciador' as Tabla, Count(*) as CantidadRegistros from PerfilPreInversionCofinanciador WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'PerfilPreInversionCofinanciadorActividadFinanciera' as Tabla, Count(*) as CantidadRegistros from PerfilPreInversionCofinanciadorActividadFinanciera WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'PerfilPreInversionCofinanciadorDesembolso' as Tabla, Count(*) as CantidadRegistros from PerfilPreInversionCofinanciadorDesembolso WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'PerfilPreInversionCofinanciadorRubro' as Tabla, Count(*) as CantidadRegistros from PerfilPreInversionCofinanciadorRubro WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'PerfilPreInversionConsultor' as Tabla, Count(*) as CantidadRegistros from PerfilPreInversionConsultor WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'PerfilPreInversionPlanNegocio' as Tabla, Count(*) as CantidadRegistros from PerfilPreInversionPlanNegocio WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'PerfilPreInversionPrecio' as Tabla, Count(*) as CantidadRegistros from PerfilPreInversionPrecio WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      UNION ALL
      SELECT 'Visita' as Tabla, Count(*) as CantidadRegistros from Visita WHERE RecordStatus<>'R' group by Tabla having Count(*)>0
      ''';
    final res = await db.rawQuery(sql);

    final syncLogsDB =
        List<SyncLogModel>.from(res.map((m) => SyncLogModel.fromJson(m)))
            .toList();

    return syncLogsDB;
  }

  @override
  Future<int> forceSyncDB(List<SyncLogEntity> syncLogsEntity) async {
    final db = await DBConfig.database;

    var batch = db.batch();

    for (var syncLog in syncLogsEntity) {
      batch.update(syncLog.tabla, {'recordStatus': 'R'});
    }

    final res = await batch.commit();

    return res.length;
  }
}
