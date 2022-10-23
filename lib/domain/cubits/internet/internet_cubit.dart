import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnnectionType.wifi);
      } else if (connectivityResult == ConnnectionType.mobile) {
        emitInternetConnected(ConnnectionType.mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
    checkConnection(connectivity: connectivity);
  }

  Future<void> checkConnection({required Connectivity connectivity}) async {
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi) {
      emitInternetConnected(ConnnectionType.wifi);
    } else if (connectivityResult == ConnnectionType.mobile) {
      emitInternetConnected(ConnnectionType.mobile);
    } else if (connectivityResult == ConnectivityResult.none) {
      emitInternetDisconnected();
    }
  }

  void emitInternetConnected(ConnnectionType connnectionType) =>
      emit(InternetConnected(connnectionType: connnectionType));
  void emitInternetDisconnected() => emit(InternetDisconnected());
}
