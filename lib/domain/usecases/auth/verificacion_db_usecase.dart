import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/auth/auth_repository_db.dart';

class VerificacionUsecaseDB {
  final AuthRepositoryDB repositoryDB;

  VerificacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveUsuarioUsecaseDB(
      UsuarioEntity usuarioEntity) {
    return repositoryDB.saveUsuarioRepositoryDB(usuarioEntity);
  }

  Future<Either<Failure, UsuarioEntity?>> verificacionUsecaseDB(
      String usuarioId, String contrasena) {
    return repositoryDB.verificacionRepositoryDB(usuarioId, contrasena);
  }
}
