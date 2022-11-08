part of 'consultor_cubit.dart';

abstract class ConsultorState extends Equatable {
  final ConsultorEntity? consultor;
  const ConsultorState({this.consultor});

  @override
  List<Object?> get props => [consultor];
}

class ConsultorInitial extends ConsultorState {}

class ConsultorLoading extends ConsultorState {}

class ConsultorLoaded extends ConsultorState {
  final ConsultorEntity? consultorLoaded;

  const ConsultorLoaded(this.consultorLoaded)
      : super(consultor: consultorLoaded);
}

class ConsultorError extends ConsultorState {
  final String message;

  const ConsultorError(this.message);

  @override
  List<Object?> get props => [message];
}
