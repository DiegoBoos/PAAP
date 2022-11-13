part of 'perfiles_preinversion_bloc.dart';

abstract class PerfilesPreinversionState extends Equatable {
  const PerfilesPreinversionState();
  @override
  List<Object?> get props => [];
}

class PerfilesPreinversionInitial extends PerfilesPreinversionState {}

class PerfilesPreinversionLoading extends PerfilesPreinversionState {}

class PerfilesPreinversionLoaded extends PerfilesPreinversionState {
  final List<VPerfilPreinversionEntity>? perfilesPreinversionLoaded;

  const PerfilesPreinversionLoaded({this.perfilesPreinversionLoaded});
}

class PerfilesPreinversionError extends PerfilesPreinversionState {
  final String message;

  const PerfilesPreinversionError(this.message);
}
