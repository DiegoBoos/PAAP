part of 'upload_sync_bloc.dart';

class UploadProgressModel {
  final String title;
  final int counter;
  final int total;
  final double percent;

  UploadProgressModel(
      {required this.title,
      required this.counter,
      required this.percent,
      this.total = 18});

  UploadProgressModel copyWith(
          {String? title, int? counter, double? percent}) =>
      UploadProgressModel(
          title: title ?? this.title,
          counter: counter ?? this.counter,
          percent: percent ?? this.percent);
}

abstract class UploadSyncState extends Equatable {
  final UploadProgressModel? uploadProgressModel;
  const UploadSyncState({this.uploadProgressModel});

  @override
  List<Object?> get props => [uploadProgressModel];
}

class UploadSyncInitial extends UploadSyncState {
  UploadSyncInitial()
      : super(
            uploadProgressModel:
                UploadProgressModel(title: '', counter: 0, percent: 0.0));
}

class UploadSyncInProgress extends UploadSyncState {
  final UploadProgressModel progress;

  const UploadSyncInProgress(this.progress)
      : super(uploadProgressModel: progress);

  @override
  List<Object> get props => [progress];
}

class UploadSyncSuccess extends UploadSyncState {
  UploadSyncSuccess()
      : super(
            uploadProgressModel:
                UploadProgressModel(title: '', counter: 0, percent: 0.0));
}

class UploadSyncFailure extends UploadSyncState {
  final String message;

  const UploadSyncFailure(this.message);

  @override
  List<Object?> get props => [message];
}
