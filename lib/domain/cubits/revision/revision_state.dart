part of 'revision_cubit.dart';

abstract class RevisionState extends Equatable {
  final List<RevisionEntity>? revisiones;
  const RevisionState({this.revisiones});

  @override
  List<Object?> get props => [revisiones];
}

class RevisionesInitial extends RevisionState {}

class RevisionesLoading extends RevisionState {}

class RevisionesLoaded extends RevisionState {
  final List<RevisionEntity>? revisionesLoaded;

  const RevisionesLoaded(this.revisionesLoaded)
      : super(revisiones: revisionesLoaded);
}

class RevisionesError extends RevisionState {
  final String message;

  const RevisionesError(this.message);

  @override
  List<Object?> get props => [message];
}
