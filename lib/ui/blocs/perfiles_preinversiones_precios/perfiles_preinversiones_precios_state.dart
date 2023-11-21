part of 'perfiles_preinversiones_precios_bloc.dart';

abstract class PerfilesPreInversionesPreciosState extends Equatable {
  final List<PerfilPreInversionPrecioEntity>? perfilesPreInversionesPrecios;

  const PerfilesPreInversionesPreciosState(
      {this.perfilesPreInversionesPrecios});

  @override
  List<Object?> get props => [PerfilesPreInversionesPreciosState];
}

class PerfilesPreInversionesPreciosInitial
    extends PerfilesPreInversionesPreciosState {}

class PerfilesPreInversionesPreciosLoading
    extends PerfilesPreInversionesPreciosState {}

class PerfilesPreInversionesPreciosLoaded
    extends PerfilesPreInversionesPreciosState {
  final List<PerfilPreInversionPrecioEntity>?
      perfilesPreInversionesPreciosLoaded;

  const PerfilesPreInversionesPreciosLoaded(
      this.perfilesPreInversionesPreciosLoaded)
      : super(
            perfilesPreInversionesPrecios: perfilesPreInversionesPreciosLoaded);
}

class PerfilesPreInversionesPreciosSaved
    extends PerfilesPreInversionesPreciosState {}

class PerfilesPreInversionesPreciosError
    extends PerfilesPreInversionesPreciosState {
  final String message;

  const PerfilesPreInversionesPreciosError(this.message);
  @override
  List<Object?> get props => [message];
}
