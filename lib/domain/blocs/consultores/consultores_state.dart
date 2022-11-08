part of 'consultores_bloc.dart';

abstract class ConsultoresState extends Equatable {
  const ConsultoresState();

  @override
  List<Object> get props => [];
}

class ConsultoresInitial extends ConsultoresState {}

class ConsultoresLoading extends ConsultoresState {}

class ConsultoresLoaded extends ConsultoresState {
  final List<ConsultorEntity>? consultoresLoaded;

  const ConsultoresLoaded({this.consultoresLoaded});
}

class ConsultoresError extends ConsultoresState {
  final String message;

  const ConsultoresError(this.message);
}
