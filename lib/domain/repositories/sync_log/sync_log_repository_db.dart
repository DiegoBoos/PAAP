import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/sync_log_entity.dart';

abstract class SyncLogRepositoryDB {
  Future<Either<Failure, List<SyncLogEntity>>> getSyncLogsRepositoryDB();
  Future<Either<Failure, int>> forceSyncRepositoryDB(
      List<SyncLogEntity> syncLogsEntity);
}
