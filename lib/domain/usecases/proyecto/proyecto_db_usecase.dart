import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/proyecto_entity.dart';
import '../../repositories/proyecto/proyecto_repository_db.dart';

class ProyectoUsecaseDB {
  final ProyectoRepositoryDB repositoryDB;

  ProyectoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ProyectoEntity>?>> getProyectosUsecaseDB() {
    return repositoryDB.getProyectosRepositoryDB();
  }

  Future<Either<Failure, int>> saveProyectosUsecaseDB(
      List<ProyectoEntity> proyectoEntity) {
    return repositoryDB.saveProyectosRepositoryDB(proyectoEntity);
  }
}
