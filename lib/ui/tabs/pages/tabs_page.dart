import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/blocs/alianzas/alianzas_bloc.dart';
import 'package:paap/domain/blocs/perfiles_preinversion/perfiles_preinversion_bloc.dart';
import 'package:paap/domain/blocs/upload_sync/upload_sync_bloc.dart';
import 'package:paap/ui/perfil_preinversion/pages/perfiles_preinversion_page.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/blocs/perfiles/perfiles_bloc.dart';
import '../../../domain/cubits/internet/internet_cubit.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../alianzas/pages/alianzas_page.dart';
import '../../perfiles/pages/perfiles_page.dart';
import '../../utils/custom_general_dialog.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/loading_page.dart';
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

    return BlocListener<UploadSyncBloc, UploadSyncState>(
      listener: (context, state) {
        if (state is UploadSyncFailure) {
          CustomSnackBar.showSnackBar(context, state.message, Colors.red);
          return;
        }
        if (state is UploadSyncSuccess) {
          CustomSnackBar.showSnackBar(
              context, 'Sincronización exitosa', Colors.green);
        }
      },
      child: BlocBuilder<UploadSyncBloc, UploadSyncState>(
        builder: (context, state) {
          if (state is UploadSyncInProgress) {
            return LoadingPage(
                title: 'Sincronizando...',
                percent: state.progress.percent,
                text:
                    '${state.progress.title} ${state.progress.counter}/${state.progress.total}');
          }
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniStartTop,
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
                            BlocProvider.of<UploadSyncBloc>(context)
                                .add(UploadStarted(authBloc.state.usuario!));
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
