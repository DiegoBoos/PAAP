part of 'desembolso_cubit.dart';

abstract class DesembolsoState extends Equatable {
  final List<DesembolsoEntity>? desembolsos;
  const DesembolsoState({this.desembolsos});

  @override
  List<Object?> get props => [desembolsos];
}

class DesembolsosInitial extends DesembolsoState {}

class DesembolsosLoading extends DesembolsoState {}

class DesembolsosLoaded extends DesembolsoState {
  final List<DesembolsoEntity>? desembolsosLoaded;

  const DesembolsosLoaded(this.desembolsosLoaded)
      : super(desembolsos: desembolsosLoaded);
}

class DesembolsosError extends DesembolsoState {
  final String message;

  const DesembolsosError(this.message);

  @override
  List<Object?> get props => [message];
}
