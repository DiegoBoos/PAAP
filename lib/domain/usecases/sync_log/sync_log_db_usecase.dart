import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/sync_log_entity.dart';
import '../../repositories/sync_log/sync_log_repository_db.dart';

class SyncLogUsecaseDB {
  final SyncLogRepositoryDB repositoryDB;

  SyncLogUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<SyncLogEntity>?>> getSyncLogsUsecaseDB() {
    return repositoryDB.getSyncLogsRepositoryDB();
  }

  Future<Either<Failure, int>> forceSyncUsecaseDB(
      List<SyncLogEntity> syncLogsEntity) {
    return repositoryDB.forceSyncRepositoryDB(syncLogsEntity);
  }
}
