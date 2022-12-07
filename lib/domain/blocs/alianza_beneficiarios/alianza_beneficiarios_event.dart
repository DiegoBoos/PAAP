part of 'alianza_beneficiarios_bloc.dart';

abstract class AlianzasBeneficiariosEvent extends Equatable {
  const AlianzasBeneficiariosEvent();

  @override
  List<Object> get props => [];
}

class GetAlianzasBeneficiarios extends AlianzasBeneficiariosEvent {
  final String alianzaId;

  const GetAlianzasBeneficiarios(this.alianzaId);
}
