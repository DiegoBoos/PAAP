import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/evaluacion_respuesta_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class EvaluacionRespuestaRepository {
  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasRepository(UsuarioEntity usuario);
  Future<Either<Failure, int>> saveEvaluacionRespuestaRepository(
      UsuarioEntity usuario,
      EvaluacionRespuestaEntity evaluacionRespuestaEntity);
}
