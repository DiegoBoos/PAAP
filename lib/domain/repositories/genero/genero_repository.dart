import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/genero_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class GeneroRepository {
  Future<Either<Failure, List<GeneroEntity>>> getGenerosRepository(
      UsuarioEntity usuario);
}
