part of 'cofinanciadores_bloc.dart';

abstract class CofinanciadoresState extends Equatable {
  const CofinanciadoresState();

  @override
  List<Object> get props => [];
}

class CofinanciadoresInitial extends CofinanciadoresState {}

class CofinanciadoresLoading extends CofinanciadoresState {}

class CofinanciadoresLoaded extends CofinanciadoresState {
  final List<CofinanciadorEntity>? cofinanciadoresLoaded;

  const CofinanciadoresLoaded({this.cofinanciadoresLoaded});
}

class CofinanciadoresError extends CofinanciadoresState {
  final String message;

  const CofinanciadoresError(this.message);
}
