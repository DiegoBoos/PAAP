import 'package:flutter/material.dart';
import 'package:paap/models/menu_option.dart';
import 'package:paap/modules/auth/auth_exports.dart';

class AppRoutes {
  static const initialRoute = 'checking';
  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'sign-in',
        icon: Icons.power_settings_new,
        name: 'Cerrar Sesión',
        screen: const SignInScreen()),
  ];

  static Map<String, Widget Function(BuildContext)> routes = {
    'sign-in': (BuildContext context) => const SignInScreen(),
    'sign-up': (BuildContext context) => const SignUpScreen(),
    'checking': (BuildContext context) => const CheckAuthScreen(),
    'forgot-pwd': (BuildContext context) => const ForgotPwdScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const CheckAuthScreen());
  }

  static Map<String, Widget Function(BuildContext)> getMenuRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (var option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }
}
