import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/menu/menu_bloc.dart';
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
    const PerfilesPage(
      menuHijo: [],
    ),
    const PreinversionPage(
      menuHijo: [],
    ),
    const AlianzasPage(
      menuHijo: [],
    ),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuLoaded) {
            final menuPadre = state.menuPadre!.toList();

            return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: menuPadre
                    .map((menuItem) => BottomNavigationBarItem(
                        icon: Icon(setIcon(menuItem.menuId)),
                        label: menuItem.nombre))
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

  IconData setIcon(String menuId) {
    if (menuId == '1') return Icons.home;
    if (menuId == '12') return Icons.group;
    if (menuId == '36') return Icons.filter_center_focus;
    if (menuId == '11') return Icons.perm_contact_calendar;
    return Icons.abc;
  }
}
