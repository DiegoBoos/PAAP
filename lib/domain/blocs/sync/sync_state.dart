part of 'sync_bloc.dart';

class SyncProgressModel {
  final String title;
  final int counter;
  final int total;
  final double percent;

  SyncProgressModel(
      {required this.title,
      this.total = 0,
      required this.counter,
      required this.percent});

  SyncProgressModel copyWith(
          {String? title,
          String? mode,
          int? counter,
          int? total,
          double? percent}) =>
      SyncProgressModel(
          title: title ?? this.title,
          total: total ?? this.total,
          counter: counter ?? this.counter,
          percent: percent ?? this.percent);
}

abstract class SyncState extends Equatable {
  final SyncProgressModel? syncProgressModel;
  const SyncState({this.syncProgressModel});

  @override
  List<Object?> get props => [syncProgressModel];
}

class SyncInitial extends SyncState {
  SyncInitial()
      : super(
            syncProgressModel:
                SyncProgressModel(title: '', counter: 0, percent: 0.0));
}

class SyncInProgress extends SyncState {
  final SyncProgressModel progress;

  const SyncInProgress(this.progress) : super(syncProgressModel: progress);

  @override
  List<Object?> get props => [progress];
}

class SyncSuccess extends SyncState {
  SyncSuccess()
      : super(
            syncProgressModel: SyncProgressModel(
                title: '', counter: 0, total: 6, percent: 0.0));
}

class SyncFailure extends SyncState {
  final String message;

  SyncFailure(this.message)
      : super(
            syncProgressModel:
                SyncProgressModel(title: '', counter: 0, percent: 0.0));

  @override
  List<Object?> get props => [message];
}

class IncompleteSync extends SyncState {
  final List<SyncLogEntity> syncLog;

  IncompleteSync(this.syncLog)
      : super(
            syncProgressModel:
                SyncProgressModel(title: '', counter: 0, percent: 0.0));

  @override
  List<Object?> get props => [syncLog];
}
