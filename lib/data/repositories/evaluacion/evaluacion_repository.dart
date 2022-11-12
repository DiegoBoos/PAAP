import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/entities/evaluacion_entity.dart';
import '../../../domain/repositories/evaluacion/evaluacion_repository.dart';
import '../../datasources/remote/evaluacion/evaluacion_remote_ds.dart';

class EvaluacionRepositoryImpl implements EvaluacionRepository {
  final EvaluacionRemoteDataSource evaluacionRemoteDataSource;

  EvaluacionRepositoryImpl({required this.evaluacionRemoteDataSource});

  @override
  Future<Either<Failure, List<EvaluacionEntity>>> getEvaluacionesRepository(
      UsuarioEntity usuario) async {
    try {
      final evaluaciones =
          await evaluacionRemoteDataSource.getEvaluaciones(usuario);

      return Right(evaluaciones);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEvaluacionRepository(
      UsuarioEntity usuario, EvaluacionEntity evaluacionEntity) async {
    try {
      final result = await evaluacionRemoteDataSource.saveEvaluacion(
          usuario, evaluacionEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
