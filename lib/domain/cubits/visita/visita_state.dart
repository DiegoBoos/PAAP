part of 'visita_cubit.dart';

abstract class VisitaState extends Equatable {
  const VisitaState();

  @override
  List<Object?> get props => [];
}

class VisitaInitial extends VisitaState {}

class VisitaLoading extends VisitaState {}

class VisitaSaved extends VisitaState {}

class VisitaCleared extends VisitaState {}

class VisitaError extends VisitaState {
  final String message;

  const VisitaError(this.message);

  @override
  List<Object?> get props => [message];
}
