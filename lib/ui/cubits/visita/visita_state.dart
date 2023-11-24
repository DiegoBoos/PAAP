part of 'visita_cubit.dart';

abstract class VisitaState extends Equatable {
  final VisitaEntity visita;
  const VisitaState({required this.visita});

  @override
  List<Object?> get props => [visita];
}

class VisitaInitial extends VisitaState {
  VisitaInitial() : super(visita: initObject());
}

class VisitaLoading extends VisitaState {
  VisitaLoading() : super(visita: initObject());
}

class VisitaLoaded extends VisitaState {
  final VisitaEntity visitaLoaded;

  const VisitaLoaded(this.visitaLoaded) : super(visita: visitaLoaded);
}

class VisitaSaved extends VisitaState {
  VisitaSaved() : super(visita: initObject());
}

class VisitaCleared extends VisitaState {
  VisitaCleared() : super(visita: initObject());
}

class VisitaError extends VisitaState {
  final String message;

  VisitaError(this.message) : super(visita: initObject());

  @override
  List<Object?> get props => [message];
}

VisitaEntity initObject() => VisitaEntity();
