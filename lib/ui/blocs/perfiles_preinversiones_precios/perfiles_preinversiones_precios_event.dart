part of 'perfiles_preinversiones_precios_bloc.dart';

abstract class PerfilesPreInversionesPreciosEvent extends Equatable {
  const PerfilesPreInversionesPreciosEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilesPreInversionesPrecios
    extends PerfilesPreInversionesPreciosEvent {
  final String perfilPreInversionId;

  const GetPerfilesPreInversionesPrecios(this.perfilPreInversionId);
}
