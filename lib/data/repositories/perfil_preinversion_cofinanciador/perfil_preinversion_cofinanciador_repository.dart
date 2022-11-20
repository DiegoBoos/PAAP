import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_repository.dart';
import '../../datasources/remote/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_remote_ds.dart';

class PerfilPreInversionCofinanciadorRepositoryImpl
    implements PerfilPreInversionCofinanciadorRepository {
  final PerfilPreInversionCofinanciadorRemoteDataSource
      perfilPreInversionCofinanciadorRemoteDataSource;

  PerfilPreInversionCofinanciadorRepositoryImpl(
      {required this.perfilPreInversionCofinanciadorRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      getPerfilPreInversionCofinanciadoresRepository(
          UsuarioEntity usuario) async {
    try {
      final perfilPreInversionCofinanciadores =
          await perfilPreInversionCofinanciadorRemoteDataSource
              .getPerfilesPreInversionesCofinanciadores(usuario);

      return Right(perfilPreInversionCofinanciadores);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      savePerfilesPreInversionesCofinanciadoresRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorEntity>
              perfilesPreInversionesCofinanciadoresEntity) async {
    try {
      final result = await perfilPreInversionCofinanciadorRemoteDataSource
          .savePerfilesPreInversionesCofinanciadores(
              usuario, perfilesPreInversionesCofinanciadoresEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
