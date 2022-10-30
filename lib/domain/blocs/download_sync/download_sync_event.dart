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
  final String title;
  final int counter;
  final double progress;

  const DownloadStatusChanged(
      {required this.title, required this.counter, required this.progress});

  @override
  List<Object> get props => [title, counter, progress];
}

class DownloadSyncCompleted extends DownloadSyncEvent {}

class DownloadSyncError extends DownloadSyncEvent {}

class MenuDownloaded extends DownloadSyncEvent {}

class ConvocatoriasDownloaded extends DownloadSyncEvent {}
