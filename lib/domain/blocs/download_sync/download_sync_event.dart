part of 'download_sync_bloc.dart';

abstract class DownloadSyncEvent extends Equatable {
  const DownloadSyncEvent();

  @override
  List<Object> get props => [];
}

class DownloadStarted extends DownloadSyncEvent {
  final UsuarioEntity usuario;

  const DownloadStarted(this.usuario);
}

class DownloadStatusChanged extends DownloadSyncEvent {
  final DownloadProgressModel progress;

  const DownloadStatusChanged(this.progress);

  @override
  List<Object> get props => [progress];
}

class DownloadSyncError extends DownloadSyncEvent {
  final String message;

  const DownloadSyncError(this.message);
}
