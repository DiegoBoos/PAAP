part of 'aliado_cubit.dart';

abstract class AliadoState extends Equatable {
  final AliadoEntity aliado;
  const AliadoState({required this.aliado});

  @override
  List<Object?> get props => [aliado];
}

class AliadoInitial extends AliadoState {
  AliadoInitial() : super(aliado: AliadoEntity());
}

class AliadoLoading extends AliadoState {
  const AliadoLoading({required super.aliado});
}

class AliadoLoaded extends AliadoState {
  final AliadoEntity aliadoLoaded;

  const AliadoLoaded(this.aliadoLoaded) : super(aliado: aliadoLoaded);
}

class AliadoChanged extends AliadoState {
  final AliadoEntity aliadoChanged;

  const AliadoChanged(this.aliadoChanged) : super(aliado: aliadoChanged);
}

class AliadoSaved extends AliadoState {
  final AliadoEntity aliadoSaved;

  const AliadoSaved({required this.aliadoSaved}) : super(aliado: aliadoSaved);
}

class AliadoError extends AliadoState {
  final String message;

  AliadoError(this.message) : super(aliado: AliadoEntity());

  @override
  List<Object?> get props => [message];
}
