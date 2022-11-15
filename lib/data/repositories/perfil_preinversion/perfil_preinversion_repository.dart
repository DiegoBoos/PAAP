import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_preinversion/perfil_preinversion_repository.dart';
import '../../datasources/remote/perfil_preinversion/perfil_preinversion_remote_ds.dart';

class PerfilPreInversionRepositoryImpl implements PerfilPreInversionRepository {
  final PerfilPreInversionRemoteDataSource perfilPreInversionRemoteDataSource;

  PerfilPreInversionRepositoryImpl(
      {required this.perfilPreInversionRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilPreInversionEntity>>>
      getPerfilesPreInversionRepository(UsuarioEntity usuario) async {
    try {
      final perfilesPreInversion = await perfilPreInversionRemoteDataSource
          .getPerfilesPreInversion(usuario);

      return Right(perfilesPreInversion);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
