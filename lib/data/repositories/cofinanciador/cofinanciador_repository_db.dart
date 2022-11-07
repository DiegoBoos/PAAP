import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/cofinanciador_entity.dart';
import '../../../domain/repositories/cofinanciador/cofinanciador_repository_db.dart';
import '../../datasources/local/cofinanciador/cofinanciador_local_ds.dart';

class CofinanciadorRepositoryDBImpl implements CofinanciadorRepositoryDB {
  final CofinanciadorLocalDataSource cofinanciadorLocalDataSource;

  CofinanciadorRepositoryDBImpl({required this.cofinanciadorLocalDataSource});

  @override
  Future<Either<Failure, List<CofinanciadorEntity>>>
      getCofinanciadoresRepositoryDB() async {
    try {
      final cofinanciadoresDB =
          await cofinanciadorLocalDataSource.getCofinanciadoresDB();

      return Right(cofinanciadoresDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveCofinanciadoresRepositoryDB(
      List<CofinanciadorEntity> cofinanciadorEntity) async {
    try {
      final cofinanciadorDB = await cofinanciadorLocalDataSource
          .saveCofinanciadores(cofinanciadorEntity);
      return Right(cofinanciadorDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
