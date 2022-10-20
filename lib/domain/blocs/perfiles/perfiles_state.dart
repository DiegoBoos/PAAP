part of 'perfiles_bloc.dart';

abstract class PerfilesState extends Equatable {
  final List<PerfilEntity>? perfiles;
  const PerfilesState({this.perfiles});

  @override
  List<Object?> get props => [perfiles];
}

class PerfilesInitial extends PerfilesState {}

class PerfilesLoading extends PerfilesState {}

class PerfilesLoaded extends PerfilesState {
  final List<PerfilEntity>? perfilesLoaded;

  const PerfilesLoaded(this.perfilesLoaded)
      : super(
          perfiles: perfilesLoaded,
        );

  @override
  List<Object?> get props => [perfiles];
}

class PerfilesError extends PerfilesState {
  final String message;

  const PerfilesError(this.message);

  @override
  List<Object?> get props => [message];
}
