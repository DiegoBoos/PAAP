import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../../domain/repositories/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_repository_db.dart';
import '../../datasources/local/perfil_preinversion_cofinanciador_rubro_local_ds.dart';

class PerfilPreInversionCofinanciadorRubroRepositoryDBImpl
    implements PerfilPreInversionCofinanciadorRubroRepositoryDB {
  final PerfilPreInversionCofinanciadorRubroLocalDataSource
      perfilPreInversionCofinanciadorRubroLocalDataSource;

  PerfilPreInversionCofinanciadorRubroRepositoryDBImpl(
      {required this.perfilPreInversionCofinanciadorRubroLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      getPerfilPreInversionCofinanciadorRubrosRepositoryDB() async {
    try {
      final perfilPreInversionCofinanciadorRubros =
          await perfilPreInversionCofinanciadorRubroLocalDataSource
              .getPerfilPreInversionCofinanciadorRubros();

      return Right(perfilPreInversionCofinanciadorRubros);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilPreInversionCofinanciadorRubroEntity?>>
      getPerfilPreInversionCofinanciadorRubroRepositoryDB(
          String perfilPreInversionId, String cofinanciadorId) async {
    try {
      final perfilPreInversionCofinanciadorRubro =
          await perfilPreInversionCofinanciadorRubroLocalDataSource
              .getPerfilPreInversionCofinanciadorRubro(
                  perfilPreInversionId, cofinanciadorId);

      return Right(perfilPreInversionCofinanciadorRubro);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      getPerfilPreInversionCofinanciadorRubrosByCofinanciadorRepositoryDB(
          String perfilPreInversionId, String cofinanciadorId) async {
    try {
      final perfilPreInversionCofinanciadorRubrosByCofinanciador =
          await perfilPreInversionCofinanciadorRubroLocalDataSource
              .getPerfilPreInversionCofinanciadorRubrosByCofinanciador(
                  perfilPreInversionId, cofinanciadorId);

      return Right(perfilPreInversionCofinanciadorRubrosByCofinanciador);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorRubrosRepositoryDB(
          List<PerfilPreInversionCofinanciadorRubroEntity>
              perfilPreInversionCofinanciadorRubroEntity) async {
    try {
      final result = await perfilPreInversionCofinanciadorRubroLocalDataSource
          .savePerfilPreInversionCofinanciadorRubros(
              perfilPreInversionCofinanciadorRubroEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      getPerfilesPreInversionesCofinanciadoresRubrosProduccionRepositoryDB() async {
    try {
      final perfilPreInversionCofinanciadorRubros =
          await perfilPreInversionCofinanciadorRubroLocalDataSource
              .getPerfilesPreInversionesCofinanciadoresRubrosProduccion();

      return Right(perfilPreInversionCofinanciadorRubros);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorRubroRepositoryDB(
          PerfilPreInversionCofinanciadorRubroEntity
              perfilPreInversionCofinanciadorRubroEntity) async {
    try {
      final perfilPreInversionCofinanciadorRubro =
          await perfilPreInversionCofinanciadorRubroLocalDataSource
              .savePerfilPreInversionCofinanciadorRubro(
                  perfilPreInversionCofinanciadorRubroEntity);
      return Right(perfilPreInversionCofinanciadorRubro);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updatePerfilesPreInversionesCofinanciadoresRubrosProduccionDBRepositoryDB(
          List<PerfilPreInversionCofinanciadorRubroEntity>
              perfilesPreInversionesCofinanciadoresRubrosEntity) async {
    try {
      final result = await perfilPreInversionCofinanciadorRubroLocalDataSource
          .updatePerfilesPreInversionesCofinanciadoresRubrosProduccion(
              perfilesPreInversionesCofinanciadoresRubrosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
