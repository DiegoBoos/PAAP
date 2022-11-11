part of 'download_sync_bloc.dart';

class ProgressModel {
  final String title;
  final int counter;
  final int total;

  ProgressModel({required this.title, required this.counter, this.total = 43});

  ProgressModel copyWith({String? title, int? counter}) => ProgressModel(
      title: title ?? this.title, counter: counter ?? this.counter);
}

abstract class DownloadSyncState extends Equatable {
  final ProgressModel? progressModel;
  const DownloadSyncState({this.progressModel});

  @override
  List<Object?> get props => [progressModel];
}

class DownloadSyncInitial extends DownloadSyncState {
  DownloadSyncInitial()
      : super(progressModel: ProgressModel(title: '', counter: 0));
}

class DownloadSyncInProgress extends DownloadSyncState {
  final ProgressModel progress;

  const DownloadSyncInProgress(this.progress) : super(progressModel: progress);

  @override
  List<Object> get props => [progress];
}

class DownloadSyncSuccess extends DownloadSyncState {}

class DownloadSyncFailure extends DownloadSyncState {
  final String message;

  const DownloadSyncFailure(this.message);

  @override
  List<Object?> get props => [message];
}
