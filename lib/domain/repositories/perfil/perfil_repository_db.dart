import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_entity.dart';
import '../../entities/v_perfil_entity.dart';

abstract class PerfilRepositoryDB {
  Future<Either<Failure, List<VPerfilEntity>>> getPerfilesRepositoryDB();
  Future<Either<Failure, List<VPerfilEntity>>> getPerfilesFiltrosRepositoryDB(
      String? id, String? nombre);
  Future<Either<Failure, int>> savePerfilesRepositoryDB(
      List<PerfilEntity> perfiles);
  Future<Either<Failure, List<String>>> getMunicipiosPerfilesRepositoryDB();
}
