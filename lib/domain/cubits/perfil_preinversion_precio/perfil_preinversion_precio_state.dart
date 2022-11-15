part of 'perfil_preinversion_precio_cubit.dart';

abstract class PerfilPreInversionPrecioState extends Equatable {
  final List<PerfilPreInversionPrecioEntity>? perfilPreInversionPrecios;

  const PerfilPreInversionPrecioState({this.perfilPreInversionPrecios});

  @override
  List<Object?> get props => [perfilPreInversionPrecios];
}

class PerfilPreInversionPreciosInitial extends PerfilPreInversionPrecioState {}

class PerfilPreInversionPreciosLoading extends PerfilPreInversionPrecioState {}

class PerfilPreInversionPreciosLoaded extends PerfilPreInversionPrecioState {
  final List<PerfilPreInversionPrecioEntity>? perfilPreInversionPreciosLoaded;

  const PerfilPreInversionPreciosLoaded(this.perfilPreInversionPreciosLoaded)
      : super(perfilPreInversionPrecios: perfilPreInversionPreciosLoaded);
}

class PerfilPreInversionPreciosError extends PerfilPreInversionPrecioState {
  final String message;

  const PerfilPreInversionPreciosError(this.message);
  @override
  List<Object?> get props => [message];
}
