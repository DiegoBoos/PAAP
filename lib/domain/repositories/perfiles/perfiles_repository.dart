import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/perfiles_entity.dart';

import '../../core/error/failure.dart';

abstract class PerfilesRepository {
  Future<Either<Failure, List<PerfilesEntity>>> getPerfilesRepository(
      String usuarioId, String contrasena);
  Future<Either<Failure, List<PerfilesEntity>>> getPerfilesFiltrosRepository(
      String usuarioId, String contrasena, String? id, String? nombre);
}
