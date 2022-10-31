part of 'genero_cubit.dart';

abstract class GeneroState extends Equatable {
  final List<GeneroEntity>? genero;
  const GeneroState({this.genero});

  @override
  List<Object?> get props => [genero];
}

class GeneroInitial extends GeneroState {}

class GeneroLoading extends GeneroState {}

class GeneroLoaded extends GeneroState {
  final List<GeneroEntity>? generoLoaded;

  const GeneroLoaded(this.generoLoaded) : super(genero: generoLoaded);
}

class GeneroError extends GeneroState {
  final String message;

  const GeneroError(this.message);

  @override
  List<Object?> get props => [message];
}
