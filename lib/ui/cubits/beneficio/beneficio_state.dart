part of 'beneficio_cubit.dart';

abstract class BeneficioState extends Equatable {
  final List<BeneficioEntity>? beneficios;
  const BeneficioState({this.beneficios});

  @override
  List<Object?> get props => [beneficios];
}

class BeneficiosInitial extends BeneficioState {}

class BeneficiosLoading extends BeneficioState {}

class BeneficiosLoaded extends BeneficioState {
  final List<BeneficioEntity>? beneficiosLoaded;

  const BeneficiosLoaded(this.beneficiosLoaded)
      : super(beneficios: beneficiosLoaded);
}

class BeneficiosError extends BeneficioState {
  final String message;

  const BeneficiosError(this.message);

  @override
  List<Object?> get props => [message];
}
