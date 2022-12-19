import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/blocs/alianzas/alianzas_bloc.dart';
import 'package:paap/domain/blocs/perfiles_preinversion/perfiles_preinversion_bloc.dart';
import 'package:paap/ui/perfil_preinversion/pages/perfiles_preinversion_page.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/blocs/perfiles/perfiles_bloc.dart';
import '../../../domain/blocs/sync/sync_bloc.dart';
import '../../../domain/cubits/internet/internet_cubit.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/cubits/sync_log/sync_log_cubit.dart';
import '../../../domain/entities/menu_entity.dart';

import '../../alianzas/pages/alianzas_page.dart';
import '../../perfiles/pages/perfiles_page.dart';
import '../../utils/custom_general_dialog.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import 'home_page.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  @override
  void initState() {
    super.initState();

    final perfilesBloc = BlocProvider.of<PerfilesBloc>(context);
    perfilesBloc.add(GetPerfiles());
    final perfilesPreInversionBloc =
        BlocProvider.of<PerfilesPreInversionBloc>(context);
    perfilesPreInversionBloc.add(GetPerfilesPreInversion());
    final alianzasBloc = BlocProvider.of<AlianzasBloc>(context);
    alianzasBloc.add(GetAlianzas());

    final menuCubit = BlocProvider.of<MenuCubit>(context);
    menuCubit.getMenuDB();
  }

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const PerfilesPage(),
    const PerfilesPreInversionPage(),
    const AlianzasPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final internetCubit = BlocProvider.of<InternetCubit>(context);
    final syncBloc = BlocProvider.of<SyncBloc>(context);
    final syncLogCubit = BlocProvider.of<SyncLogCubit>(context);

    return BlocListener<SyncBloc, SyncState>(
      listener: (context, state) {
        if (state is SyncFailure) {
          CustomSnackBar.showSnackBar(context, state.message, Colors.red);
          return;
        }
        if (state is SyncSuccess) {
          CustomSnackBar.showSnackBar(
              context, 'Sincronización exitosa', Colors.green);
        }
      },
      child: BlocBuilder<SyncBloc, SyncState>(
        builder: (context, state) {
          if (state is IncompleteSync) {
            final syncLog = state.syncLog;
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                appBar: AppBar(
                    title: const Text('Log'),
                    centerTitle: true,
                    actions: const [
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
                        style: Styles.titleStyle
                            .copyWith(color: Colors.red.shade400),
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
                                    backgroundColor:
                                        Colors.yellowAccent.shade700),
                                onPressed: () {
                                  syncLogCubit.forceSyncDB(state.syncLog).then(
                                      (value) {
                                    syncBloc.add(SyncStarted(
                                        authBloc.state.usuario!, 'P'));
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
                                  syncBloc.add(const SyncError(
                                      'Sincronización cancelada'));
                                },
                                child: const Text('Cancelar'))),
                      ]),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is SyncInProgress) {
            return LoadingPage(
                title: 'Sincronizando...',
                percent: state.progress.percent,
                text:
                    '${state.progress.title} ${state.progress.counter}/${state.progress.total}');
          }
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndTop,
            floatingActionButton: FloatingActionButton(
              mini: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                if (internetCubit.state is InternetConnected) {
                  showDialog(
                      context: context,
                      builder: (_) => CustomGeneralDialog(
                          title: '¿Desea Sincronizar?',
                          subtitle: '',
                          confirmText: 'Sincronizar',
                          cancelText: 'Cancelar',
                          onTapConfirm: () {
                            Navigator.pop(context);
                            BlocProvider.of<SyncBloc>(context)
                                .add(SyncStarted(authBloc.state.usuario!, 'P'));
                          },
                          onTapCancel: () {
                            Navigator.pop(context);
                          }));
                } else if (internetCubit.state is InternetDisconnected) {
                  CustomSnackBar.showSnackBar(
                      context,
                      'No fue posible sincronizar, no hay conexión a internet',
                      Colors.red);
                  return;
                }
              },
              child: const Icon(Icons.cloud_upload),
            ),
            body: _widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                if (state is MenusLoading) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: CustomCircularProgress(
                        alignment: Alignment.bottomCenter),
                  );
                } else if (state is MenusLoaded) {
                  final menu = state.menus!;

                  final tabsMenu = tabsMenuSorted(menu);

                  return BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      currentIndex: _selectedIndex,
                      onTap: _onItemTapped,
                      items: tabsMenu
                          .map((menu) => BottomNavigationBarItem(
                              icon: Icon(setIcon(menu.menuId)),
                              label: menu.nombre))
                          .toList());
                }
                return Container();
              },
            ),
          );
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<MenuEntity> tabsMenuSorted(List<MenuEntity> menu) {
    final tabsMenu = menu
        .where((menu) =>
            menu.menuId == '1' ||
            menu.menuId == '11' ||
            menu.menuId == '12' ||
            menu.menuId == '36')
        .toList();

    tabsMenu.sort((a, b) {
      return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
    });

    return tabsMenu;
  }

  IconData setIcon(String downloadsyncId) {
    if (downloadsyncId == '1') return Icons.home;
    if (downloadsyncId == '12') return Icons.group;
    if (downloadsyncId == '36') return Icons.filter_center_focus;
    if (downloadsyncId == '11') return Icons.perm_contact_calendar;
    return Icons.abc;
  }
}
