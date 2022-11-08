part of 'perfiles_bloc.dart';

abstract class PerfilesState extends Equatable {
  const PerfilesState();
  @override
  List<Object?> get props => [];
}

class PerfilesInitial extends PerfilesState {}

class PerfilesLoading extends PerfilesState {}

class PerfilesLoaded extends PerfilesState {
  final List<PerfilEntity>? perfilesLoaded;

  const PerfilesLoaded({this.perfilesLoaded});
}

class PerfilesError extends PerfilesState {
  final String message;

  const PerfilesError(this.message);
}
