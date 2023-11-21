import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/agrupacion_entity.dart';

abstract class AgrupacionRepositoryDB {
  Future<Either<Failure, List<AgrupacionEntity>>> getAgrupacionesRepositoryDB(
      String convocatoriaId);

  Future<Either<Failure, int>> saveAgrupacionesRepositoryDB(
      List<AgrupacionEntity> agrupacionEntity);
}
