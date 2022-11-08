part of 'cofinanciadores_bloc.dart';

abstract class CofinanciadoresEvent extends Equatable {
  const CofinanciadoresEvent();

  @override
  List<Object> get props => [];
}

class GetCofinanciadores extends CofinanciadoresEvent {}
