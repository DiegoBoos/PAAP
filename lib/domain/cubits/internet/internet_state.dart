part of 'internet_cubit.dart';

enum ConnnectionType { wifi, mobile }

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnnectionType connnectionType;

  const InternetConnected({required this.connnectionType});
}

class InternetDisconnected extends InternetState {}
