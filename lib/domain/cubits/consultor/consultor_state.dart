part of 'consultor_cubit.dart';

abstract class ConsultorState extends Equatable {
  final List<ConsultorEntity>? consultores;
  const ConsultorState({this.consultores});

  @override
  List<Object?> get props => [consultores];
}

class ConsultoresInitial extends ConsultorState {}

class ConsultoresLoading extends ConsultorState {}

class ConsultoresLoaded extends ConsultorState {
  final List<ConsultorEntity>? consultoresLoaded;

  const ConsultoresLoaded(this.consultoresLoaded)
      : super(consultores: consultoresLoaded);
}

class ConsultoresError extends ConsultorState {
  final String message;

  const ConsultoresError(this.message);

  @override
  List<Object?> get props => [message];
}
