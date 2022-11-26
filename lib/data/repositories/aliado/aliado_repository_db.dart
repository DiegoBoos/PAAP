import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/aliado_entity.dart';
import '../../../domain/repositories/aliado/aliado_repository_db.dart';
import '../../datasources/local/aliado_local_ds.dart';

class AliadoRepositoryDBImpl implements AliadoRepositoryDB {
  final AliadosLocalDataSource aliadoLocalDataSource;

  AliadoRepositoryDBImpl({required this.aliadoLocalDataSource});

  @override
  Future<Either<Failure, List<AliadoEntity>>>
      getAliadosProduccionRepositoryDB() async {
    try {
      final aliadosDB = await aliadoLocalDataSource.getAliadosProduccionDB();

      return Right(aliadosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<AliadoEntity>>> getAliadosRepositoryDB() async {
    try {
      final aliadosDB = await aliadoLocalDataSource.getAliadosDB();

      return Right(aliadosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, AliadoEntity?>> getAliadoRepositoryDB(
      String id) async {
    try {
      final aliadoDB = await aliadoLocalDataSource.getAliadoDB(id);

      return Right(aliadoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAliadosRepositoryDB(
      List<AliadoEntity> aliadoEntity) async {
    try {
      final aliadoDB = await aliadoLocalDataSource.saveAliadosDB(aliadoEntity);
      return Right(aliadoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAliadoRepositoryDB(
      AliadoEntity aliadoEntity) async {
    try {
      final aliadoDB = await aliadoLocalDataSource.saveAliadoDB(aliadoEntity);
      return Right(aliadoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> updateAliadosProduccionDBRepositoryDB(
      List<AliadoEntity> aliadosEntity) async {
    try {
      final result =
          await aliadoLocalDataSource.updateAliadosProduccionDB(aliadosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
