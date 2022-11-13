part of 'aliado_preinversion_cubit.dart';

abstract class AliadoPreinversionState extends Equatable {
  final AliadoPreinversionEntity? aliadoPreinversion;
  const AliadoPreinversionState({this.aliadoPreinversion});

  @override
  List<Object?> get props => [aliadoPreinversion];
}

class AliadoPreinversionInitial extends AliadoPreinversionState {}

class AliadoPreinversionLoading extends AliadoPreinversionState {}

class AliadoPreinversionLoaded extends AliadoPreinversionState {
  final AliadoPreinversionEntity? aliadoPreinversionLoaded;

  const AliadoPreinversionLoaded(this.aliadoPreinversionLoaded)
      : super(aliadoPreinversion: aliadoPreinversionLoaded);
}

class AliadoPreinversionError extends AliadoPreinversionState {
  final String message;

  const AliadoPreinversionError(this.message);

  @override
  List<Object?> get props => [message];
}
