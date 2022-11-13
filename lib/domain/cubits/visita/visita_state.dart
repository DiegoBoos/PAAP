part of 'visita_cubit.dart';

abstract class VisitaState extends Equatable {
  final VisitaEntity? visitaDB;
  const VisitaState({this.visitaDB});

  @override
  List<Object?> get props => [visitaDB];
}

class VisitaInitial extends VisitaState {}

class VisitaLoading extends VisitaState {}

class VisitaLoaded extends VisitaState {
  final VisitaEntity visitaLoaded;

  const VisitaLoaded(this.visitaLoaded) : super(visitaDB: visitaLoaded);
}

class VisitaSaved extends VisitaState {}

class VisitaCleared extends VisitaState {}

class VisitaError extends VisitaState {
  final String message;

  const VisitaError(this.message);

  @override
  List<Object?> get props => [message];
}
