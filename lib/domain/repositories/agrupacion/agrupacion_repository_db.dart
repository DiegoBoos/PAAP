import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/agrupacion_entity.dart';

abstract class AgrupacionRepositoryDB {
  Future<Either<Failure, List<AgrupacionEntity>>> getAgrupacionesRepositoryDB();

  Future<Either<Failure, int>> saveAgrupacionesRepositoryDB(
      List<AgrupacionEntity> agrupacionEntity);
}
