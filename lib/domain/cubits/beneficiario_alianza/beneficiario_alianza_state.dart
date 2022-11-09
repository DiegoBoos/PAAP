part of 'beneficiario_alianza_cubit.dart';

abstract class BeneficiarioAlianzaState extends Equatable {
  final BeneficiarioAlianzaEntity? beneficiarioAlianza;
  const BeneficiarioAlianzaState({this.beneficiarioAlianza});

  @override
  List<Object?> get props => [beneficiarioAlianza];
}

class BeneficiarioAlianzaInitial extends BeneficiarioAlianzaState {}

class BeneficiarioAlianzaLoading extends BeneficiarioAlianzaState {}

class BeneficiarioAlianzaLoaded extends BeneficiarioAlianzaState {
  final BeneficiarioAlianzaEntity? beneficiarioAlianzaLoaded;

  const BeneficiarioAlianzaLoaded(this.beneficiarioAlianzaLoaded)
      : super(beneficiarioAlianza: beneficiarioAlianzaLoaded);
}

class BeneficiarioAlianzaError extends BeneficiarioAlianzaState {
  final String message;

  const BeneficiarioAlianzaError(this.message);

  @override
  List<Object?> get props => [message];
}
