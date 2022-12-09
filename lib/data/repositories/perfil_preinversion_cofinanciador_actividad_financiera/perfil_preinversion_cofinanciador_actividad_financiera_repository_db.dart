import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../../domain/repositories/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_repository_db.dart';
import '../../datasources/local/perfil_preinversion_cofinanciador_actividad_financiera_local_ds.dart';

class PerfilPreInversionCofinanciadorActividadFinancieraRepositoryDBImpl
    implements PerfilPreInversionCofinanciadorActividadFinancieraRepositoryDB {
  final PerfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
      perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource;

  PerfilPreInversionCofinanciadorActividadFinancieraRepositoryDBImpl(
      {required this.perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource});

  @override
  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasRepositoryDB() async {
    try {
      final perfilPreInversionCofinanciadorActividadesFinancierasDB =
          await perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
              .getPerfilPreInversionCofinanciadorActividadesFinancierasDB();

      return Right(perfilPreInversionCofinanciadorActividadesFinancierasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>>
      getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionRepositoryDB() async {
    try {
      final perfilPreInversionCofinanciadorActividadFinancierasDB =
          await perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
              .getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionDB();

      return Right(perfilPreInversionCofinanciadorActividadFinancierasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<
          Either<Failure,
              PerfilPreInversionCofinanciadorActividadFinancieraEntity?>>
      getPerfilPreInversionCofinanciadorActividadFinancieraRepositoryDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String desembolsoId) async {
    try {
      final perfilPreInversionCofinanciadorActividadFinancieraDB =
          await perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
              .getPerfilPreInversionCofinanciadorActividadFinancieraDB(
                  perfilPreInversionId, cofinanciadorId, desembolsoId);

      return Right(perfilPreInversionCofinanciadorActividadFinancieraDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciadorRepositoryDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String actividadFinancieraId,
          String desembolsoId) async {
    try {
      final perfilPreInversionCofinanciadorActividadesFinancierasDB =
          await perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
              .getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciadorDB(
                  perfilPreInversionId,
                  cofinanciadorId,
                  actividadFinancieraId,
                  desembolsoId);

      return Right(perfilPreInversionCofinanciadorActividadesFinancierasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorActividadesFinancierasRepositoryDB(
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilPreInversionCofinanciadorActividadFinancieraEntity) async {
    try {
      final result =
          await perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
              .savePerfilPreInversionCofinanciadorActividadesFinancieras(
                  perfilPreInversionCofinanciadorActividadFinancieraEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorActividadFinancieraRepositoryDB(
          PerfilPreInversionCofinanciadorActividadFinancieraEntity
              perfilPreInversionCofinanciadorActividadFinancieraEntity) async {
    try {
      final perfilPreInversionCofinanciadorActividadFinancieraDB =
          await perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
              .savePerfilPreInversionCofinanciadorActividadFinancieraDB(
                  perfilPreInversionCofinanciadorActividadFinancieraEntity);
      return Right(perfilPreInversionCofinanciadorActividadFinancieraDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionDBRepositoryDB(
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilesPreInversionesCofinanciadoresActividadesFinancierasEntity) async {
    try {
      final result =
          await perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
              .updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionDB(
                  perfilesPreInversionesCofinanciadoresActividadesFinancierasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
