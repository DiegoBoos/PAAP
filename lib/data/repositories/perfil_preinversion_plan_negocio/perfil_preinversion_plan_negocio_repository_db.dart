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
      getPerfilPreInversionPlanesNegociosRepositoryDB() async {
    try {
      final perfilPreInversionPlanesNegociosDB =
          await perfilPreInversionPlanNegocioLocalDataSource
              .getPerfilPreInversionPlanesNegociosDB();

      return Right(perfilPreInversionPlanesNegociosDB);
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
      final perfilPreInversionPlanNegocioDB =
          await perfilPreInversionPlanNegocioLocalDataSource
              .getVPerfilesPreInversionesPlanNegociosDB(
                  perfilPreInversionId, tipoMovimientoId);

      return Right(perfilPreInversionPlanNegocioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilPreInversionPlanesNegociosRepositoryDB(
      List<PerfilPreInversionPlanNegocioEntity>
          perfilPreInversionPlanNegocioEntity) async {
    try {
      final result = await perfilPreInversionPlanNegocioLocalDataSource
          .savePerfilPreInversionPlanesNegocios(
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
      getPerfilesPreInversionesPlanesNegociosProduccionRepositoryDB() async {
    try {
      final perfilPreInversionPlanesNegociosDB =
          await perfilPreInversionPlanNegocioLocalDataSource
              .getPerfilesPreInversionesPlanesNegociosProduccionDB();

      return Right(perfilPreInversionPlanesNegociosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePerfilPreInversionPlanNegocioRepositoryDB(
      PerfilPreInversionPlanNegocioEntity
          perfilPreInversionPlanNegocioEntity) async {
    try {
      final perfilPreInversionPlanNegocioDB =
          await perfilPreInversionPlanNegocioLocalDataSource
              .savePerfilPreInversionPlanNegocioDB(
                  perfilPreInversionPlanNegocioEntity);
      return Right(perfilPreInversionPlanNegocioDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updatePerfilesPreInversionesPlanesNegociosProduccionDBRepositoryDB(
          List<PerfilPreInversionPlanNegocioEntity>
              perfilesPreInversionesPlanesNegociosEntity) async {
    try {
      final result = await perfilPreInversionPlanNegocioLocalDataSource
          .updatePerfilesPreInversionesPlanesNegociosProduccionDB(
              perfilesPreInversionesPlanesNegociosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
