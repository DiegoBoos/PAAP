import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/criterio_entity.dart';
import '../../../domain/repositories/criterio/criterio_repository_db.dart';
import '../../datasources/local/criterio_local_ds.dart';

class CriterioRepositoryDBImpl implements CriterioRepositoryDB {
  final CriterioLocalDataSource criterioLocalDataSource;

  CriterioRepositoryDBImpl({required this.criterioLocalDataSource});

  @override
  Future<Either<Failure, List<CriterioEntity>>> getCriteriosRepositoryDB(
      String agrupacionId) async {
    try {
      final criteriosDB =
          await criterioLocalDataSource.getCriteriosDB(agrupacionId);

      return Right(criteriosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveCriteriosRepositoryDB(
      List<CriterioEntity> criterioEntity) async {
    try {
      final criterioDB =
          await criterioLocalDataSource.saveCriterios(criterioEntity);
      return Right(criterioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
