import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/agrupacion_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class AgrupacionRepository {
  Future<Either<Failure, List<AgrupacionEntity>>> getAgrupacionesRepository(
      UsuarioEntity usuario);
}
