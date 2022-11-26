import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_repository.dart';
import '../../datasources/remote/perfil_preinversion_cofinanciador_rubro_remote_ds.dart';

class PerfilPreInversionCofinanciadorRubroRepositoryImpl
    implements PerfilPreInversionCofinanciadorRubroRepository {
  final PerfilPreInversionCofinanciadorRubroRemoteDataSource
      perfilPreInversionCofinanciadorRubroRemoteDataSource;

  PerfilPreInversionCofinanciadorRubroRepositoryImpl(
      {required this.perfilPreInversionCofinanciadorRubroRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      getPerfilPreInversionCofinanciadorRubrosRepository(
          UsuarioEntity usuario) async {
    try {
      final perfilPreInversionCofinanciadorRubros =
          await perfilPreInversionCofinanciadorRubroRemoteDataSource
              .getPerfilPreInversionCofinanciadorRubros(usuario);

      return Right(perfilPreInversionCofinanciadorRubros);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      savePerfilesPreInversionesCofinanciadoresRubrosRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorRubroEntity>
              perfilesPreInversionesCofinanciadoresRubrosEntity) async {
    try {
      final result = await perfilPreInversionCofinanciadorRubroRemoteDataSource
          .savePerfilesPreInversionesCofinanciadoresRubros(
              usuario, perfilesPreInversionesCofinanciadoresRubrosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
