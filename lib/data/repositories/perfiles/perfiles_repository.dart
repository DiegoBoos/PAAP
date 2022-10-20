import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/perfil_entity.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/repositories/perfiles/perfiles_repository.dart';
import '../../datasources/remote/perfiles/perfiles_remote_ds.dart';
import '../../models/perfil_model.dart';

class PerfilesRepositoryImpl implements PerfilesRepository {
  final PerfilesRemoteDataSource perfilRemoteDataSource;

  PerfilesRepositoryImpl({required this.perfilRemoteDataSource});

  @override
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesRepository(
      String usuarioId, String contrasena) async {
    try {
      final result =
          await perfilRemoteDataSource.getPerfiles(usuarioId, contrasena);

      final perfilRawList = result.entries.first.value['Table'];
      final perfilList =
          List.from(perfilRawList).map((e) => PerfilModel.fromJson(e)).toList();

      return Right(perfilList);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesFiltrosRepository(
      String usuarioId, String contrasena, String id, String nombre) async {
    try {
      final result = await perfilRemoteDataSource.getPerfilesFiltros(
          usuarioId, contrasena, id, nombre);

      final perfilRawList = result.entries.first.value['Table'];
      final perfilList =
          List.from(perfilRawList).map((e) => PerfilModel.fromJson(e)).toList();

      return Right(perfilList);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
