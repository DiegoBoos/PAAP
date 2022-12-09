import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../../domain/repositories/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_repository_db.dart';
import '../../datasources/local/perfil_preinversion_cofinanciador_desembolso_local_ds.dart';

class PerfilPreInversionCofinanciadorDesembolsoRepositoryDBImpl
    implements PerfilPreInversionCofinanciadorDesembolsoRepositoryDB {
  final PerfilPreInversionCofinanciadorDesembolsoLocalDataSource
      perfilPreInversionCofinanciadorDesembolsoLocalDataSource;

  PerfilPreInversionCofinanciadorDesembolsoRepositoryDBImpl(
      {required this.perfilPreInversionCofinanciadorDesembolsoLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorDesembolsoEntity>>>
      getPerfilPreInversionCofinanciadorDesembolsosRepositoryDB() async {
    try {
      final perfilPreInversionCofinanciadorDesembolsos =
          await perfilPreInversionCofinanciadorDesembolsoLocalDataSource
              .getPerfilPreInversionCofinanciadorDesembolsos();

      return Right(perfilPreInversionCofinanciadorDesembolsos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilPreInversionCofinanciadorDesembolsoEntity?>>
      getPerfilPreInversionCofinanciadorDesembolsoRepositoryDB(
          String perfilPreInversionId, String cofinanciadorId) async {
    try {
      final perfilPreInversionCofinanciadorDesembolso =
          await perfilPreInversionCofinanciadorDesembolsoLocalDataSource
              .getPerfilPreInversionCofinanciadorDesembolso(
                  perfilPreInversionId, cofinanciadorId);

      return Right(perfilPreInversionCofinanciadorDesembolso);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorDesembolsoEntity>?>>
      getPerfilPreInversionCofinanciadorDesembolsosByCofinanciadorRepositoryDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String desembolsoId) async {
    try {
      final perfilPreInversionCofinanciadorDesembolso =
          await perfilPreInversionCofinanciadorDesembolsoLocalDataSource
              .getPerfilPreInversionCofinanciadorDesembolsosByCofinanciador(
                  perfilPreInversionId, cofinanciadorId, desembolsoId);

      return Right(perfilPreInversionCofinanciadorDesembolso);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorDesembolsosRepositoryDB(
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              perfilPreInversionCofinanciadorDesembolsoEntity) async {
    try {
      final result =
          await perfilPreInversionCofinanciadorDesembolsoLocalDataSource
              .savePerfilPreInversionCofinanciadorDesembolsos(
                  perfilPreInversionCofinanciadorDesembolsoEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorDesembolsoEntity>>>
      getPerfilesPreInversionesCofinanciadoresDesembolsosProduccionRepositoryDB() async {
    try {
      final perfilPreInversionCofinanciadorDesembolsos =
          await perfilPreInversionCofinanciadorDesembolsoLocalDataSource
              .getPerfilesPreInversionesCofinanciadoresDesembolsosProduccion();

      return Right(perfilPreInversionCofinanciadorDesembolsos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorDesembolsoRepositoryDB(
          PerfilPreInversionCofinanciadorDesembolsoEntity
              perfilPreInversionCofinanciadorDesembolsoEntity) async {
    try {
      final perfilPreInversionCofinanciadorDesembolso =
          await perfilPreInversionCofinanciadorDesembolsoLocalDataSource
              .savePerfilPreInversionCofinanciadorDesembolso(
                  perfilPreInversionCofinanciadorDesembolsoEntity);
      return Right(perfilPreInversionCofinanciadorDesembolso);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccionDBRepositoryDB(
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              perfilesPreInversionesCofinanciadoresDesembolsosEntity) async {
    try {
      final result =
          await perfilPreInversionCofinanciadorDesembolsoLocalDataSource
              .updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccion(
                  perfilesPreInversionesCofinanciadoresDesembolsosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
