import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/frecuencia_entity.dart';

abstract class FrecuenciaRepositoryDB {
  Future<Either<Failure, List<FrecuenciaEntity>>> getFrecuenciasRepositoryDB();

  Future<Either<Failure, int>> saveFrecuenciasRepositoryDB(
      List<FrecuenciaEntity> frecuenciaEntity);
}
