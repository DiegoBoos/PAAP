part of 'beneficiarios_alianza_bloc.dart';

abstract class BeneficiariosAlianzaState extends Equatable {
  const BeneficiariosAlianzaState();

  @override
  List<Object> get props => [];
}

class BeneficiariosAlianzaInitial extends BeneficiariosAlianzaState {}

class BeneficiariosAlianzaLoading extends BeneficiariosAlianzaState {}

class BeneficiariosAlianzaLoaded extends BeneficiariosAlianzaState {
  final List<BeneficiarioAlianzaEntity>? beneficiariosAlianzaLoaded;

  const BeneficiariosAlianzaLoaded({this.beneficiariosAlianzaLoaded});
}

class BeneficiariosAlianzaError extends BeneficiariosAlianzaState {
  final String message;

  const BeneficiariosAlianzaError(this.message);
}
