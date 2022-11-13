import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/visita_entity.dart';

abstract class VisitaRepositoryDB {
  Future<Either<Failure, VisitaEntity>> getVisitaRepositoryDB(
      VisitaEntity visitaEntity);
  Future<Either<Failure, int>> saveVisitasRepositoryDB(
      List<VisitaEntity> visitasEntity);
  Future<Either<Failure, int>> clearVisitasRepositoryDB();
}
