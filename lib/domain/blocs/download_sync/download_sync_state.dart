part of 'download_sync_bloc.dart';

abstract class DownloadSyncState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DownloadSyncInitial extends DownloadSyncState {}

class DownloadSyncInProgress extends DownloadSyncState {
  final String title;
  final int counter;
  final double progress;

  DownloadSyncInProgress(
      {this.title = '', this.counter = 0, this.progress = 0});

  @override
  List<Object> get props => [progress];
}

class DownloadSyncSuccess extends DownloadSyncState {}

class DownloadSyncFailure extends DownloadSyncState {
  final String message;

  DownloadSyncFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class MenuDownloadSyncSuccess extends DownloadSyncState {}

class ConvocatoriasDownloadSyncSuccess extends DownloadSyncState {}
