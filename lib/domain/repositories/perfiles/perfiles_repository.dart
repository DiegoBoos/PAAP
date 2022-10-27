import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../entities/vperfil_entity.dart';

abstract class PerfilesRepository {
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesRepository(
      UsuarioEntity usuario);
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesFiltrosRepository(
      UsuarioEntity usuario, String? id, String? nombre);

  Future<Either<Failure, VPerfilEntity>> getPerfilRepository(
      UsuarioEntity usuario, String perfilId);
}
