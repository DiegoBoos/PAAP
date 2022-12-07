import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/visita_entity.dart';

abstract class VisitaRepositoryDB {
  Future<Either<Failure, VisitaEntity?>> getVisitaRepositoryDB(
      String perfilId, String tipoVisitaId);
  Future<Either<Failure, VisitaEntity>> saveVisitaEvaluacionRepositoryDB(
      VisitaEntity visitaEntity);
  Future<Either<Failure, int>> saveVisitasRepositoryDB(
      List<VisitaEntity> visitasEntity);
  Future<Either<Failure, int>> clearVisitasRepositoryDB();
  Future<Either<Failure, List<VisitaEntity>>>
      getVisitasProduccionRepositoryDB();
  Future<Either<Failure, int>> updateVisitasProduccionDBRepositoryDB(
      List<VisitaEntity> visitasEntity);
}
