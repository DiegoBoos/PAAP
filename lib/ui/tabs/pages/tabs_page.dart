import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/perfiles/pages/perfiles_page.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/menu_entity.dart';
import 'home_page.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const PerfilesPage(
      menuHijo: [],
    ),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    final menuCubit = BlocProvider.of<MenuCubit>(context, listen: false);

    menuCubit.getMenu(
        usuarioId: authBloc.state.usuario!.usuarioId,
        contrasena: authBloc.state.usuario!.contrasena);
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context, listen: false);

    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            if (state is MenuLoaded) {
              final menuPadre = menuCubit.state.menuPadre;

              final filteredMenus = menuPadre!
                  .where((menu) =>
                      menu.menuId == '1' ||
                      menu.menuId == '12' ||
                      menu.menuId == '36' ||
                      menu.menuId == '11')
                  .toList();

              return BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  items: filteredMenus
                      .map((menuItem) => BottomNavigationBarItem(
                          icon: Icon(setIcon(menuItem.menuId)),
                          label: menuItem.nombre))
                      .toList());
            } else if (state is MenuError) {
              return Text(state.message);
            }
            return Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 10),
              child: const CircularProgressIndicator(),
            );
          },
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<MenuEntity> perfilesMenu(List<MenuEntity> menuHijo) {
    return menuHijo
        .where((submenu) => submenu.menuId == '22' || submenu.menuId == '31')
        .toList();
  }

  List<MenuEntity> preinversionMenu(List<MenuEntity> menuHijo) {
    return menuHijo
        .where((submenu) =>
            submenu.menuId == '37' ||
            submenu.menuId == '38' ||
            submenu.menuId == '39' ||
            submenu.menuId == '40' ||
            submenu.menuId == '41' ||
            submenu.menuId == '2067')
        .toList();
  }

  List<MenuEntity> alianzasMenu(List<MenuEntity> menuHijo) {
    return menuHijo
        .where((submenu) => submenu.menuId == '43' || submenu.menuId == '44')
        .toList();
  }

  IconData setIcon(String menuId) {
    if (menuId == '1') return Icons.home;
    if (menuId == '12') return Icons.group;
    if (menuId == '36') return Icons.filter_center_focus;
    if (menuId == '11') return Icons.perm_contact_calendar;
    return Icons.abc;
  }
}
