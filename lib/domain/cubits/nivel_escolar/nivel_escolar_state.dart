part of 'nivel_escolar_cubit.dart';

abstract class NivelEscolarState extends Equatable {
  final List<NivelEscolarEntity>? nivelEscolar;
  const NivelEscolarState({this.nivelEscolar});

  @override
  List<Object?> get props => [nivelEscolar];
}

class NivelEscolarInitial extends NivelEscolarState {}

class NivelEscolarLoading extends NivelEscolarState {}

class NivelEscolarLoaded extends NivelEscolarState {
  final List<NivelEscolarEntity>? nivelEscolarLoaded;

  const NivelEscolarLoaded(this.nivelEscolarLoaded)
      : super(nivelEscolar: nivelEscolarLoaded);
}

class NivelEscolarError extends NivelEscolarState {
  final String message;

  const NivelEscolarError(this.message);

  @override
  List<Object?> get props => [message];
}
