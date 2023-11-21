part of 'sync_bloc.dart';

abstract class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object> get props => [];
}

class SyncStarted extends SyncEvent {
  final UsuarioEntity usuario;
  final String mode;

  const SyncStarted(this.usuario, this.mode);
}

class SyncStatusChanged extends SyncEvent {
  final SyncProgressModel progress;

  const SyncStatusChanged(this.progress);

  @override
  List<Object> get props => [progress];
}

class SyncError extends SyncEvent {
  final String message;

  const SyncError(this.message);
}

class SyncLog extends SyncEvent {
  final List<SyncLogEntity> syncLog;

  const SyncLog(this.syncLog);
}
