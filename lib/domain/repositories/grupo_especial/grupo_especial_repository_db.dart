import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/grupo_especial_entity.dart';

abstract class GrupoEspecialRepositoryDB {
  Future<Either<Failure, List<GrupoEspecialEntity>>>
      getGruposEspecialesRepositoryDB();

  Future<Either<Failure, int>> saveGruposEspecialesRepositoryDB(
      List<GrupoEspecialEntity> grupoEspecialEntity);
}
