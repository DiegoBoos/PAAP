part of 'beneficiarios_preinversion_bloc.dart';

abstract class Beneficiariospreinversiontate extends Equatable {
  const Beneficiariospreinversiontate();

  @override
  List<Object> get props => [];
}

class BeneficiariosPreinversionInitial extends Beneficiariospreinversiontate {}

class BeneficiariosPreinversionLoading extends Beneficiariospreinversiontate {}

class BeneficiariosPreinversionLoaded extends Beneficiariospreinversiontate {
  final List<BeneficiarioPreinversionEntity>? beneficiariosPreinversionLoaded;

  const BeneficiariosPreinversionLoaded({this.beneficiariosPreinversionLoaded});
}

class BeneficiariosPreinversionError extends Beneficiariospreinversiontate {
  final String message;

  const BeneficiariosPreinversionError(this.message);
}
