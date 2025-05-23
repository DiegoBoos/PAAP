import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
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
      final perfilPreInversionCofinanciadorActividadesFinancieras =
          await perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
              .getPerfilPreInversionCofinanciadorActividadesFinancieras();

      return Right(perfilPreInversionCofinanciadorActividadesFinancieras);
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
      final perfilPreInversionCofinanciadorActividadFinancieras =
          await perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
              .getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccion();

      return Right(perfilPreInversionCofinanciadorActividadFinancieras);
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
  ) async {
    try {
      final perfilPreInversionCofinanciadorActividadFinanciera =
          await perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
              .getPerfilPreInversionCofinanciadorActividadFinanciera(
        perfilPreInversionId,
        cofinanciadorId,
      );

      return Right(perfilPreInversionCofinanciadorActividadFinanciera);
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
          String perfilPreInversionId, String cofinanciadorId) async {
    try {
      final perfilPreInversionCofinanciadorActividadesFinancieras =
          await perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
              .getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
                  perfilPreInversionId, cofinanciadorId);

      return Right(perfilPreInversionCofinanciadorActividadesFinancieras);
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
      final perfilPreInversionCofinanciadorActividadFinanciera =
          await perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource
              .savePerfilPreInversionCofinanciadorActividadFinanciera(
                  perfilPreInversionCofinanciadorActividadFinancieraEntity);
      return Right(perfilPreInversionCofinanciadorActividadFinanciera);
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
              .updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccion(
                  perfilesPreInversionesCofinanciadoresActividadesFinancierasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
