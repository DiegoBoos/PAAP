import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/perfiles_entity.dart';

import '../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';
import '../../entities/vperfil_entity.dart';

abstract class PerfilesRepository {
  Future<Either<Failure, List<PerfilesEntity>>> getPerfilesRepository(
      UsuarioEntity usuario);
  Future<Either<Failure, List<PerfilesEntity>>> getPerfilesFiltrosRepository(
      UsuarioEntity usuario, String? id, String? nombre);

  Future<Either<Failure, VPerfilEntity>> getPerfilRepository(
      UsuarioEntity usuario, String perfilId);
}
