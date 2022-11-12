import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/evaluacion_entity.dart';

import '../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/evaluacion/evaluacion_repository.dart';

class EvaluacionUsecase {
  final EvaluacionRepository repository;

  EvaluacionUsecase(this.repository);

  Future<Either<Failure, int>> saveEvaluacionUsecase(
      UsuarioEntity usuario, EvaluacionEntity evaluacionEntity) {
    return repository.saveEvaluacionRepository(usuario, evaluacionEntity);
  }

  Future<Either<Failure, List<EvaluacionEntity>>> getEvaluacionesUsecase(
      UsuarioEntity usuario) {
    return repository.getEvaluacionesRepository(usuario);
  }
}
