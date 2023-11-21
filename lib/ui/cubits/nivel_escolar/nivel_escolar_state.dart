part of 'nivel_escolar_cubit.dart';

abstract class NivelEscolarState extends Equatable {
  final List<NivelEscolarEntity>? nivelesEscolares;
  const NivelEscolarState({this.nivelesEscolares});

  @override
  List<Object?> get props => [nivelesEscolares];
}

class NivelesEscolaresInitial extends NivelEscolarState {}

class NivelesEscolaresLoading extends NivelEscolarState {}

class NivelesEscolaresLoaded extends NivelEscolarState {
  final List<NivelEscolarEntity>? nivelesEscolaresLoaded;

  const NivelesEscolaresLoaded(this.nivelesEscolaresLoaded)
      : super(nivelesEscolares: nivelesEscolaresLoaded);
}

class NivelesEscolaresError extends NivelEscolarState {
  final String message;

  const NivelesEscolaresError(this.message);

  @override
  List<Object?> get props => [message];
}
