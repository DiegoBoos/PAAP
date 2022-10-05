import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/usuario.dart';

import '../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UsuarioEntity>> verificarUsuario(
      String usuarioId, String contrasena);
}
