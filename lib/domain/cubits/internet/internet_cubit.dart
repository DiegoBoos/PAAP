import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  StreamSubscription? subscription;
  InternetCubit() : super(InternetLoading()) {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        emit(InternetConnected());
      } else {
        emit(InternetDisconnected());
      }
    });
    checkConnection();
  }

  Future<void> checkConnection() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(InternetConnected());
    } else {
      emit(InternetDisconnected());
    }
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
