import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/auth/auth_repository_db.dart';

class AuthUsecaseDB {
  final AuthRepositoryDB repositoryDB;

  AuthUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveUsuarioUsecase(UsuarioEntity usuario) {
    return repositoryDB.saveUsuarioRepositoryDB(usuario);
  }

  Future<Either<Failure, UsuarioEntity?>> verificacionUsecaseDB(
      UsuarioEntity usuario) {
    return repositoryDB.verificacionRepositoryDB(usuario);
  }

  Future<Either<Failure, int>> verificacionDatosLocalesUsecaseDB() {
    return repositoryDB.verificacionDatosLocalesRepositoryDB();
  }
}
