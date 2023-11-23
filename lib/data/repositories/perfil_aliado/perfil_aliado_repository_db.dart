import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../../domain/entities/perfil_aliado_entity.dart';
import '../../../domain/repositories/perfil_aliado/perfil_aliado_repository_db.dart';
import '../../datasources/local/perfil_aliado_local_ds.dart';

class PerfilAliadoRepositoryDBImpl implements PerfilAliadoRepositoryDB {
  final PerfilAliadoLocalDataSource perfilAliadoLocalDataSource;

  PerfilAliadoRepositoryDBImpl({required this.perfilAliadoLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilAliadoEntity>>>
      getPerfilesAliadosProduccionRepositoryDB() async {
    try {
      final perfilesAliadosDB =
          await perfilAliadoLocalDataSource.getPerfilesAliadosProduccionDB();

      return Right(perfilesAliadosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilAliadoEntity>>>
      getPerfilAliadosRepositoryDB(String perfilId) async {
    try {
      final perfilAliadosDB =
          await perfilAliadoLocalDataSource.getPerfilAliadosDB(perfilId);

      return Right(perfilAliadosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilAliadoEntity?>> getPerfilAliadoRepositoryDB(
      String perfilId, String aliadoId) async {
    try {
      final perfilAliadoDB = await perfilAliadoLocalDataSource
          .getPerfilAliadoDB(perfilId, aliadoId);

      return Right(perfilAliadoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilAliadosRepositoryDB(
      List<PerfilAliadoEntity> perfilAliadoEntity) async {
    try {
      final perfilAliadoDB = await perfilAliadoLocalDataSource
          .savePerfilAliados(perfilAliadoEntity);
      return Right(perfilAliadoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilAliadoRepositoryDB(
      PerfilAliadoEntity perfilAliadoEntity) async {
    try {
      final perfilAliadoDB = await perfilAliadoLocalDataSource
          .savePerfilAliadoDB(perfilAliadoEntity);
      return Right(perfilAliadoDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> updatePerfilesAliadosProduccionDBRepositoryDB(
      List<PerfilAliadoEntity> perfilesAliadosEntity) async {
    try {
      final result = await perfilAliadoLocalDataSource
          .updatePerfilesAliadosProduccionDB(perfilesAliadosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
