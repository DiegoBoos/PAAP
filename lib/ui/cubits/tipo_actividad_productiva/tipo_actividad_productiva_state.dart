part of 'tipo_actividad_productiva_cubit.dart';

abstract class TipoActividadProductivaState extends Equatable {
  final List<TipoActividadProductivaEntity>? tiposActividadesProductivas;
  const TipoActividadProductivaState({this.tiposActividadesProductivas});

  @override
  List<Object?> get props => [tiposActividadesProductivas];
}

class TiposActividadesProductivasInitial extends TipoActividadProductivaState {}

class TiposActividadesProductivasLoading extends TipoActividadProductivaState {}

class TiposActividadesProductivasLoaded extends TipoActividadProductivaState {
  final List<TipoActividadProductivaEntity>? tiposActividadesProductivasLoaded;

  const TiposActividadesProductivasLoaded(
      this.tiposActividadesProductivasLoaded)
      : super(tiposActividadesProductivas: tiposActividadesProductivasLoaded);
}

class TiposActividadesProductivasError extends TipoActividadProductivaState {
  final String message;

  const TiposActividadesProductivasError(this.message);

  @override
  List<Object?> get props => [message];
}
