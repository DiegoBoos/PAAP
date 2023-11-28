part of 'visita_cubit.dart';

abstract class VisitaState extends Equatable {
  final VisitaEntity? visita;
  const VisitaState({required this.visita});

  @override
  List<Object?> get props => [visita];
}

class VisitaInitial extends VisitaState {
  const VisitaInitial() : super(visita: null);
}

class VisitaLoading extends VisitaState {
  const VisitaLoading() : super(visita: null);
}

class VisitaLoaded extends VisitaState {
  final VisitaEntity visitaLoaded;

  const VisitaLoaded(this.visitaLoaded) : super(visita: visitaLoaded);
}

class VisitaSaved extends VisitaState {
  const VisitaSaved() : super(visita: null);
}

class VisitaCleared extends VisitaState {
  const VisitaCleared() : super(visita: null);
}

class VisitaError extends VisitaState {
  final String message;

  const VisitaError(this.message) : super(visita: null);

  @override
  List<Object?> get props => [message];
}
