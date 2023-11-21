part of 'perfiles_preinversion_bloc.dart';

abstract class PerfilesPreInversionState extends Equatable {
  const PerfilesPreInversionState();
  @override
  List<Object?> get props => [];
}

class PerfilesPreInversionInitial extends PerfilesPreInversionState {}

class PerfilesPreInversionLoading extends PerfilesPreInversionState {}

class PerfilesPreInversionLoaded extends PerfilesPreInversionState {
  final List<VPerfilPreInversionEntity>? perfilesPreInversionLoaded;

  const PerfilesPreInversionLoaded({this.perfilesPreInversionLoaded});
}

class PerfilesPreInversionError extends PerfilesPreInversionState {
  final String message;

  const PerfilesPreInversionError(this.message);
}
