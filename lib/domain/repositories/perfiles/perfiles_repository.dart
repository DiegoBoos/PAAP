import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/perfil_entity.dart';

import '../../core/error/failure.dart';

abstract class PerfilesRepository {
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesRepository(
      String usuarioId, String contrasena);
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesFiltrosRepository(
      String usuarioId, String contrasena, String id, String nombre);
}
