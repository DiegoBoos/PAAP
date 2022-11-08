part of 'consultores_bloc.dart';

abstract class ConsultoresEvent extends Equatable {
  const ConsultoresEvent();

  @override
  List<Object> get props => [];
}

class GetConsultores extends ConsultoresEvent {}
