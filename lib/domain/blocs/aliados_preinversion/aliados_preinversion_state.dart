part of 'aliados_preinversion_bloc.dart';

abstract class AliadosPreinversionState extends Equatable {
  const AliadosPreinversionState();

  @override
  List<Object> get props => [];
}

class AliadosPreinversionInitial extends AliadosPreinversionState {}

class AliadosPreinversionLoading extends AliadosPreinversionState {}

class AliadosPreinversionLoaded extends AliadosPreinversionState {
  final List<AliadoPreinversionEntity>? aliadosPreinversionLoaded;

  const AliadosPreinversionLoaded({this.aliadosPreinversionLoaded});
}

class AliadosPreinversionError extends AliadosPreinversionState {
  final String message;

  const AliadosPreinversionError(this.message);
}
