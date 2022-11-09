part of 'beneficiarios_alianza_bloc.dart';

abstract class BeneficiariosAlianzaEvent extends Equatable {
  const BeneficiariosAlianzaEvent();

  @override
  List<Object> get props => [];
}

class GetBeneficiariosAlianza extends BeneficiariosAlianzaEvent {}
