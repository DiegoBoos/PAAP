import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../../domain/repositories/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_repository_db.dart';
import '../../datasources/local/perfil_preinversion_cofinanciador_local_ds.dart';

class PerfilPreInversionCofinanciadorRepositoryDBImpl
    implements PerfilPreInversionCofinanciadorRepositoryDB {
  final PerfilPreInversionCofinanciadorLocalDataSource
      perfilPreInversionCofinanciadorLocalDataSource;

  PerfilPreInversionCofinanciadorRepositoryDBImpl(
      {required this.perfilPreInversionCofinanciadorLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      getPerfilesPreInversionesCofinanciadoresRepositoryDB(
          String perfilPreInversionId) async {
    try {
      final perfilesPreInversionesCofinanciadores =
          await perfilPreInversionCofinanciadorLocalDataSource
              .getPerfilesPreInversionesCofinanciadores(perfilPreInversionId);

      return Right(perfilesPreInversionesCofinanciadores);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilPreInversionCofinanciadorEntity?>>
      getPerfilPreInversionCofinanciadorRepositoryDB(
          String perfilPreInversionId) async {
    try {
      final perfilPreInversionCofinanciador =
          await perfilPreInversionCofinanciadorLocalDataSource
              .getPerfilPreInversionCofinanciador(perfilPreInversionId);

      return Right(perfilPreInversionCofinanciador);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      getPerfilesPreInversionesCofinanciadoresProduccionRepositoryDB() async {
    try {
      final perfilesPreInversionesCofinanciadores =
          await perfilPreInversionCofinanciadorLocalDataSource
              .getPerfilesPreInversionesCofinanciadoresProduccion();

      return Right(perfilesPreInversionesCofinanciadores);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilPreInversionCofinanciadorRepositoryDB(
      PerfilPreInversionCofinanciadorEntity
          perfilPreInversionCofinanciadorEntity) async {
    try {
      final perfilPreInversionCofinanciadorDB =
          await perfilPreInversionCofinanciadorLocalDataSource
              .savePerfilPreInversionCofinanciador(
                  perfilPreInversionCofinanciadorEntity);
      return Right(perfilPreInversionCofinanciadorDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      savePerfilesPreInversionesCofinanciadoresRepositoryDB(
          List<PerfilPreInversionCofinanciadorEntity>
              perfilPreInversionCofinanciadorEntity) async {
    try {
      final result = await perfilPreInversionCofinanciadorLocalDataSource
          .savePerfilesPreInversionesCofinanciadores(
              perfilPreInversionCofinanciadorEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updatePerfilesPreInversionesCofinanciadoresProduccionDBRepositoryDB(
          List<PerfilPreInversionCofinanciadorEntity>
              perfilesPreInversionesCofinanciadoresEntity) async {
    try {
      final result = await perfilPreInversionCofinanciadorLocalDataSource
          .updatePerfilesPreInversionesCofinanciadoresProduccion(
              perfilesPreInversionesCofinanciadoresEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
