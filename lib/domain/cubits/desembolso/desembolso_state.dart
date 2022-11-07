part of 'desembolso_cubit.dart';

abstract class DesembolsoState extends Equatable {
  final List<DesembolsoEntity>? desembolso;
  const DesembolsoState({this.desembolso});

  @override
  List<Object?> get props => [desembolso];
}

class DesembolsoInitial extends DesembolsoState {}

class DesembolsoLoading extends DesembolsoState {}

class DesembolsoLoaded extends DesembolsoState {
  final List<DesembolsoEntity>? desembolsoLoaded;

  const DesembolsoLoaded(this.desembolsoLoaded)
      : super(desembolso: desembolsoLoaded);
}

class DesembolsoError extends DesembolsoState {
  final String message;

  const DesembolsoError(this.message);

  @override
  List<Object?> get props => [message];
}
