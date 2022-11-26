part of 'perfil_preinversion_precio_cubit.dart';

abstract class PerfilPreInversionPrecioState extends Equatable {
  final PerfilPreInversionPrecioEntity perfilPreInversionPrecio;

  const PerfilPreInversionPrecioState({required this.perfilPreInversionPrecio});

  @override
  List<Object?> get props => [perfilPreInversionPrecio];
}

class PerfilPreInversionPrecioInitial extends PerfilPreInversionPrecioState {
  PerfilPreInversionPrecioInitial()
      : super(perfilPreInversionPrecio: initObject());
}

class PerfilPreInversionPrecioLoading extends PerfilPreInversionPrecioState {
  const PerfilPreInversionPrecioLoading(
      {required super.perfilPreInversionPrecio});
}

class PerfilPreInversionPrecioChanged extends PerfilPreInversionPrecioState {
  final PerfilPreInversionPrecioEntity perfilPreInversionPrecioChanged;

  const PerfilPreInversionPrecioChanged(this.perfilPreInversionPrecioChanged)
      : super(perfilPreInversionPrecio: perfilPreInversionPrecioChanged);
}

class PerfilPreInversionPrecioSaved extends PerfilPreInversionPrecioState {
  PerfilPreInversionPrecioSaved()
      : super(perfilPreInversionPrecio: initObject());
}

class PerfilPreInversionPrecioError extends PerfilPreInversionPrecioState {
  final String message;

  PerfilPreInversionPrecioError(this.message)
      : super(perfilPreInversionPrecio: initObject());
  @override
  List<Object?> get props => [message];
}

PerfilPreInversionPrecioEntity initObject() => PerfilPreInversionPrecioEntity(
    perfilPreInversionId: '',
    productoId: '',
    tipoCalidadId: '',
    precio: '',
    unidadId: '',
    recordStatus: '');
