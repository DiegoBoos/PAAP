import 'package:flutter/material.dart';
import 'domain/entities/menu_option.dart';
import 'ui/auth/pages/check_auth_page.dart';
import 'ui/auth/pages/sign_in_page.dart';
import 'ui/home/pages/home_page.dart';
import 'ui/perfil/pages/new_edit_perfil_page.dart';

class AppRouter {
  static const initialRoute = 'sign-in';
  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'sign-in',
        icon: Icons.power_settings_new,
        name: 'Cerrar Sesión',
        page: const SignInPage()),
  ];

  static Map<String, Widget Function(BuildContext)> routes = {
    'check': (BuildContext context) => const CheckAuthPage(),
    'sign-in': (BuildContext context) => const SignInPage(),
    'home': (BuildContext context) => const HomePage(),
    'new-edit-profile': (BuildContext context) => const NewEditPerfilPage(),
  };

/*   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const CheckAuthPage());
  } */

  static Map<String, Widget Function(BuildContext)> getMenuRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (var option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.page});
    }

    return appRoutes;
  }
}
