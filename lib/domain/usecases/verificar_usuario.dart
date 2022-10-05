import 'package:dartz/dartz.dart';

import '../core/error/failure.dart';
import '../entities/usuario.dart';
import '../repositories/auth_repository.dart';

class VerificarUsuario {
  final AuthRepository repository;

  VerificarUsuario(this.repository);

  Future<Either<Failure, UsuarioEntity>> execute(
      String usuarioId, String contrasena) {
    return repository.verificarUsuario(usuarioId, contrasena);
  }
}
