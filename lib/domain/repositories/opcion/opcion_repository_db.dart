import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/opcion_entity.dart';

abstract class OpcionRepositoryDB {
  Future<Either<Failure, List<OpcionEntity>>> getOpcionesRepositoryDB(
      String criterioId);

  Future<Either<Failure, int>> saveOpcionesRepositoryDB(
      List<OpcionEntity> opcionEntity);
}
