import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/perfil_preinversion_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_preinversion/perfil_preinversion_repository.dart';
import '../../datasources/remote/perfil_preinversion/perfil_preinversion_remote_ds.dart';

class PerfilPreinversionRepositoryImpl implements PerfilPreinversionRepository {
  final PerfilPreinversionRemoteDataSource perfilPreinversionRemoteDataSource;

  PerfilPreinversionRepositoryImpl(
      {required this.perfilPreinversionRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilPreinversionEntity>>>
      getPerfilesPreinversionRepository(UsuarioEntity usuario) async {
    try {
      final perfilesPreinversion = await perfilPreinversionRemoteDataSource
          .getPerfilesPreinversion(usuario);

      return Right(perfilesPreinversion);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
