import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/objetivo_entity.dart';
import '../../repositories/objetivo/objetivo_repository_db.dart';

class ObjetivoUsecaseDB {
  final ObjetivoRepositoryDB repositoryDB;

  ObjetivoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<ObjetivoEntity>?>> getObjetivosUsecaseDB() {
    return repositoryDB.getObjetivosRepositoryDB();
  }

  Future<Either<Failure, int>> saveObjetivosUsecaseDB(
      List<ObjetivoEntity> objetivoEntity) {
    return repositoryDB.saveObjetivosRepositoryDB(objetivoEntity);
  }
}
