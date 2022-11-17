part of 'experiencia_pecuaria_cubit.dart';

abstract class ExperienciaPecuariaState extends Equatable {
  final ExperienciaPecuariaEntity? experienciaPecuaria;
  const ExperienciaPecuariaState({this.experienciaPecuaria});

  @override
  List<Object?> get props => [experienciaPecuaria];
}

class ExperienciaPecuariaInitial extends ExperienciaPecuariaState {
  ExperienciaPecuariaInitial()
      : super(
            experienciaPecuaria: ExperienciaPecuariaEntity(
                tipoActividadProductivaId: '',
                beneficiarioId: '',
                frecuenciaId: '',
                cantidadAnimales: '',
                cantidadCria: '',
                cantidadLevante: '',
                cantidadCeba: '',
                cantidadLeche: '',
                valorJornal: '',
                costosInsumos: '',
                ingresos: ''));
}

class ExperienciaPecuariaLoading extends ExperienciaPecuariaState {}

class ExperienciaPecuariaLoaded extends ExperienciaPecuariaState {
  final ExperienciaPecuariaEntity? experienciaPecuariaLoaded;

  const ExperienciaPecuariaLoaded(this.experienciaPecuariaLoaded)
      : super(experienciaPecuaria: experienciaPecuariaLoaded);
}

class ExperienciaPecuariaError extends ExperienciaPecuariaState {
  final String message;

  const ExperienciaPecuariaError(this.message);

  @override
  List<Object?> get props => [message];
}
