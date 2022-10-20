import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/usuario_entity.dart';

import '../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UsuarioEntity>> verificacionRepository(
      String usuarioId, String contrasena);
}
