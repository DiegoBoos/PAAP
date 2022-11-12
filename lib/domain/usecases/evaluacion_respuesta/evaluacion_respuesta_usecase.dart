import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/evaluacion_respuesta_entity.dart';

import '../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/evaluacion_respuesta/evaluacion_respuesta_repository.dart';

class EvaluacionRespuestaUsecase {
  final EvaluacionRespuestaRepository repository;

  EvaluacionRespuestaUsecase(this.repository);

  Future<Either<Failure, int>> saveEvaluacionRespuestaUsecase(
      UsuarioEntity usuario, EvaluacionRespuestaEntity evaluacionEntity) {
    return repository.saveEvaluacionRespuestaRepository(
        usuario, evaluacionEntity);
  }

  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasUsecase(UsuarioEntity usuario) {
    return repository.getEvaluacionesRespuestasRepository(usuario);
  }
}
