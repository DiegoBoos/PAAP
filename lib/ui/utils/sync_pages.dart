import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paap/ui/cubits/internet/internet_cubit.dart';
import 'package:paap/ui/utils/styles.dart';

import '../../ui/blocs/auth/auth_bloc.dart';
import '../../ui/blocs/sync/sync_bloc.dart';
import '../../ui/cubits/sync_log/sync_log_cubit.dart';
import '../../domain/entities/sync_log_entity.dart';
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

class LogPage extends StatelessWidget {
  const LogPage({
    Key? key,
    required this.syncLog,
    required this.syncLogCubit,
    required this.syncBloc,
    required this.authBloc,
  }) : super(key: key);

  final List<SyncLogEntity> syncLog;
  final SyncLogCubit syncLogCubit;
  final SyncBloc syncBloc;
  final AuthBloc authBloc;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar:
            AppBar(title: const Text('Log'), centerTitle: true, actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: NetworkIcon(),
          )
        ]),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Error al sincronizar',
                style: Styles.titleStyle.copyWith(color: Colors.red.shade400),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                itemCount: syncLog.length,
                itemBuilder: (BuildContext context, int index) {
                  final log = syncLog[index];
                  return ListTile(
                      title: Text(log.tabla),
                      subtitle: Text('${log.cantidadRegistros}'));
                },
                separatorBuilder: ((_, __) => const Divider()),
              ),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellowAccent.shade700),
                        onPressed: () {
                          syncLogCubit.forceSyncDB(syncLog).then((value) {
                            syncBloc
                                .add(SyncStarted(authBloc.state.usuario!, 'P'));
                          }, onError: (error) {
                            syncBloc.add(SyncError(error));
                          });
                        },
                        child: const Text('Forzar Sincronización'))),
                const SizedBox(width: 20),
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade400),
                        onPressed: () {
                          syncBloc
                              .add(const SyncError('Sincronización cancelada'));
                        },
                        child: const Text('Cancelar'))),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
