import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/evaluacion_entity.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/evaluacion/evaluacion_repository.dart';

class EvaluacionUsecase {
  final EvaluacionRepository repository;

  EvaluacionUsecase(this.repository);

  Future<Either<Failure, List<EvaluacionEntity>>> getEvaluacionesUsecase(
      UsuarioEntity usuario) {
    return repository.getEvaluacionesRepository(usuario);
  }

  Future<Either<Failure, List<EvaluacionEntity>>> getEvaluacionesNuevasUsecase(
      UsuarioEntity usuario, List<String> perfilesIds) {
    return repository.getEvaluacionesNuevasRepository(usuario, perfilesIds);
  }

  Future<Either<Failure, List<EvaluacionEntity>>> saveEvaluacionesUsecase(
      UsuarioEntity usuario, List<EvaluacionEntity> evaluacionesEntity) {
    return repository.saveEvaluacionesRepository(usuario, evaluacionesEntity);
  }
}
