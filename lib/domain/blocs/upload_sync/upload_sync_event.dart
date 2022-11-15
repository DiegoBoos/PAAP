part of 'upload_sync_bloc.dart';

abstract class UploadSyncEvent extends Equatable {
  const UploadSyncEvent();

  @override
  List<Object> get props => [];
}

class UploadStarted extends UploadSyncEvent {
  final UsuarioEntity usuario;

  const UploadStarted(this.usuario);
}

class UploadStatusChanged extends UploadSyncEvent {
  final UploadProgressModel progress;

  const UploadStatusChanged(this.progress);

  @override
  List<Object> get props => [progress];
}

class UploadSyncError extends UploadSyncEvent {
  final String message;

  const UploadSyncError(this.message);
}
