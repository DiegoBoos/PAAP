import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/entities/usuario_entity.dart';
import 'package:paap/ui/utils/styles.dart';

import '../../../domain/blocs/alianzas/alianzas_bloc.dart';
import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/blocs/perfiles/perfiles_bloc.dart';
import '../../../domain/blocs/perfiles_preinversion/perfiles_preinversion_bloc.dart';
import '../../../domain/blocs/sync/sync_bloc.dart';
import '../../../domain/cubits/internet/internet_cubit.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/cubits/sync_log/sync_log_cubit.dart';
import '../../../domain/entities/menu_entity.dart';

import '../../alianzas/pages/alianzas_page.dart';
import '../../perfil_preinversion/pages/perfiles_preinversion_page.dart';
import '../../perfiles/pages/perfiles_page.dart';
import '../../utils/custom_general_dialog.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/sync_pages.dart';
import 'home_page.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final usuario = authBloc.state.usuario!;
    final internetCubit = BlocProvider.of<InternetCubit>(context);
    final syncBloc = BlocProvider.of<SyncBloc>(context);
    final syncLogCubit = BlocProvider.of<SyncLogCubit>(context);

    final size = MediaQuery.of(context).size;

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
            return LogPage(
                syncLog: syncLog,
                syncLogCubit: syncLogCubit,
                syncBloc: syncBloc,
                authBloc: authBloc);
          }
          if (state is SyncInProgress) {
            return LoadingPage(
                title: 'Sincronizando...',
                percent: state.progress.percent,
                text:
                    '${state.progress.title} ${state.progress.counter}/${state.progress.total}');
          }
          return BlocBuilder<MenuCubit, MenuState>(
            builder: (context, state) {
              if (state is MenusLoading) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child:
                      CustomCircularProgress(alignment: Alignment.bottomCenter),
                );
              } else if (state is MenusLoaded) {
                final menu = state.menus!;

                final tabsMenu = tabsMenuSorted(menu);

                final widgetOptions = tabsMenu.map((menu) {
                  if (menu.nombre == 'Inicio') {
                    return const HomePage();
                  } else if (menu.nombre == 'Perfiles') {
                    return const PerfilesPage();
                  } else if (menu.nombre == 'PreInversión') {
                    return const PerfilesPreInversionPage();
                  } else if (menu.nombre == 'Alianzas') {
                    return const AlianzasPage();
                  }
                }).toList();

                return Scaffold(
                    appBar: size.width > 500
                        ? PreferredSize(
                            preferredSize: size,
                            child: NavBar(
                                usuario: usuario,
                                internetCubit: internetCubit,
                                authBloc: authBloc),
                          )
                        : PreferredSize(
                            preferredSize: Size.fromHeight(size.height * 0.1),
                            child: MobileAppBar(
                                usuario: usuario,
                                internetCubit: internetCubit,
                                authBloc: authBloc)),
                    body: widgetOptions.elementAt(_selectedIndex),
                    bottomNavigationBar: size.width > 500
                        ? Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () =>
                                        Navigator.pushReplacementNamed(
                                            context, 'sign-in'),
                                    icon: const Icon(Icons.logout,
                                        color: Styles.obscureGreen)),
                                IconButton(
                                  icon: const Icon(Icons.cloud_upload,
                                      color: Styles.obscureGreen),
                                  onPressed: () {
                                    if (internetCubit.state
                                        is InternetConnected) {
                                      showDialog(
                                          context: context,
                                          builder: (_) => CustomGeneralDialog(
                                              title: '¿Desea Sincronizar?',
                                              subtitle: '',
                                              confirmText: 'Sincronizar',
                                              cancelText: 'Cancelar',
                                              onTapConfirm: () {
                                                Navigator.pop(context);
                                                BlocProvider.of<SyncBloc>(
                                                        context)
                                                    .add(SyncStarted(
                                                        authBloc.state.usuario!,
                                                        'P'));
                                              },
                                              onTapCancel: () {
                                                Navigator.pop(context);
                                              }));
                                    } else if (internetCubit.state
                                        is InternetDisconnected) {
                                      CustomSnackBar.showSnackBar(
                                          context,
                                          'No fue posible sincronizar, no hay conexión a internet',
                                          Colors.red);
                                      return;
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        : BottomNavigationBar(
                            type: BottomNavigationBarType.fixed,
                            currentIndex: _selectedIndex,
                            onTap: _onItemTapped,
                            items: tabsMenu
                                .map((menu) => BottomNavigationBarItem(
                                    icon: Icon(setIcon(menu.menuId)),
                                    label: menu.nombre))
                                .toList()));
              }
              return Container();
            },
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

  IconData setIcon(String downloadsyncId) {
    if (downloadsyncId == '1') return Icons.home;
    if (downloadsyncId == '12') return Icons.group;
    if (downloadsyncId == '36') return Icons.filter_center_focus;
    if (downloadsyncId == '11') return Icons.perm_contact_calendar;
    return Icons.abc;
  }
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

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
    required this.usuario,
    required this.internetCubit,
    required this.authBloc,
  }) : super(key: key);

  final UsuarioEntity usuario;
  final InternetCubit internetCubit;
  final AuthBloc authBloc;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    final menuCubit = BlocProvider.of<MenuCubit>(context, listen: false);

    final menu = menuCubit.state.menus!;
    final tabsMenu = tabsMenuSorted(menu);

    tabController = TabController(length: tabsMenu.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        if (state is MenusLoading) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: CustomCircularProgress(alignment: Alignment.bottomCenter),
          );
        } else if (state is MenusLoaded) {
          final menu = state.menus!;

          final tabsMenu = tabsMenuSorted(menu);

          return Column(
            children: [
              CustomTabBar(
                  controller: tabController,
                  tabs: tabsMenu
                      .map(
                        (menu) => CustomTab(title: menu.nombre),
                      )
                      .toList()),
              SizedBox(
                height: 400,
                child: TabBarView(
                    controller: tabController,
                    children: tabsMenu.map((menu) {
                      if (menu.nombre == 'Inicio') return const HomePage();

                      if (menu.nombre == 'Perfiles') {
                        return const PerfilesPage();
                      }

                      if (menu.nombre == 'PreInversión') {
                        return const PerfilesPreInversionPage();
                      }

                      if (menu.nombre == 'Alianzas') {
                        return const AlianzasPage();
                      }

                      return Container();
                    }).toList()),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key, required this.controller, required this.tabs})
      : super(key: key);

  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TabBar(
          labelColor: Styles.obscureGreen,
          indicatorColor: Styles.obscureGreen,
          controller: controller,
          tabs: tabs),
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }
}

class MobileAppBar extends StatelessWidget {
  const MobileAppBar({
    Key? key,
    required this.usuario,
    required this.internetCubit,
    required this.authBloc,
  }) : super(key: key);

  final UsuarioEntity usuario;
  final InternetCubit internetCubit;
  final AuthBloc authBloc;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ListTile(
          leading: const Icon(Icons.person_pin),
          title: Text('${usuario.nombre} ${usuario.apellido}',
              style: const TextStyle(color: Colors.white))),
      actions: [
        IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, 'sign-in'),
            icon: const Icon(Icons.logout)),
        IconButton(
          icon: const Icon(Icons.cloud_upload),
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
        ),
      ],
    );
  }
}
