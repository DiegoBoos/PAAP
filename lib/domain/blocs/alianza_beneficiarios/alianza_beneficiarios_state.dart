part of 'alianza_beneficiarios_bloc.dart';

abstract class AlianzasBeneficiariosState extends Equatable {
  const AlianzasBeneficiariosState();

  @override
  List<Object> get props => [];
}

class AlianzasBeneficiariosInitial extends AlianzasBeneficiariosState {}

class AlianzasBeneficiariosLoading extends AlianzasBeneficiariosState {}

class AlianzasBeneficiariosLoaded extends AlianzasBeneficiariosState {
  final List<AlianzaBeneficiarioEntity>? alianzasBeneficiariosLoaded;

  const AlianzasBeneficiariosLoaded({this.alianzasBeneficiariosLoaded});
}

class AlianzasBeneficiariosError extends AlianzasBeneficiariosState {
  final String message;

  const AlianzasBeneficiariosError(this.message);
}
