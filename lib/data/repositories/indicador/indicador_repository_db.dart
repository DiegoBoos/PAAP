import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/indicador_entity.dart';
import '../../../domain/repositories/indicador/indicador_repository_db.dart';
import '../../datasources/local/indicador_local_ds.dart';

class IndicadorRepositoryDBImpl implements IndicadorRepositoryDB {
  final IndicadorLocalDataSource indicadorLocalDataSource;

  IndicadorRepositoryDBImpl({required this.indicadorLocalDataSource});

  @override
  Future<Either<Failure, List<IndicadorEntity>>>
      getIndicadoresRepositoryDB() async {
    try {
      final indicadoresDB = await indicadorLocalDataSource.getIndicadoresDB();

      return Right(indicadoresDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, IndicadorEntity?>> getIndicadorRepositoryDB(
      String id) async {
    try {
      final indicadorDB = await indicadorLocalDataSource.getIndicadorDB(id);

      return Right(indicadorDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveIndicadoresRepositoryDB(
      List<IndicadorEntity> indicadorEntity) async {
    try {
      final indicadorDB =
          await indicadorLocalDataSource.saveIndicadores(indicadorEntity);
      return Right(indicadorDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
