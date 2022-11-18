part of 'cofinanciador_cubit.dart';

abstract class CofinanciadorState extends Equatable {
  final List<CofinanciadorEntity>? cofinanciadores;
  const CofinanciadorState({this.cofinanciadores});

  @override
  List<Object?> get props => [cofinanciadores];
}

class CofinanciadoresInitial extends CofinanciadorState {}

class CofinanciadoresLoading extends CofinanciadorState {}

class CofinanciadoresLoaded extends CofinanciadorState {
  final List<CofinanciadorEntity>? cofinanciadoresLoaded;

  const CofinanciadoresLoaded(this.cofinanciadoresLoaded)
      : super(cofinanciadores: cofinanciadoresLoaded);
}

class CofinanciadorError extends CofinanciadorState {
  final String message;

  const CofinanciadorError(this.message);

  @override
  List<Object?> get props => [message];
}
