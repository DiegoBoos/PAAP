import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/opcion_entity.dart';

abstract class OpcionRepositoryDB {
  Future<Either<Failure, List<OpcionEntity>>> getOpcionesRepositoryDB();

  Future<Either<Failure, int>> saveOpcionesRepositoryDB(
      List<OpcionEntity> opcionEntity);
}
