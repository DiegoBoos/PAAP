part of 'convocatoria_cubit.dart';

abstract class ConvocatoriaState extends Equatable {
  final List<ConvocatoriaEntity>? convocatorias;
  const ConvocatoriaState({this.convocatorias});

  @override
  List<Object?> get props => [convocatorias];
}

class ConvocatoriasInitial extends ConvocatoriaState {}

class ConvocatoriasLoading extends ConvocatoriaState {}

class ConvocatoriasLoaded extends ConvocatoriaState {
  final List<ConvocatoriaEntity>? convocatoriasLoaded;

  const ConvocatoriasLoaded(this.convocatoriasLoaded)
      : super(convocatorias: convocatoriasLoaded);
}

class ConvocatoriasError extends ConvocatoriaState {
  final String message;

  const ConvocatoriasError(this.message);

  @override
  List<Object?> get props => [message];
}
