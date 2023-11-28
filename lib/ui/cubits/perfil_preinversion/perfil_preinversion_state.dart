part of 'perfil_preinversion_cubit.dart';

abstract class PerfilPreInversionState extends Equatable {
  final PerfilPreInversionEntity perfilPreInversion;
  const PerfilPreInversionState({required this.perfilPreInversion});

  @override
  List<Object?> get props => [perfilPreInversion];
}

class PerfilPreInversionInitial extends PerfilPreInversionState {
  PerfilPreInversionInitial()
      : super(perfilPreInversion: PerfilPreInversionEntity());
}

class PerfilPreInversionLoaded extends PerfilPreInversionState {
  final PerfilPreInversionEntity perfilPreInversionLoaded;

  const PerfilPreInversionLoaded(this.perfilPreInversionLoaded)
      : super(perfilPreInversion: perfilPreInversionLoaded);
}

class PerfilPreInversionError extends PerfilPreInversionState {
  final String message;

  PerfilPreInversionError(this.message)
      : super(perfilPreInversion: PerfilPreInversionEntity());

  @override
  List<Object?> get props => [message];
}
