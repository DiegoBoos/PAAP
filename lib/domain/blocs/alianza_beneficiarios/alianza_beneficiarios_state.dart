part of 'alianza_beneficiarios_bloc.dart';

abstract class AlianzasBeneficiariostate extends Equatable {
  const AlianzasBeneficiariostate();

  @override
  List<Object> get props => [];
}

class AlianzasBeneficiariosInitial extends AlianzasBeneficiariostate {}

class AlianzasBeneficiariosLoading extends AlianzasBeneficiariostate {}

class AlianzasBeneficiariosLoaded extends AlianzasBeneficiariostate {
  final List<AlianzaBeneficiarioEntity>? alianzasBeneficiariosLoaded;

  const AlianzasBeneficiariosLoaded({this.alianzasBeneficiariosLoaded});
}

class AlianzasBeneficiariosError extends AlianzasBeneficiariostate {
  final String message;

  const AlianzasBeneficiariosError(this.message);
}
