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
      getPerfilPreInversionplanesNegociosRepository(
          UsuarioEntity usuario) async {
    try {
      final perfilPreInversionplanesNegocios =
          await perfilPreInversionPlanNegocioRemoteDataSource
              .getPerfilPreInversionplanesNegocios(usuario);

      return Right(perfilPreInversionplanesNegocios);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      savePerfilesPreInversionesplanesNegociosRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionPlanNegocioEntity>
              perfilesPreInversionesplanesNegociosEntity) async {
    try {
      final result = await perfilPreInversionPlanNegocioRemoteDataSource
          .savePerfilesPreInversionesplanesNegocios(
              usuario, perfilesPreInversionesplanesNegociosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
