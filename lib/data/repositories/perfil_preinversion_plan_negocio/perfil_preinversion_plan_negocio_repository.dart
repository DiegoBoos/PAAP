import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_repository.dart';
import '../../datasources/remote/perfil_preinversion_plan_negocio_remote_ds.dart';

class PerfilPreInversionPlanNegocioRepositoryImpl
    implements PerfilPreInversionPlanNegocioRepository {
  final PerfilPreInversionPlanNegocioRemoteDataSource
      perfilPreInversionPlanNegocioRemoteDataSource;

  PerfilPreInversionPlanNegocioRepositoryImpl(
      {required this.perfilPreInversionPlanNegocioRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilPreInversionPlanNegociosRepository(UsuarioEntity usuario) async {
    try {
      final perfilPreInversionPlanNegocios =
          await perfilPreInversionPlanNegocioRemoteDataSource
              .getPerfilPreInversionPlanNegocios(usuario);

      return Right(perfilPreInversionPlanNegocios);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      savePerfilesPreInversionesPlanNegociosRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionPlanNegocioEntity>
              perfilesPreInversionesPlanNegociosEntity) async {
    try {
      final result = await perfilPreInversionPlanNegocioRemoteDataSource
          .savePerfilesPreInversionesPlanNegocios(
              usuario, perfilesPreInversionesPlanNegociosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
