import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_entity.dart';
import '../../repositories/perfiles/perfiles_repository.dart';

class PerfilesUsecase {
  final PerfilesRepository repository;

  PerfilesUsecase(this.repository);

  Future<Either<Failure, List<PerfilEntity>>> getPerfilesUsecase(
      String usuarioId, String contrasena) {
    return repository.getPerfilesRepository(usuarioId, contrasena);
  }

  Future<Either<Failure, List<PerfilEntity>>> getPerfilesFiltrosUsecase(
      String usuarioId, String contrasena, String id, String nombre) {
    return repository.getPerfilesFiltrosRepository(
        usuarioId, contrasena, id, nombre);
  }
}
