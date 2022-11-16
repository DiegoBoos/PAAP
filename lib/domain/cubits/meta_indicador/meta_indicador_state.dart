part of 'meta_indicador_cubit.dart';

abstract class MetaIndicadorState extends Equatable {
  final List<MetaIndicadorEntity>? metasIndicadores;
  const MetaIndicadorState({this.metasIndicadores});

  @override
  List<Object?> get props => [metasIndicadores];
}

class MetasIndicadoresInitial extends MetaIndicadorState {}

class MetasIndicadoresLoading extends MetaIndicadorState {}

class MetasIndicadoresLoaded extends MetaIndicadorState {
  final List<MetaIndicadorEntity>? metasIndicadoresLoaded;

  const MetasIndicadoresLoaded(this.metasIndicadoresLoaded)
      : super(metasIndicadores: metasIndicadoresLoaded);
}

class MetasIndicadoresError extends MetaIndicadorState {
  final String message;

  const MetasIndicadoresError(this.message);

  @override
  List<Object?> get props => [message];
}
