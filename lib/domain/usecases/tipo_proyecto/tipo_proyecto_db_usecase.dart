import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/tipo_proyecto_entity.dart';
import '../../repositories/tipo_proyecto/tipo_proyecto_repository_db.dart';

class TipoProyectoUsecaseDB {
  final TipoProyectoRepositoryDB repositoryDB;

  TipoProyectoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<TipoProyectoEntity>?>>
      getTiposProyectosUsecaseDB() {
    return repositoryDB.getTiposProyectosRepositoryDB();
  }

  Future<Either<Failure, int>> saveTiposProyectosUsecaseDB(
      List<TipoProyectoEntity> tipoproyectoEntity) {
    return repositoryDB.saveTiposProyectosRepositoryDB(tipoproyectoEntity);
  }
}
