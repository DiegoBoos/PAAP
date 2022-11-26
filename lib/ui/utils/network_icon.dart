import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/cubits/internet/internet_cubit.dart';

class NetworkIcon extends StatelessWidget {
  const NetworkIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state is InternetConnected &&
            state.connnectionType == ConnnectionType.wifi) {
          return const Icon(Icons.wifi, color: Colors.green);
        } else if (state is InternetConnected &&
            state.connnectionType == ConnnectionType.mobile) {
          return const Icon(Icons.lte_mobiledata_outlined, color: Colors.green);
        } else if (state is InternetDisconnected) {
          return const Icon(Icons.wifi_off, color: Colors.red);
        }
        return Container();
      },
    );
  }
}
