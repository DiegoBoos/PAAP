import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/revision_entity.dart';

abstract class RevisionRepositoryDB {
  Future<Either<Failure, List<RevisionEntity>>> getRevisionesRepositoryDB();

  Future<Either<Failure, int>> saveRevisionesRepositoryDB(
      List<RevisionEntity> revisionEntity);
}
