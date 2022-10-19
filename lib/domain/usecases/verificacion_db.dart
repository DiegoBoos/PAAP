import 'package:dartz/dartz.dart';

import '../core/error/failure.dart';
import '../entities/usuario_entity.dart';
import '../repositories/auth_repository.dart';

class VerificacionDB {
  final AuthRepository repository;

  VerificacionDB(this.repository);

  Future<Either<Failure, int>> guardarUsuarioDB(UsuarioEntity usuarioEntity) {
    return repository.guardarUsuarioDB(usuarioEntity);
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> verificacionDB(
      String usuarioId, String contrasena) {
    return repository.verificacionDB(usuarioId, contrasena);
  }
}
