part of 'sync_bloc.dart';

class SyncProgressModel {
  final String title;
  final String mode;
  final int counter;
  final int total;
  final double percent;

  SyncProgressModel(
      {required this.title,
      required this.mode,
      required this.counter,
      required this.percent,
      this.total = 64});

  SyncProgressModel copyWith(
          {String? title, String? mode, int? counter, double? percent}) =>
      SyncProgressModel(
          title: title ?? this.title,
          mode: mode ?? this.mode,
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
            syncProgressModel: SyncProgressModel(
                title: '', mode: '', counter: 0, percent: 0.0));
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
                title: '', mode: '', counter: 0, percent: 0.0));
}

class SyncFailure extends SyncState {
  final String message;

  SyncFailure(this.message)
      : super(
            syncProgressModel: SyncProgressModel(
                title: '', mode: '', counter: 0, percent: 0.0));

  @override
  List<Object?> get props => [message];
}
