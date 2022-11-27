part of 'municipio_cubit.dart';

abstract class MunicipioState extends Equatable {
  final List<MunicipioEntity>? municipios;
  const MunicipioState({this.municipios});

  @override
  List<Object?> get props => [municipios];
}

class MunicipiosInitial extends MunicipioState {}

class MunicipiosLoading extends MunicipioState {}

class MunicipiosLoaded extends MunicipioState {
  final List<MunicipioEntity>? municipiosLoaded;

  const MunicipiosLoaded(this.municipiosLoaded)
      : super(municipios: municipiosLoaded);
}

class MunicipiosError extends MunicipioState {
  final String message;

  const MunicipiosError(this.message);

  @override
  List<Object?> get props => [message];
}
