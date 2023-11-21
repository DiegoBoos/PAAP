import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/usuario_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UsuarioEntity>> verificacionRepository(
      UsuarioEntity usuario);
}
