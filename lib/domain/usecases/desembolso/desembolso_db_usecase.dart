import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/desembolso_entity.dart';
import '../../repositories/desembolso/desembolso_repository_db.dart';

class DesembolsoUsecaseDB {
  final DesembolsoRepositoryDB repositoryDB;

  DesembolsoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<DesembolsoEntity>?>> getDesembolsosUsecaseDB() {
    return repositoryDB.getDesembolsosRepositoryDB();
  }

  Future<Either<Failure, int>> saveDesembolsosUsecaseDB(
      List<DesembolsoEntity> desembolsoEntity) {
    return repositoryDB.saveDesembolsosRepositoryDB(desembolsoEntity);
  }
}
