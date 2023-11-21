import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/evaluacion_respuesta_entity.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/evaluacion_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/evaluacion_respuesta/evaluacion_respuesta_repository.dart';

class EvaluacionRespuestaUsecase {
  final EvaluacionRespuestaRepository repository;

  EvaluacionRespuestaUsecase(this.repository);

  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasUsecase(UsuarioEntity usuario) {
    return repository.getEvaluacionesRespuestasRepository(usuario);
  }

  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasNuevasUsecase(
          UsuarioEntity usuario, List<EvaluacionEntity> evaluaciones) {
    return repository.getEvaluacionesRespuestasNuevasRepository(
        usuario, evaluaciones);
  }

  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      saveEvaluacionesRespuestasUsecase(UsuarioEntity usuario,
          List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity) {
    return repository.saveEvaluacionesRespuestasRepository(
        usuario, evaluacionesRespuestasEntity);
  }
}
