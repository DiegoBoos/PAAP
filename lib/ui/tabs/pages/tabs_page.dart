import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/blocs/alianzas/alianzas_bloc.dart';
import 'package:paap/ui/preinversion/pages/perfiles_preinversion_page.dart';

import '../../../domain/blocs/perfiles/perfiles_bloc.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../alianzas/pages/alianzas_page.dart';
import '../../perfiles/pages/perfiles_page.dart';
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
    final alianzasBloc = BlocProvider.of<AlianzasBloc>(context);
    alianzasBloc.add(GetAlianzas());
  }

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const PerfilesPage(),
    const PerfilesPreinversionPage(),
    const AlianzasPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BlocConsumer<MenuCubit, MenuState>(
        listener: (context, state) {
          if (state is MenusError) {
            CustomSnackBar.showSnackBar(context, state.message, Colors.red);
          }
        },
        builder: (context, state) {
          if (state is MenusLoading) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: CustomCircularProgress(alignment: Alignment.bottomCenter),
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
                        icon: Icon(setIcon(menu.menuId)), label: menu.nombre))
                    .toList());
          }
          return const SizedBox();
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
