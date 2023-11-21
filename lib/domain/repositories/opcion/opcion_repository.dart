import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/opcion_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class OpcionRepository {
  Future<Either<Failure, List<OpcionEntity>>> getOpcionesRepository(
      UsuarioEntity usuario);
}
