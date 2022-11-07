part of 'rubro_cubit.dart';

abstract class RubroState extends Equatable {
  final List<RubroEntity>? rubro;
  const RubroState({this.rubro});

  @override
  List<Object?> get props => [rubro];
}

class RubroInitial extends RubroState {}

class RubroLoading extends RubroState {}

class RubroLoaded extends RubroState {
  final List<RubroEntity>? rubroLoaded;

  const RubroLoaded(this.rubroLoaded) : super(rubro: rubroLoaded);
}

class RubroError extends RubroState {
  final String message;

  const RubroError(this.message);

  @override
  List<Object?> get props => [message];
}
