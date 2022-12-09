part of 'sync_bloc.dart';

abstract class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object> get props => [];
}

class SyncStarted extends SyncEvent {}

class SyncError extends SyncEvent {
  final String message;

  const SyncError(this.message);
}
