import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ui/cubits/internet/internet_cubit.dart';

class NetworkIcon extends StatelessWidget {
  const NetworkIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state is InternetConnected) {
          return const Icon(Icons.wifi, color: Colors.green);
        } else if (state is InternetDisconnected) {
          return const Icon(Icons.wifi_off, color: Colors.red);
        }
        return Container();
      },
    );
  }
}
