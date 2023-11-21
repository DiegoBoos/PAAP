import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/revision_entity.dart';
import '../../repositories/revision/revision_repository_db.dart';

class RevisionUsecaseDB {
  final RevisionRepositoryDB repositoryDB;

  RevisionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<RevisionEntity>?>> getRevisionesUsecaseDB() {
    return repositoryDB.getRevisionesRepositoryDB();
  }

  Future<Either<Failure, int>> saveRevisionesUsecaseDB(
      List<RevisionEntity> revisionEntity) {
    return repositoryDB.saveRevisionesRepositoryDB(revisionEntity);
  }
}
