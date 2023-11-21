part of 'experiencia_agricola_cubit.dart';

abstract class ExperienciaAgricolaState extends Equatable {
  final ExperienciaAgricolaEntity experienciaAgricola;
  const ExperienciaAgricolaState({required this.experienciaAgricola});

  @override
  List<Object?> get props => [experienciaAgricola];
}

class ExperienciaAgricolaInitial extends ExperienciaAgricolaState {
  ExperienciaAgricolaInitial() : super(experienciaAgricola: initObject());
}

class ExperienciaAgricolaLoading extends ExperienciaAgricolaState {
  ExperienciaAgricolaLoading() : super(experienciaAgricola: initObject());
}

class ExperienciaAgricolaLoaded extends ExperienciaAgricolaState {
  final ExperienciaAgricolaEntity experienciaAgricolaLoaded;

  const ExperienciaAgricolaLoaded(this.experienciaAgricolaLoaded)
      : super(experienciaAgricola: experienciaAgricolaLoaded);
}

class ExperienciaAgricolaChanged extends ExperienciaAgricolaState {
  final ExperienciaAgricolaEntity experienciaAgricolaLoaded;

  const ExperienciaAgricolaChanged(this.experienciaAgricolaLoaded)
      : super(experienciaAgricola: experienciaAgricolaLoaded);
}

class ExperienciaAgricolaSaved extends ExperienciaAgricolaState {
  ExperienciaAgricolaSaved() : super(experienciaAgricola: initObject());
}

class ExperienciaAgricolaError extends ExperienciaAgricolaState {
  final String message;

  ExperienciaAgricolaError(this.message)
      : super(experienciaAgricola: initObject());

  @override
  List<Object?> get props => [message];
}

ExperienciaAgricolaEntity initObject() {
  return ExperienciaAgricolaEntity(
    beneficiarioId: '',
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
    totalAreaPredio: '',
    recordStatus: '',
  );
}
