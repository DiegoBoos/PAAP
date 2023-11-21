import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/usuario_entity.dart';

abstract class AuthRepositoryDB {
  Future<Either<Failure, UsuarioEntity?>> verificacionRepositoryDB(
      UsuarioEntity usuario);
  Future<Either<Failure, int>> verificacionDatosLocalesRepositoryDB();

  Future<Either<Failure, int>> saveUsuarioRepositoryDB(
      UsuarioEntity usuarioEntity);
}
