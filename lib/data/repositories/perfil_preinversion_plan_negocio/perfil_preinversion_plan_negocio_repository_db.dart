import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../../domain/entities/v_perfil_preinversion_plan_negocio_entity.dart';
import '../../../domain/repositories/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_repository_db.dart';
import '../../datasources/local/perfil_preinversion_plan_negocio_local_ds.dart';

class PerfilPreInversionPlanNegocioRepositoryDBImpl
    implements PerfilPreInversionPlanNegocioRepositoryDB {
  final PerfilPreInversionPlanNegocioLocalDataSource
      perfilPreInversionPlanNegocioLocalDataSource;

  PerfilPreInversionPlanNegocioRepositoryDBImpl(
      {required this.perfilPreInversionPlanNegocioLocalDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilPreInversionPlanNegociosRepositoryDB() async {
    try {
      final perfilPreInversionPlanNegocios =
          await perfilPreInversionPlanNegocioLocalDataSource
              .getPerfilPreInversionPlanNegocios();

      return Right(perfilPreInversionPlanNegocios);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<VPerfilPreInversionPlanNegocioEntity>>>
      getVPerfilesPreInversionesPlanNegociosRepositoryDB(
          String perfilPreInversionId, String tipoMovimientoId) async {
    try {
      final perfilPreInversionPlanNegocio =
          await perfilPreInversionPlanNegocioLocalDataSource
              .getVPerfilesPreInversionesPlanNegocios(
                  perfilPreInversionId, tipoMovimientoId);

      return Right(perfilPreInversionPlanNegocio);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilPreInversionPlanNegociosRepositoryDB(
      List<PerfilPreInversionPlanNegocioEntity>
          perfilPreInversionPlanNegocioEntity) async {
    try {
      final result = await perfilPreInversionPlanNegocioLocalDataSource
          .savePerfilPreInversionPlanNegocios(
              perfilPreInversionPlanNegocioEntity);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilesPreInversionesPlanNegociosProduccionRepositoryDB() async {
    try {
      final perfilPreInversionPlanNegocios =
          await perfilPreInversionPlanNegocioLocalDataSource
              .getPerfilesPreInversionesPlanNegociosProduccion();

      return Right(perfilPreInversionPlanNegocios);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, VPerfilPreInversionPlanNegocioEntity>>
      savePerfilPreInversionPlanNegocioRepositoryDB(
          PerfilPreInversionPlanNegocioEntity
              perfilPreInversionPlanNegocioEntity,
          String tipoMovimientoId) async {
    try {
      final perfilPreInversionPlanNegocio =
          await perfilPreInversionPlanNegocioLocalDataSource
              .savePerfilPreInversionPlanNegocio(
                  perfilPreInversionPlanNegocioEntity, tipoMovimientoId);
      return Right(perfilPreInversionPlanNegocio);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updatePerfilesPreInversionesPlanNegociosProduccionDBRepositoryDB(
          List<PerfilPreInversionPlanNegocioEntity>
              perfilesPreInversionesPlanNegociosEntity) async {
    try {
      final result = await perfilPreInversionPlanNegocioLocalDataSource
          .updatePerfilesPreInversionesPlanNegociosProduccion(
              perfilesPreInversionesPlanNegociosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
