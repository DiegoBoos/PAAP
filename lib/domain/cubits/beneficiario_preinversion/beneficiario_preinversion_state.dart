part of 'beneficiario_preinversion_cubit.dart';

abstract class BeneficiarioPreinversionState extends Equatable {
  final BeneficiarioPreinversionEntity? beneficiarioPreinversion;
  const BeneficiarioPreinversionState({this.beneficiarioPreinversion});

  @override
  List<Object?> get props => [beneficiarioPreinversion];
}

class BeneficiarioPreinversionInitial extends BeneficiarioPreinversionState {}

class BeneficiarioPreinversionLoading extends BeneficiarioPreinversionState {}

class BeneficiarioPreinversionLoaded extends BeneficiarioPreinversionState {
  final BeneficiarioPreinversionEntity? beneficiarioPreinversionLoaded;

  const BeneficiarioPreinversionLoaded(this.beneficiarioPreinversionLoaded)
      : super(beneficiarioPreinversion: beneficiarioPreinversionLoaded);
}

class BeneficiarioPreinversionError extends BeneficiarioPreinversionState {
  final String message;

  const BeneficiarioPreinversionError(this.message);

  @override
  List<Object?> get props => [message];
}
