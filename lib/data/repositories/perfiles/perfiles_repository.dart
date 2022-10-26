import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/perfiles_entity.dart';
import 'package:paap/domain/entities/usuario_entity.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/vperfil_entity.dart';
import '../../../domain/repositories/perfiles/perfiles_repository.dart';
import '../../datasources/remote/perfiles/perfiles_remote_ds.dart';

class PerfilesRepositoryImpl implements PerfilesRepository {
  final PerfilesRemoteDataSource perfilRemoteDataSource;

  PerfilesRepositoryImpl({required this.perfilRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilesEntity>>> getPerfilesRepository(
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

  @override
  Future<Either<Failure, List<PerfilesEntity>>> getPerfilesFiltrosRepository(
      UsuarioEntity usuario, String? id, String? nombre) async {
    try {
      final perfiles = await perfilRemoteDataSource.getPerfilesFiltros(
          usuario, id ?? '', nombre ?? '');

      return Right(perfiles);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, VPerfilEntity>> getPerfilRepository(
      UsuarioEntity usuario, String perfilId) async {
    try {
      final perfil = await perfilRemoteDataSource.getPerfil(usuario, perfilId);

      return Right(perfil);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
