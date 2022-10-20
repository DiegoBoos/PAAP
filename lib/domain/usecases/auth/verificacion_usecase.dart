import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/auth/auth_repository.dart';

class VerificacionUsecase {
  final AuthRepository repository;

  VerificacionUsecase(this.repository);

  Future<Either<Failure, UsuarioEntity>> verificacionUsecase(
      String usuarioId, String contrasena) {
    return repository.verificacionRepository(usuarioId, contrasena);
  }
}
