import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/evaluacion_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class EvaluacionRepository {
  Future<Either<Failure, List<EvaluacionEntity>>> getEvaluacionesRepository(
      UsuarioEntity usuario);

  Future<Either<Failure, List<EvaluacionEntity>>>
      getEvaluacionesNuevasRepository(
          UsuarioEntity usuario, List<String> perfilesIds);

  Future<Either<Failure, List<EvaluacionEntity>>> saveEvaluacionesRepository(
      UsuarioEntity usuario, List<EvaluacionEntity> evaluacionesEntity);
}
