part of 'sitio_entrega_cubit.dart';

abstract class SitioEntregaState extends Equatable {
  final List<SitioEntregaEntity>? sitiosEntregas;
  const SitioEntregaState({this.sitiosEntregas});

  @override
  List<Object?> get props => [sitiosEntregas];
}

class SitiosEntregasInitial extends SitioEntregaState {}

class SitiosEntregasLoading extends SitioEntregaState {}

class SitiosEntregasLoaded extends SitioEntregaState {
  final List<SitioEntregaEntity>? sitiosEntregasLoaded;

  const SitiosEntregasLoaded(this.sitiosEntregasLoaded)
      : super(sitiosEntregas: sitiosEntregasLoaded);
}

class SitiosEntregasError extends SitioEntregaState {
  final String message;

  const SitiosEntregasError(this.message);

  @override
  List<Object?> get props => [message];
}
