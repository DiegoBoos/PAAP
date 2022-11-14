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

class UploadSyncError extends UploadSyncEvent {
  final String message;

  const UploadSyncError(this.message);
}
