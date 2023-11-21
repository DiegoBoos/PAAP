part of 'beneficiarios_bloc.dart';

abstract class BeneficiariosState extends Equatable {
  final List<BeneficiarioEntity>? beneficiarios;

  const BeneficiariosState({this.beneficiarios});

  @override
  List<Object> get props => [];
}

class BeneficiariosInitial extends BeneficiariosState {
  BeneficiariosInitial() : super(beneficiarios: []);
}

class BeneficiariosLoading extends BeneficiariosState {}

class BeneficiariosLoaded extends BeneficiariosState {
  final List<BeneficiarioEntity> beneficiariosLoaded;

  const BeneficiariosLoaded(this.beneficiariosLoaded)
      : super(beneficiarios: beneficiariosLoaded);
}

class BeneficiariosError extends BeneficiariosState {
  final String message;

  BeneficiariosError(this.message) : super(beneficiarios: []);
}
