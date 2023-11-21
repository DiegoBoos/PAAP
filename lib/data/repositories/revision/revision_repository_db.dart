import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/revision_entity.dart';
import '../../../domain/repositories/revision/revision_repository_db.dart';
import '../../datasources/local/revision_local_ds.dart';

class RevisionRepositoryDBImpl implements RevisionRepositoryDB {
  final RevisionLocalDataSource revisionLocalDataSource;

  RevisionRepositoryDBImpl({required this.revisionLocalDataSource});

  @override
  Future<Either<Failure, List<RevisionEntity>>>
      getRevisionesRepositoryDB() async {
    try {
      final revisionesDB = await revisionLocalDataSource.getRevisionesDB();

      return Right(revisionesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveRevisionesRepositoryDB(
      List<RevisionEntity> revisionEntity) async {
    try {
      final revisionDB =
          await revisionLocalDataSource.saveRevisiones(revisionEntity);
      return Right(revisionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
