import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/unidad_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class UnidadRepository {
  Future<Either<Failure, List<UnidadEntity>>> getUnidadesRepository(
      UsuarioEntity usuario);
}
