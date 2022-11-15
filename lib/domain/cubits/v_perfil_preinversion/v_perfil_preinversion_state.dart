part of 'v_perfil_preinversion_cubit.dart';

abstract class VPerfilPreInversionState extends Equatable {
  final VPerfilPreInversionEntity? vPerfilPreInversion;

  const VPerfilPreInversionState({this.vPerfilPreInversion});

  @override
  List<Object?> get props => [vPerfilPreInversion];
}

class VPerfilPreInversionInitial extends VPerfilPreInversionState {}

class VPerfilPreInversionSelected extends VPerfilPreInversionState {
  final VPerfilPreInversionEntity? vPerfilPreInversionSelected;

  const VPerfilPreInversionSelected(this.vPerfilPreInversionSelected)
      : super(vPerfilPreInversion: vPerfilPreInversionSelected);
}

class VPerfilPreInversionError extends VPerfilPreInversionState {
  final String message;

  const VPerfilPreInversionError(this.message);
  @override
  List<Object?> get props => [message];
}
