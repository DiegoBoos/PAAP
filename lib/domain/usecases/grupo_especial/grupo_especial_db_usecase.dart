import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/grupo_especial_entity.dart';
import '../../repositories/grupo_especial/grupo_especial_repository_db.dart';

class GrupoEspecialUsecaseDB {
  final GrupoEspecialRepositoryDB repositoryDB;

  GrupoEspecialUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<GrupoEspecialEntity>?>>
      getGruposEspecialesUsecaseDB() {
    return repositoryDB.getGruposEspecialesRepositoryDB();
  }

  Future<Either<Failure, int>> saveGrupoEspecialUsecaseDB(
      List<GrupoEspecialEntity> grupoEspecialEntity) {
    return repositoryDB.saveGruposEspecialesRepositoryDB(grupoEspecialEntity);
  }
}
