import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/evaluacion_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class EvaluacionRepository {
  Future<Either<Failure, List<EvaluacionEntity>>> getEvaluacionesRepository(
      UsuarioEntity usuario);
  Future<Either<Failure, int>> saveEvaluacionRepository(
      UsuarioEntity usuario, EvaluacionEntity evaluacionEntity);
}
