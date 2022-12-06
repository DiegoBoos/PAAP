import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/evaluacion_entity.dart';
import '../../entities/evaluacion_respuesta_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class EvaluacionRespuestaRepository {
  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasRepository(UsuarioEntity usuario);
  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasNuevasRepository(
          UsuarioEntity usuario, List<EvaluacionEntity> evaluaciones);
  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      saveEvaluacionesRespuestasRepository(UsuarioEntity usuario,
          List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity);
}
