part of 'genero_cubit.dart';

abstract class GeneroState extends Equatable {
  final List<GeneroEntity>? generos;
  const GeneroState({this.generos});

  @override
  List<Object?> get props => [generos];
}

class GenerosInitial extends GeneroState {}

class GenerosLoading extends GeneroState {}

class GenerosLoaded extends GeneroState {
  final List<GeneroEntity>? generosLoaded;

  const GenerosLoaded(this.generosLoaded) : super(generos: generosLoaded);
}

class GenerosError extends GeneroState {
  final String message;

  const GenerosError(this.message);

  @override
  List<Object?> get props => [message];
}
