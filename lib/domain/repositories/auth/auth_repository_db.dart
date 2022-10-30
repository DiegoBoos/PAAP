import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';

abstract class AuthRepositoryDB {
  Future<Either<Failure, UsuarioEntity?>> verificacionRepositoryDB(
      UsuarioEntity usuario);

  Future<Either<Failure, int>> saveUsuarioRepositoryDB(
      UsuarioEntity usuarioEntity);
}
