import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/sync_log_entity.dart';
import '../../../domain/repositories/sync_log/sync_log_repository_db.dart';
import '../../datasources/local/sync_log_local_ds.dart';

class SyncLogRepositoryDBImpl implements SyncLogRepositoryDB {
  final SyncLogLocalDataSource syncLogLocalDataSource;

  SyncLogRepositoryDBImpl({required this.syncLogLocalDataSource});

  @override
  Future<Either<Failure, List<SyncLogEntity>>> getSyncLogsRepositoryDB() async {
    try {
      final syncLogsDB = await syncLogLocalDataSource.getSyncLogsDB();

      return Right(syncLogsDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> forceSyncRepositoryDB(
      List<SyncLogEntity> syncLogEntity) async {
    try {
      final syncLogDB = await syncLogLocalDataSource.forceSyncDB(syncLogEntity);
      return Right(syncLogDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
