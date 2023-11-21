import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/frecuencia_entity.dart';
import '../../repositories/frecuencia/frecuencia_repository_db.dart';

class FrecuenciaUsecaseDB {
  final FrecuenciaRepositoryDB repositoryDB;

  FrecuenciaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<FrecuenciaEntity>?>> getFrecuenciasUsecaseDB() {
    return repositoryDB.getFrecuenciasRepositoryDB();
  }

  Future<Either<Failure, int>> saveFrecuenciasUsecaseDB(
      List<FrecuenciaEntity> frecuenciaEntity) {
    return repositoryDB.saveFrecuenciasRepositoryDB(frecuenciaEntity);
  }
}
