import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/unidad_entity.dart';
import '../../repositories/unidad/unidad_repository_db.dart';

class UnidadUsecaseDB {
  final UnidadRepositoryDB repositoryDB;

  UnidadUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<UnidadEntity>?>> getUnidadesUsecaseDB() {
    return repositoryDB.getUnidadesRepositoryDB();
  }

  Future<Either<Failure, int>> saveUnidadesUsecaseDB(
      List<UnidadEntity> unidadEntity) {
    return repositoryDB.saveUnidadesRepositoryDB(unidadEntity);
  }
}
