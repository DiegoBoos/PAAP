import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_aliado_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_preinversion_aliado/perfil_preinversion_aliado_repository.dart';
import '../../datasources/remote/perfil_preinversion_aliado/perfil_preinversion_aliado_remote_ds.dart';

class PerfilPreInversionAliadoRepositoryImpl
    implements PerfilPreInversionAliadoRepository {
  final PerfilPreInversionAliadoRemoteDataSource
      perfilPreInversionAliadoRemoteDataSource;

  PerfilPreInversionAliadoRepositoryImpl(
      {required this.perfilPreInversionAliadoRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>>>
      getPerfilPreInversionAliadosRepository(UsuarioEntity usuario) async {
    try {
      final perfilPreInversionAliados =
          await perfilPreInversionAliadoRemoteDataSource
              .getPerfilPreInversionAliados(usuario);

      return Right(perfilPreInversionAliados);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>>>
      savePerfilesPreInversionesAliadosRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionAliadoEntity>
              perfilesPreInversionesAliadosEntity) async {
    try {
      final result = await perfilPreInversionAliadoRemoteDataSource
          .savePerfilesPreInversionesAliados(
              usuario, perfilesPreInversionesAliadosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
