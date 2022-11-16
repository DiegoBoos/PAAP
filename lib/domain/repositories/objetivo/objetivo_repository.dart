import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/objetivo_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class ObjetivoRepository {
  Future<Either<Failure, List<ObjetivoEntity>>> getObjetivosRepository(
      UsuarioEntity usuario);
}
