part of 'upload_sync_bloc.dart';

class ProgressModel {
  final String title;
  final int counter;
  final int total;

  ProgressModel({required this.title, required this.counter, this.total = 43});

  ProgressModel copyWith({String? title, int? counter}) => ProgressModel(
      title: title ?? this.title, counter: counter ?? this.counter);
}

abstract class UploadSyncState extends Equatable {
  final ProgressModel? progressModel;
  const UploadSyncState({this.progressModel});

  @override
  List<Object?> get props => [progressModel];
}

class UploadSyncInitial extends UploadSyncState {
  UploadSyncInitial()
      : super(progressModel: ProgressModel(title: '', counter: 0));
}

class UploadSyncInProgress extends UploadSyncState {
  final ProgressModel progress;

  const UploadSyncInProgress(this.progress) : super(progressModel: progress);

  @override
  List<Object> get props => [progress];
}

class UploadSyncSuccess extends UploadSyncState {}

class UploadSyncFailure extends UploadSyncState {
  final String message;

  const UploadSyncFailure(this.message);

  @override
  List<Object?> get props => [message];
}
