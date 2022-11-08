part of 'beneficiarios_preinversion_bloc.dart';

abstract class BeneficiariosPreinversionState extends Equatable {
  const BeneficiariosPreinversionState();

  @override
  List<Object> get props => [];
}

class BeneficiariosPreinversionInitial extends BeneficiariosPreinversionState {}

class BeneficiariosPreinversionLoading extends BeneficiariosPreinversionState {}

class BeneficiariosPreinversionLoaded extends BeneficiariosPreinversionState {
  final List<BeneficiarioPreinversionEntity>? beneficiariosPreinversionLoaded;

  const BeneficiariosPreinversionLoaded({this.beneficiariosPreinversionLoaded});
}

class BeneficiariosPreinversionError extends BeneficiariosPreinversionState {
  final String message;

  const BeneficiariosPreinversionError(this.message);
}
