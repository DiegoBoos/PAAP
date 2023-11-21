import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/aliado_entity.dart';

abstract class AliadoRepositoryDB {
  Future<Either<Failure, List<AliadoEntity>>> getAliadosRepositoryDB();

  Future<Either<Failure, List<AliadoEntity>>>
      getAliadosProduccionRepositoryDB();

  Future<Either<Failure, AliadoEntity?>> getAliadoRepositoryDB(String id);

  Future<Either<Failure, int>> saveAliadosRepositoryDB(
      List<AliadoEntity> aliadoEntity);

  Future<Either<Failure, int>> saveAliadoRepositoryDB(
      AliadoEntity aliadoEntity);

  Future<Either<Failure, int>> updateAliadosProduccionDBRepositoryDB(
      List<AliadoEntity> aliadosEntity);
}
