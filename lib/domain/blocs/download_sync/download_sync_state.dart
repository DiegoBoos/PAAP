part of 'download_sync_bloc.dart';

class DownloadProgressModel {
  final String title;
  final int counter;
  final int total;
  final double percent;

  DownloadProgressModel(
      {required this.title,
      required this.counter,
      required this.percent,
      this.total = 64});

  DownloadProgressModel copyWith(
          {String? title, int? counter, double? percent}) =>
      DownloadProgressModel(
          title: title ?? this.title,
          counter: counter ?? this.counter,
          percent: percent ?? this.percent);
}

abstract class DownloadSyncState extends Equatable {
  final DownloadProgressModel? downloadProgressModel;
  const DownloadSyncState({this.downloadProgressModel});

  @override
  List<Object?> get props => [downloadProgressModel];
}

class DownloadSyncInitial extends DownloadSyncState {
  DownloadSyncInitial()
      : super(
            downloadProgressModel:
                DownloadProgressModel(title: '', counter: 0, percent: 0.0));
}

class DownloadSyncInProgress extends DownloadSyncState {
  final DownloadProgressModel progress;

  const DownloadSyncInProgress(this.progress)
      : super(downloadProgressModel: progress);

  @override
  List<Object?> get props => [progress];
}

class DownloadSyncSuccess extends DownloadSyncState {
  DownloadSyncSuccess()
      : super(
            downloadProgressModel:
                DownloadProgressModel(title: '', counter: 0, percent: 0.0));
}

class DownloadSyncFailure extends DownloadSyncState {
  final String message;

  DownloadSyncFailure(this.message)
      : super(
            downloadProgressModel:
                DownloadProgressModel(title: '', counter: 0, percent: 0.0));

  @override
  List<Object?> get props => [message];
}
