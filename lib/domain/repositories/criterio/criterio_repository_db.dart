import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/criterio_entity.dart';

abstract class CriterioRepositoryDB {
  Future<Either<Failure, List<CriterioEntity>>> getCriteriosRepositoryDB(
      String agrupacionId);

  Future<Either<Failure, int>> saveCriteriosRepositoryDB(
      List<CriterioEntity> criterioEntity);
}
