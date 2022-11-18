part of 'actividad_financiera_cubit.dart';

abstract class ActividadFinancieraState extends Equatable {
  final List<ActividadFinancieraEntity>? actividadesFinancieras;
  const ActividadFinancieraState({this.actividadesFinancieras});

  @override
  List<Object?> get props => [actividadesFinancieras];
}

class ActividadesFinancierasInitial extends ActividadFinancieraState {}

class ActividadesFinancierasLoading extends ActividadFinancieraState {}

class ActividadesFinancierasLoaded extends ActividadFinancieraState {
  final List<ActividadFinancieraEntity>? actividadesFinancierasLoaded;

  const ActividadesFinancierasLoaded(this.actividadesFinancierasLoaded)
      : super(actividadesFinancieras: actividadesFinancierasLoaded);
}

class ActividadFinancieraError extends ActividadFinancieraState {
  final String message;

  const ActividadFinancieraError(this.message);

  @override
  List<Object?> get props => [message];
}
