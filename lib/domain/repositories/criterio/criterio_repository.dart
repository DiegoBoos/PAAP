import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/criterio_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class CriterioRepository {
  Future<Either<Failure, List<CriterioEntity>>> getCriteriosRepository(
      UsuarioEntity usuario);
}
