part of 'actividad_financiera_cubit.dart';

abstract class ActividadFinancieraState extends Equatable {
  final List<ActividadFinancieraEntity>? actividadesFinancieras;
  const ActividadFinancieraState({this.actividadesFinancieras});

  @override
  List<Object?> get props => [actividadesFinancieras];
}

class ActividadFinancieraInitial extends ActividadFinancieraState {}

class ActividadFinancieraLoading extends ActividadFinancieraState {}

class ActividadFinancieraLoaded extends ActividadFinancieraState {
  final List<ActividadFinancieraEntity>? actividadesFinancierasLoaded;

  const ActividadFinancieraLoaded(this.actividadesFinancierasLoaded)
      : super(actividadesFinancieras: actividadesFinancierasLoaded);
}

class ActividadFinancieraError extends ActividadFinancieraState {
  final String message;

  const ActividadFinancieraError(this.message);

  @override
  List<Object?> get props => [message];
}
