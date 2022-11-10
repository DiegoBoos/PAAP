import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_entity.dart';
import '../../entities/v_perfil_entity.dart';

abstract class PerfilesRepositoryDB {
  Future<Either<Failure, List<VPerfilEntity>>> getPerfilesRepositoryDB();
  Future<Either<Failure, List<VPerfilEntity>>> getPerfilesFiltrosRepositoryDB(
      String? id, String? nombre);
  Future<Either<Failure, int>> savePerfilesRepositoryDB(
      List<PerfilEntity> perfiles);
}
