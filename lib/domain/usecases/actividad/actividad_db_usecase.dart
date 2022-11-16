import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/actividad_entity.dart';
import '../../repositories/actividad/actividad_repository_db.dart';

class ActividadUsecaseDB {
  final ActividadRepositoryDB repositoryDB;

  ActividadUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ActividadEntity>?>> getActividadesUsecaseDB() {
    return repositoryDB.getActividadesRepositoryDB();
  }

  Future<Either<Failure, ActividadEntity?>> getActividadUsecaseDB(String id) {
    return repositoryDB.getActividadRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveActividadesUsecaseDB(
      List<ActividadEntity> actividadEntity) {
    return repositoryDB.saveActividadesRepositoryDB(actividadEntity);
  }
}
