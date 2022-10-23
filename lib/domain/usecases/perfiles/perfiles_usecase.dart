import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfiles_entity.dart';
import '../../repositories/perfiles/perfiles_repository.dart';

class PerfilesUsecase {
  final PerfilesRepository repository;

  PerfilesUsecase(this.repository);

  Future<Either<Failure, List<PerfilesEntity>>> getPerfilesUsecase(
      String usuarioId, String contrasena) {
    return repository.getPerfilesRepository(usuarioId, contrasena);
  }

  Future<Either<Failure, List<PerfilesEntity>>> getPerfilesFiltrosUsecase(
      String usuarioId, String contrasena, String? id, String? nombre) {
    return repository.getPerfilesFiltrosRepository(
        usuarioId, contrasena, id ?? '', nombre ?? '');
  }
}
