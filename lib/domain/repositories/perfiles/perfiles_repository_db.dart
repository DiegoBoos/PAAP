import 'package:dartz/dartz.dart';
import 'package:paap/domain/entities/perfil_entity.dart';

import '../../core/error/failure.dart';

abstract class PerfilesRepositoryDB {
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesRepositoryDB();
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesFiltrosRepositoryDB(
      String id, String nombre);
  Future<Either<Failure, int>> savePerfilesRepositoryDB(
      List<PerfilEntity> perfiles);
}
