import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/usuario.dart';

import '../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class GetUsuario {
  final AuthRepository repository;

  GetUsuario(this.repository);

  Future<Either<Failure, UsuarioEntity>> execute() {
    return repository.getUsuario();
  }
}
