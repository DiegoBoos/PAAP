part of 'actividad_financiera_cubit.dart';

abstract class ActividadFinancieraState extends Equatable {
  final List<ActividadFinancieraEntity>? actividadFinanciera;
  const ActividadFinancieraState({this.actividadFinanciera});

  @override
  List<Object?> get props => [actividadFinanciera];
}

class ActividadFinancieraInitial extends ActividadFinancieraState {}

class ActividadFinancieraLoading extends ActividadFinancieraState {}

class ActividadFinancieraLoaded extends ActividadFinancieraState {
  final List<ActividadFinancieraEntity>? actividadFinancieraLoaded;

  const ActividadFinancieraLoaded(this.actividadFinancieraLoaded)
      : super(actividadFinanciera: actividadFinancieraLoaded);
}

class ActividadFinancieraError extends ActividadFinancieraState {
  final String message;

  const ActividadFinancieraError(this.message);

  @override
  List<Object?> get props => [message];
}
