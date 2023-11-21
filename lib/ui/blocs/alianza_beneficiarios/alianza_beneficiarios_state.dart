part of 'alianza_beneficiarios_bloc.dart';

abstract class AlianzasBeneficiariosState extends Equatable {
  final List<AlianzaBeneficiarioEntity>? alianzasBeneficiarios;

  const AlianzasBeneficiariosState({this.alianzasBeneficiarios});

  @override
  List<Object> get props => [];
}

class AlianzasBeneficiariosInitial extends AlianzasBeneficiariosState {
  AlianzasBeneficiariosInitial() : super(alianzasBeneficiarios: []);
}

class AlianzasBeneficiariosLoading extends AlianzasBeneficiariosState {}

class AlianzasBeneficiariosLoaded extends AlianzasBeneficiariosState {
  final List<AlianzaBeneficiarioEntity> alianzasBeneficiariosLoaded;

  const AlianzasBeneficiariosLoaded(this.alianzasBeneficiariosLoaded)
      : super(alianzasBeneficiarios: alianzasBeneficiariosLoaded);
}

class AlianzasBeneficiariosError extends AlianzasBeneficiariosState {
  final String message;

  AlianzasBeneficiariosError(this.message) : super(alianzasBeneficiarios: []);
}
