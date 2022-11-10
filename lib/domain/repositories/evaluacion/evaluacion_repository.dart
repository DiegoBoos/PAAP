import 'package:dartz/dartz.dart';
import 'package:paap/domain/usecases/evaluacion/evaluacion_exports.dart';

import '../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';

abstract class EvaluacionRepository {
  Future<Either<Failure, int>> saveEvaluacionRepository(
      UsuarioEntity usuario, EvaluacionEntity evaluacionEntity);
}
