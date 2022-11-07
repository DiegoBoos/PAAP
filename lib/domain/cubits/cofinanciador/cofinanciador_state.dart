part of 'cofinanciador_cubit.dart';

abstract class CofinanciadorState extends Equatable {
  final List<CofinanciadorEntity>? cofinanciador;
  const CofinanciadorState({this.cofinanciador});

  @override
  List<Object?> get props => [cofinanciador];
}

class CofinanciadorInitial extends CofinanciadorState {}

class CofinanciadorLoading extends CofinanciadorState {}

class CofinanciadorLoaded extends CofinanciadorState {
  final List<CofinanciadorEntity>? cofinanciadorLoaded;

  const CofinanciadorLoaded(this.cofinanciadorLoaded)
      : super(cofinanciador: cofinanciadorLoaded);
}

class CofinanciadorError extends CofinanciadorState {
  final String message;

  const CofinanciadorError(this.message);

  @override
  List<Object?> get props => [message];
}
