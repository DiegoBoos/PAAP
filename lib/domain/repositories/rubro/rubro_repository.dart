import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/rubro_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class RubroRepository {
  Future<Either<Failure, List<RubroEntity>>> getRubrosRepository(
      UsuarioEntity usuario);
}
