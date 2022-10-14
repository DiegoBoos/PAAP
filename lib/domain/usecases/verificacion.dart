import 'package:dartz/dartz.dart';

import '../core/error/failure.dart';
import '../entities/usuario_entity.dart';
import '../repositories/auth_repository.dart';

class Verificacion {
  final AuthRepository repository;

  Verificacion(this.repository);

  Future<Either<Failure, UsuarioEntity>> verificacion(
      String usuarioId, String contrasena) {
    return repository.verificacion(usuarioId, contrasena);
  }
}
