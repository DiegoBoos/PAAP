part of 'beneficiario_cubit.dart';

abstract class BeneficiarioState extends Equatable {
  final BeneficiarioEntity beneficiario;
  const BeneficiarioState({required this.beneficiario});

  @override
  List<Object?> get props => [beneficiario];
}

class BeneficiarioInitial extends BeneficiarioState {
  BeneficiarioInitial() : super(beneficiario: initObject());
}

class BeneficiarioLoading extends BeneficiarioState {
  BeneficiarioLoading() : super(beneficiario: initObject());
}

class BeneficiarioLoaded extends BeneficiarioState {
  final BeneficiarioEntity beneficiarioLoaded;

  const BeneficiarioLoaded(this.beneficiarioLoaded)
      : super(beneficiario: beneficiarioLoaded);
}

class BeneficiarioChanged extends BeneficiarioState {
  final BeneficiarioEntity beneficiarioLoaded;

  const BeneficiarioChanged(this.beneficiarioLoaded)
      : super(beneficiario: beneficiarioLoaded);
}

class BeneficiarioSaved extends BeneficiarioState {
  BeneficiarioSaved() : super(beneficiario: initObject());
}

class BeneficiarioError extends BeneficiarioState {
  final String message;

  BeneficiarioError(this.message) : super(beneficiario: initObject());

  @override
  List<Object?> get props => [message];
}

BeneficiarioEntity initObject() {
  return BeneficiarioEntity(
      beneficiarioId: '',
      nombre1: '',
      nombre2: '',
      apellido1: '',
      apellido2: '',
      generoId: '',
      fechaNacimiento: '',
      fechaExpedicionDocumento: '',
      grupoEspecialId: '',
      telefonoMovil: '',
      activo: '',
      tipoIdentificacionId: '',
      recordStatus: '');
}
