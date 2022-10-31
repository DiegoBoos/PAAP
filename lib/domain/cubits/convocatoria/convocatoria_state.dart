part of 'convocatoria_cubit.dart';

abstract class ConvocatoriaState extends Equatable {
  final List<ConvocatoriaEntity>? convocatoria;
  const ConvocatoriaState({this.convocatoria});

  @override
  List<Object?> get props => [convocatoria];
}

class ConvocatoriaInitial extends ConvocatoriaState {}

class ConvocatoriaLoading extends ConvocatoriaState {}

class ConvocatoriaLoaded extends ConvocatoriaState {
  final List<ConvocatoriaEntity>? convocatoriaLoaded;

  const ConvocatoriaLoaded(this.convocatoriaLoaded)
      : super(convocatoria: convocatoriaLoaded);
}

class ConvocatoriaError extends ConvocatoriaState {
  final String message;

  const ConvocatoriaError(this.message);

  @override
  List<Object?> get props => [message];
}
