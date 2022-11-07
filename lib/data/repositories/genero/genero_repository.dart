import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/genero_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/genero/genero_repository.dart';
import '../../datasources/remote/genero/genero_remote_ds.dart';

class GeneroRepositoryImpl implements GeneroRepository {
  final GeneroRemoteDataSource generoRemoteDataSource;

  GeneroRepositoryImpl({required this.generoRemoteDataSource});

  @override
  Future<Either<Failure, List<GeneroEntity>>> getGenerosRepository(
      UsuarioEntity usuario) async {
    try {
      final generos = await generoRemoteDataSource.getGeneros(usuario);

      return Right(generos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
