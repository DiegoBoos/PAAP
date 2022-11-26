import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';
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
      final perfilPreInversionPlanNegociosDB =
          await perfilPreInversionPlanNegocioLocalDataSource
              .getPerfilPreInversionPlanNegociosDB();

      return Right(perfilPreInversionPlanNegociosDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, PerfilPreInversionPlanNegocioEntity?>>
      getPerfilPreInversionPlanNegocioRepositoryDB(
          String perfilPreInversionId, String rubroId, String year) async {
    try {
      final perfilPreInversionPlanNegocioDB =
          await perfilPreInversionPlanNegocioLocalDataSource
              .getPerfilPreInversionPlanNegocioDB(
                  perfilPreInversionId, rubroId, year);

      return Right(perfilPreInversionPlanNegocioDB);
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
      final perfilPreInversionPlanNegociosDB =
          await perfilPreInversionPlanNegocioLocalDataSource
              .getPerfilesPreInversionesPlanNegociosProduccionDB();

      return Right(perfilPreInversionPlanNegociosDB);
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
      updatePerfilesPreInversionesPlanNegociosProduccionDBRepositoryDB(
          List<PerfilPreInversionPlanNegocioEntity>
              perfilesPreInversionesPlanNegociosEntity) async {
    try {
      final result = await perfilPreInversionPlanNegocioLocalDataSource
          .updatePerfilesPreInversionesPlanNegociosProduccionDB(
              perfilesPreInversionesPlanNegociosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
