part of 'beneficiario_cubit.dart';

abstract class BeneficiarioState extends Equatable {
  final BeneficiarioEntity? beneficiario;
  const BeneficiarioState({this.beneficiario});

  @override
  List<Object?> get props => [beneficiario];
}

class BeneficiarioInitial extends BeneficiarioState {
  BeneficiarioInitial()
      : super(
            beneficiario: BeneficiarioEntity(
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
                recordStatus: ''));
}

class BeneficiarioLoading extends BeneficiarioState {}

class BeneficiarioLoaded extends BeneficiarioState {
  final BeneficiarioEntity? beneficiarioLoaded;

  const BeneficiarioLoaded(this.beneficiarioLoaded)
      : super(beneficiario: beneficiarioLoaded);
}

class BeneficiarioSaved extends BeneficiarioState {}

class BeneficiarioError extends BeneficiarioState {
  final String message;

  const BeneficiarioError(this.message);

  @override
  List<Object?> get props => [message];
}
