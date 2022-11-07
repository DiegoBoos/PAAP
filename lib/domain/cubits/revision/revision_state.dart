part of 'revision_cubit.dart';

abstract class RevisionState extends Equatable {
  final List<RevisionEntity>? revision;
  const RevisionState({this.revision});

  @override
  List<Object?> get props => [revision];
}

class RevisionInitial extends RevisionState {}

class RevisionLoading extends RevisionState {}

class RevisionLoaded extends RevisionState {
  final List<RevisionEntity>? revisionLoaded;

  const RevisionLoaded(this.revisionLoaded) : super(revision: revisionLoaded);
}

class RevisionError extends RevisionState {
  final String message;

  const RevisionError(this.message);

  @override
  List<Object?> get props => [message];
}
