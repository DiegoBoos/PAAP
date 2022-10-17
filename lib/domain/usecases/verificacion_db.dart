import 'package:dartz/dartz.dart';

import '../core/error/failure.dart';
import '../entities/usuario_entity.dart';
import '../repositories/auth_repository.dart';

class VerificacionDB {
  final AuthRepository repository;

  VerificacionDB(this.repository);

  Future<Either<Failure, List<Map<String, Object?>>>> existeUsuarioDB() {
    return repository.existeUsuarioDB();
  }

  Future<Either<Failure, int>> guardarUsuarioDB(UsuarioEntity usuarioEntity) {
    return repository.guardarUsuarioDB(usuarioEntity);
  }

  Future<Either<Failure, List<Map>>> verificacionDB(
      String usuarioId, String contrasena) {
    return repository.verificacionDB(usuarioId, contrasena);
  }
}
