import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/perfil_aliado_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/perfil_aliado/perfil_aliado_repository.dart';
import '../../datasources/remote/perfil_aliado_remote_ds.dart';

class PerfilAliadoRepositoryImpl implements PerfilAliadoRepository {
  final PerfilAliadoRemoteDataSource perfilAliadoRemoteDataSource;

  PerfilAliadoRepositoryImpl({required this.perfilAliadoRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilAliadoEntity>>> getPerfilAliadosRepository(
      UsuarioEntity usuario) async {
    try {
      final tipoproyectos =
          await perfilAliadoRemoteDataSource.getPerfilAliados(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilAliadoEntity>>>
      savePerfilesAliadosRepository(UsuarioEntity usuario,
          List<PerfilAliadoEntity> perfilesAliadosEntity) async {
    try {
      final result = await perfilAliadoRemoteDataSource.savePerfilesAliados(
          usuario, perfilesAliadosEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
