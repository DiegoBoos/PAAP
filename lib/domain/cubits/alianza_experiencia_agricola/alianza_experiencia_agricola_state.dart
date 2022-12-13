part of 'alianza_experiencia_agricola_cubit.dart';

abstract class AlianzaExperienciaAgricolaState extends Equatable {
  final AlianzaExperienciaAgricolaEntity alianzaExperienciaAgricola;
  const AlianzaExperienciaAgricolaState(
      {required this.alianzaExperienciaAgricola});

  @override
  List<Object?> get props => [alianzaExperienciaAgricola];
}

class AlianzaExperienciaAgricolaInitial
    extends AlianzaExperienciaAgricolaState {
  AlianzaExperienciaAgricolaInitial()
      : super(alianzaExperienciaAgricola: initObject());
}

class AlianzaExperienciaAgricolaLoaded extends AlianzaExperienciaAgricolaState {
  final AlianzaExperienciaAgricolaEntity alianzaExperienciaAgricolaLoaded;

  const AlianzaExperienciaAgricolaLoaded(this.alianzaExperienciaAgricolaLoaded)
      : super(alianzaExperienciaAgricola: alianzaExperienciaAgricolaLoaded);
}

class AlianzaExperienciaAgricolaChanged
    extends AlianzaExperienciaAgricolaState {
  final AlianzaExperienciaAgricolaEntity alianzaExperienciaAgricolaLoaded;

  const AlianzaExperienciaAgricolaChanged(this.alianzaExperienciaAgricolaLoaded)
      : super(alianzaExperienciaAgricola: alianzaExperienciaAgricolaLoaded);
}

class AlianzaExperienciaAgricolaSaved extends AlianzaExperienciaAgricolaState {
  const AlianzaExperienciaAgricolaSaved(
      {required super.alianzaExperienciaAgricola});
}

class AlianzaExperienciaAgricolaError extends AlianzaExperienciaAgricolaState {
  final String message;

  AlianzaExperienciaAgricolaError(this.message)
      : super(alianzaExperienciaAgricola: initObject());

  @override
  List<Object?> get props => [message];
}

AlianzaExperienciaAgricolaEntity initObject() {
  return AlianzaExperienciaAgricolaEntity(
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
    totalAreaPredio: '',
    recordStatus: '',
  );
}
