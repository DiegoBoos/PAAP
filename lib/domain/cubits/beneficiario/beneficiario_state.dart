part of 'beneficiario_cubit.dart';

abstract class BeneficiarioState extends Equatable {
  final List<BeneficiarioEntity>? beneficiario;
  const BeneficiarioState({this.beneficiario});

  @override
  List<Object?> get props => [beneficiario];
}

class BeneficiarioInitial extends BeneficiarioState {}

class BeneficiarioLoading extends BeneficiarioState {}

class BeneficiarioLoaded extends BeneficiarioState {
  final List<BeneficiarioEntity>? beneficiarioLoaded;

  const BeneficiarioLoaded(this.beneficiarioLoaded)
      : super(beneficiario: beneficiarioLoaded);
}

class BeneficiarioError extends BeneficiarioState {
  final String message;

  const BeneficiarioError(this.message);

  @override
  List<Object?> get props => [message];
}
