import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_entity.dart';
import '../../entities/usuario_entity.dart';

abstract class PerfilRepository {
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesRepository(
      UsuarioEntity usuario);
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesFiltrosRepository(
      UsuarioEntity usuario, String? id, String? nombre);
}
