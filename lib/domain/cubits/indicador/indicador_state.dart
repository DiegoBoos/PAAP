part of 'indicador_cubit.dart';

abstract class IndicadorState extends Equatable {
  final IndicadorEntity? indicador;
  const IndicadorState({this.indicador});

  @override
  List<Object?> get props => [indicador];
}

class IndicadorInitial extends IndicadorState {}

class IndicadorLoading extends IndicadorState {}

class IndicadorLoaded extends IndicadorState {
  final IndicadorEntity? indicadorLoaded;

  const IndicadorLoaded(this.indicadorLoaded)
      : super(indicador: indicadorLoaded);
}

class IndicadorError extends IndicadorState {
  final String message;

  const IndicadorError(this.message);

  @override
  List<Object?> get props => [message];
}
