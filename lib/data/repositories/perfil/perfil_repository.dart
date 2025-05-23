import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/perfil_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil/perfil_repository.dart';
import '../../datasources/remote/perfil_remote_ds.dart';

class PerfilRepositoryImpl implements PerfilRepository {
  final PerfilRemoteDataSource perfilRemoteDataSource;

  PerfilRepositoryImpl({required this.perfilRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesRepository(
      UsuarioEntity usuario) async {
    try {
      final perfiles = await perfilRemoteDataSource.getPerfiles(usuario);

      return Right(perfiles);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
