import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/evaluacion_entity.dart';

abstract class EvaluacionRepositoryDB {
  Future<Either<Failure, EvaluacionEntity?>> getEvaluacionRepositoryDB(
      String id);

  Future<Either<Failure, int>> saveEvaluacionRepositoryDB(
      EvaluacionEntity evaluacionEntity);

  Future<Either<Failure, int>> saveEvaluacionesRepositoryDB(
      List<EvaluacionEntity> evaluacionEntity);

  Future<Either<Failure, int>> clearEvaluacionesRepositoryDB();
}
