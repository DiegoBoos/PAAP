import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_repository.dart';
import '../../datasources/remote/perfil_preinversion_cofinanciador_desembolso_remote_ds.dart';

class PerfilPreInversionCofinanciadorDesembolsoRepositoryImpl
    implements PerfilPreInversionCofinanciadorDesembolsoRepository {
  final PerfilPreInversionCofinanciadorDesembolsoRemoteDataSource
      perfilPreInversionCofinanciadorDesembolsoRemoteDataSource;

  PerfilPreInversionCofinanciadorDesembolsoRepositoryImpl(
      {required this.perfilPreInversionCofinanciadorDesembolsoRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorDesembolsoEntity>>>
      getPerfilPreInversionCofinanciadorDesembolsosRepository(
          UsuarioEntity usuario) async {
    try {
      final perfilPreInversionCofinanciadorDesembolsos =
          await perfilPreInversionCofinanciadorDesembolsoRemoteDataSource
              .getPerfilPreInversionCofinanciadorDesembolsos(usuario);

      return Right(perfilPreInversionCofinanciadorDesembolsos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorDesembolsoEntity>>>
      savePerfilesPreInversionesCofinanciadoresDesembolsosRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              perfilesPreInversionesCofinanciadoresDesembolsosEntity) async {
    try {
      final result =
          await perfilPreInversionCofinanciadorDesembolsoRemoteDataSource
              .savePerfilesPreInversionesCofinanciadoresDesembolsos(usuario,
                  perfilesPreInversionesCofinanciadoresDesembolsosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
