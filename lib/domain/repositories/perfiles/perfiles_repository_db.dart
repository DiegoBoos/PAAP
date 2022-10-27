import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_entity.dart';

abstract class PerfilesRepositoryDB {
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesRepositoryDB();
  Future<Either<Failure, List<PerfilEntity>>> getPerfilesFiltrosRepositoryDB(
      String? id, String? nombre);
  Future<Either<Failure, int>> savePerfilesRepositoryDB(
      List<PerfilEntity> perfiles);
  Future<Either<Failure, PerfilEntity?>> getPerfilRepositoryDB(String id);
}
