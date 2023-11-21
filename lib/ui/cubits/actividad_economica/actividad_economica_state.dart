part of 'actividad_economica_cubit.dart';

abstract class ActividadEconomicaState extends Equatable {
  final List<ActividadEconomicaEntity>? actividadesEconomicas;
  const ActividadEconomicaState({this.actividadesEconomicas});

  @override
  List<Object?> get props => [actividadesEconomicas];
}

class ActividadesEconomicasInitial extends ActividadEconomicaState {}

class ActividadesEconomicasLoading extends ActividadEconomicaState {}

class ActividadesEconomicasLoaded extends ActividadEconomicaState {
  final List<ActividadEconomicaEntity>? actividadesEconomicasLoaded;

  const ActividadesEconomicasLoaded(this.actividadesEconomicasLoaded)
      : super(actividadesEconomicas: actividadesEconomicasLoaded);
}

class ActividadesEconomicasError extends ActividadEconomicaState {
  final String message;

  const ActividadesEconomicasError(this.message);

  @override
  List<Object?> get props => [message];
}
