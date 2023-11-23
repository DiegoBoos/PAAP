import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../../domain/entities/perfil_cofinanciador_entity.dart';
import '../../../domain/repositories/perfil_cofinanciador/perfil_cofinanciador_repository_db.dart';
import '../../datasources/local/perfil_cofinanciador_local_ds.dart';

class PerfilCofinanciadorRepositoryDBImpl
    implements PerfilCofinanciadorRepositoryDB {
  final PerfilCofinanciadorLocalDataSource perfilCofinanciadorLocalDataSource;

  PerfilCofinanciadorRepositoryDBImpl(
      {required this.perfilCofinanciadorLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilCofinanciadorEntity>>>
      getPerfilesCofinanciadoresProduccionRepositoryDB() async {
    try {
      final perfilesCofinanciadoresDB = await perfilCofinanciadorLocalDataSource
          .getPerfilesCofinanciadoresProduccionDB();

      return Right(perfilesCofinanciadoresDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilCofinanciadorEntity>>>
      getPerfilCofinanciadoresRepositoryDB(String perfilId) async {
    try {
      final perfilCofinanciadoresDB = await perfilCofinanciadorLocalDataSource
          .getPerfilCofinanciadoresDB(perfilId);

      return Right(perfilCofinanciadoresDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilCofinanciadorEntity?>>
      getPerfilCofinanciadorRepositoryDB(
          String perfilId, String cofinanciadorId) async {
    try {
      final perfilCofinanciadorDB = await perfilCofinanciadorLocalDataSource
          .getPerfilCofinanciadorDB(perfilId, cofinanciadorId);

      return Right(perfilCofinanciadorDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilCofinanciadoresRepositoryDB(
      List<PerfilCofinanciadorEntity> perfilCofinanciadorEntity) async {
    try {
      final perfilCofinanciadorDB = await perfilCofinanciadorLocalDataSource
          .savePerfilCofinanciadores(perfilCofinanciadorEntity);
      return Right(perfilCofinanciadorDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilCofinanciadorRepositoryDB(
      PerfilCofinanciadorEntity perfilCofinanciadorEntity) async {
    try {
      final perfilCofinanciadorDB = await perfilCofinanciadorLocalDataSource
          .savePerfilCofinanciadorDB(perfilCofinanciadorEntity);
      return Right(perfilCofinanciadorDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updatePerfilesCofinanciadoresProduccionDBRepositoryDB(
          List<PerfilCofinanciadorEntity> perfilesCofinanciadoresEntity) async {
    try {
      final result = await perfilCofinanciadorLocalDataSource
          .updatePerfilesCofinanciadoresProduccionDB(
              perfilesCofinanciadoresEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
