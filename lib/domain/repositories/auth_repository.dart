import 'package:dartz/dartz.dart';

import '../core/error/failure.dart';
import '../entities/usuario.dart';

abstract class AuthRepository {
  Future<Either<Failure, UsuarioEntity>> getUsuario();
}
