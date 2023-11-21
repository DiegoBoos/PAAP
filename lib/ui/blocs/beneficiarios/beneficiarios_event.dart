part of 'beneficiarios_bloc.dart';

abstract class BeneficiariosEvent extends Equatable {
  const BeneficiariosEvent();

  @override
  List<Object> get props => [];
}

class InitState extends BeneficiariosEvent {}

class GetBeneficiarios extends BeneficiariosEvent {
  final String perfilId;

  const GetBeneficiarios(this.perfilId);
}
