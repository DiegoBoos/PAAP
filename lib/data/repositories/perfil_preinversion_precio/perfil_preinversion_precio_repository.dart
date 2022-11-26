import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_precio_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_preinversion_precio/perfil_preinversion_precio_repository.dart';
import '../../datasources/remote/perfil_preinversion_precio_remote_ds.dart';

class PerfilPreInversionPrecioRepositoryImpl
    implements PerfilPreInversionPrecioRepository {
  final PerfilPreInversionPrecioRemoteDataSource
      perfilPreInversionPrecioRemoteDataSource;

  PerfilPreInversionPrecioRepositoryImpl(
      {required this.perfilPreInversionPrecioRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilPreInversionPreciosRepository(UsuarioEntity usuario) async {
    try {
      final perfilPreInversionPrecios =
          await perfilPreInversionPrecioRemoteDataSource
              .getPerfilPreInversionPrecios(usuario);

      return Right(perfilPreInversionPrecios);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      savePerfilesPreInversionesPreciosRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionPrecioEntity>
              perfilesPreInversionesPreciosEntity) async {
    try {
      final result = await perfilPreInversionPrecioRemoteDataSource
          .savePerfilesPreInversionesPrecios(
              usuario, perfilesPreInversionesPreciosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
