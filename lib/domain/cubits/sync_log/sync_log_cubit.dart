import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../entities/sync_log_entity.dart';
import '../../usecases/sync_log/sync_log_db_usecase.dart';

part '../sync_log/sync_log_state.dart';

class SyncLogCubit extends Cubit<SyncLogState> {
  final SyncLogUsecaseDB syncLogDB;

  SyncLogCubit({required this.syncLogDB}) : super(SyncLogsInitial()) {
    getSyncLogsDB();
  }

  void getSyncLogsDB() async {
    final result = await syncLogDB.getSyncLogsUsecaseDB();
    result.fold((failure) => emit(SyncLogsError(failure.properties.first)),
        (data) => emit(SyncLogsLoaded(data)));
  }

  Future<int> forceSyncDB(List<SyncLogEntity> syncLogsEntity) async {
    final result = await syncLogDB.forceSyncUsecaseDB(syncLogsEntity);
    return result.fold(
        (failure) => throw ErrorDescription(failure.properties.first),
        (data) => data);
  }
}
