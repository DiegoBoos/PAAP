part of 'experiencia_agricola_cubit.dart';

abstract class ExperienciaAgricolaState extends Equatable {
  final ExperienciaAgricolaEntity experienciaAgricola;
  const ExperienciaAgricolaState({required this.experienciaAgricola});

  @override
  List<Object?> get props => [experienciaAgricola];
}

class ExperienciaAgricolaInitial extends ExperienciaAgricolaState {
  ExperienciaAgricolaInitial()
      : super(experienciaAgricola: ExperienciaAgricolaEntity());
}

class ExperienciaAgricolaLoaded extends ExperienciaAgricolaState {
  final ExperienciaAgricolaEntity experienciaAgricolaLoaded;

  const ExperienciaAgricolaLoaded(this.experienciaAgricolaLoaded)
      : super(experienciaAgricola: experienciaAgricolaLoaded);
}

class ExperienciaAgricolaChanged extends ExperienciaAgricolaState {
  final ExperienciaAgricolaEntity experienciaAgricolaLoaded;

  const ExperienciaAgricolaChanged(this.experienciaAgricolaLoaded)
      : super(experienciaAgricola: experienciaAgricolaLoaded);
}

class ExperienciaAgricolaSaved extends ExperienciaAgricolaState {
  const ExperienciaAgricolaSaved({required super.experienciaAgricola});
}

class ExperienciaAgricolaError extends ExperienciaAgricolaState {
  final String message;

  ExperienciaAgricolaError(this.message)
      : super(experienciaAgricola: ExperienciaAgricolaEntity());

  @override
  List<Object?> get props => [message];
}
