part of 'sync_log_cubit.dart';

abstract class SyncLogState extends Equatable {
  final List<SyncLogEntity>? syncLogs;
  const SyncLogState({this.syncLogs});

  @override
  List<Object?> get props => [syncLogs];
}

class SyncLogsInitial extends SyncLogState {}

class SyncLogsLoading extends SyncLogState {}

class SyncLogsLoaded extends SyncLogState {
  final List<SyncLogEntity>? syncLogsLoaded;

  const SyncLogsLoaded(this.syncLogsLoaded) : super(syncLogs: syncLogsLoaded);
}

class SyncLogsError extends SyncLogState {
  final String message;

  const SyncLogsError(this.message);

  @override
  List<Object?> get props => [message];
}
