import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/residencia_entity.dart';
import '../../repositories/residencia/residencia_repository_db.dart';

class ResidenciaUsecaseDB {
  final ResidenciaRepositoryDB repositoryDB;

  ResidenciaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ResidenciaEntity>?>> getResidenciasUsecaseDB() {
    return repositoryDB.getResidenciasRepositoryDB();
  }

  Future<Either<Failure, int>> saveResidenciasUsecaseDB(
      List<ResidenciaEntity> residenciaEntity) {
    return repositoryDB.saveResidenciaRepositoryDB(residenciaEntity);
  }
}
