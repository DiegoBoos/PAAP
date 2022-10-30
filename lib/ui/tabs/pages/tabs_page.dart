import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../alianzas/pages/alianzas_page.dart';
import '../../perfiles/pages/perfiles_page.dart';
import '../../preinversion/pages/preinversion_page.dart';
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
    const PerfilesPage(),
    const PreinversionPage(),
    const AlianzasPage(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          if (state is MenuLoaded) {
            final menu = state.menu!;

            final tabsMenu = tabsMenuSorted(menu);

            return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: tabsMenu
                    .map((menu) => BottomNavigationBarItem(
                        icon: Icon(setIcon(menu.menuId)), label: menu.nombre))
                    .toList());
          } else if (state is MenuError) {
            return Text(state.message);
          }
          return Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 30),
            child: const CircularProgressIndicator(),
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
