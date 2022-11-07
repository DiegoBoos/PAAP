import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/frecuencia/frecuencia_repository.dart';
import '../../datasources/remote/frecuencia/frecuencia_remote_ds.dart';

class FrecuenciaRepositoryImpl implements FrecuenciaRepository {
  final FrecuenciaRemoteDataSource frecuenciaRemoteDataSource;

  FrecuenciaRepositoryImpl({required this.frecuenciaRemoteDataSource});

  @override
  Future<Either<Failure, List<FrecuenciaEntity>>> getFrecuenciasRepository(
      UsuarioEntity usuario) async {
    try {
      final tipoproyectos =
          await frecuenciaRemoteDataSource.getFrecuencias(usuario);

      return Right(tipoproyectos);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
