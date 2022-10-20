import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/usuario_entity.dart';

import '../../core/error/failure.dart';

abstract class AuthRepositoryDB {
  Future<Either<Failure, UsuarioEntity?>> verificacionRepositoryDB(
      String usuarioId, String contrasena);

  Future<Either<Failure, int>> saveUsuarioRepositoryDB(
      UsuarioEntity usuarioEntity);
}
