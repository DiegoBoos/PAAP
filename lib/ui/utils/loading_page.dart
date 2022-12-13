import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paap/domain/cubits/internet/internet_cubit.dart';

import '../../domain/blocs/sync/sync_bloc.dart';
import 'network_icon.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
    required this.percent,
    required this.title,
    required this.text,
  }) : super(key: key);

  final double percent;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: Text(title), centerTitle: true, actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: BlocListener<InternetCubit, InternetState>(
              listener: (context, state) {
                if (state is InternetDisconnected) {
                  final syncBloc = BlocProvider.of<SyncBloc>(context);

                  syncBloc.add(const SyncError(
                      'Error en la sincronización, no hay conexión a internet'));
                }
              },
              child: const NetworkIcon(),
            ),
          )
        ]),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: percent,
              minHeight: 5,
            ),
            Expanded(child: Container()),
            SpinKitCircle(
              color: Colors.blue[900],
              size: 100.0,
            ),
            const SizedBox(height: 10),
            Text(text),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({super.key, required this.alignment});
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: alignment,
        child: SpinKitCircle(
          color: Colors.blue[900],
          size: 100.0,
        ));
  }
}
