part of 'experiencia_agricola_cubit.dart';

abstract class ExperienciaAgricolaState extends Equatable {
  final ExperienciaAgricolaEntity? experienciaAgricola;
  const ExperienciaAgricolaState({this.experienciaAgricola});

  @override
  List<Object?> get props => [experienciaAgricola];
}

class ExperienciaAgricolaInitial extends ExperienciaAgricolaState {
  ExperienciaAgricolaInitial()
      : super(
            experienciaAgricola: ExperienciaAgricolaEntity(
                tipoActividadProductivaId: '',
                beneficiarioId: '',
                frecuenciaId: '',
                areaCultivo: '',
                cantidadProducida: '',
                cantidadVendida: '',
                cantidadAutoconsumo: '',
                costoImplementacion: '',
                valorJornal: '',
                totalIngresoNeto: '',
                areaPasto: '',
                areaSinUso: '',
                areaReservaConservacion: '',
                areaImplementacion: '',
                totalAreaPredio: ''));
}

class ExperienciaAgricolaLoading extends ExperienciaAgricolaState {}

class ExperienciaAgricolaLoaded extends ExperienciaAgricolaState {
  final ExperienciaAgricolaEntity? experienciaAgricolaLoaded;

  const ExperienciaAgricolaLoaded(this.experienciaAgricolaLoaded)
      : super(experienciaAgricola: experienciaAgricolaLoaded);
}

class ExperienciaAgricolaError extends ExperienciaAgricolaState {
  final String message;

  const ExperienciaAgricolaError(this.message);

  @override
  List<Object?> get props => [message];
}
