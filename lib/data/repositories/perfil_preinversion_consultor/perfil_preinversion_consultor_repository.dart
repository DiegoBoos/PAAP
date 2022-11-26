import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_consultor_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_preinversion_consultor/perfil_preinversion_consultor_repository.dart';
import '../../datasources/remote/perfil_preinversion_consultor_remote_ds.dart';

class PerfilPreInversionConsultorRepositoryImpl
    implements PerfilPreInversionConsultorRepository {
  final PerfilPreInversionConsultorRemoteDataSource
      perfilPreInversionConsultorRemoteDataSource;

  PerfilPreInversionConsultorRepositoryImpl(
      {required this.perfilPreInversionConsultorRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>>>
      getPerfilPreInversionConsultoresRepository(UsuarioEntity usuario) async {
    try {
      final perfilPreInversionConsultores =
          await perfilPreInversionConsultorRemoteDataSource
              .getPerfilPreInversionConsultores(usuario);

      return Right(perfilPreInversionConsultores);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>>>
      savePerfilesPreInversionesConsultoresRepository(
          UsuarioEntity usuario,
          List<PerfilPreInversionConsultorEntity>
              perfilesPreInversionesConsultoresEntity) async {
    try {
      final result = await perfilPreInversionConsultorRemoteDataSource
          .savePerfilesPreInversionesConsultores(
              usuario, perfilesPreInversionesConsultoresEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
