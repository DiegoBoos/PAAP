part of 'municipio_cubit.dart';

abstract class MunicipioState extends Equatable {
  final List<MunicipioEntity>? municipio;
  const MunicipioState({this.municipio});

  @override
  List<Object?> get props => [municipio];
}

class MunicipioInitial extends MunicipioState {}

class MunicipioLoading extends MunicipioState {}

class MunicipioLoaded extends MunicipioState {
  final List<MunicipioEntity>? municipioLoaded;

  const MunicipioLoaded(this.municipioLoaded)
      : super(municipio: municipioLoaded);
}

class MunicipioError extends MunicipioState {
  final String message;

  const MunicipioError(this.message);

  @override
  List<Object?> get props => [message];
}
