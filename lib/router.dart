import 'package:flutter/material.dart';
import 'ui/auth/pages/check_auth_page.dart';
import 'ui/auth/pages/sign_in_page.dart';

class AppRouter {
  static const initialRoute = 'check';

  static Map<String, Widget Function(BuildContext)> routes = {
    'check': (BuildContext context) => const CheckAuthPage(),
    'sign-in': (BuildContext context) => const SignInPage(),
    //TODO: rutas de las pantallas a desarrollar
    /* 'VPerfiles': (BuildContext context) => const PerfilesPage(),
    'VPerfilesPreInversion': (BuildContext context) =>
        const PerfilesPreinversionPage(),
    'VAlianzas': (BuildContext context) => const AlianzasPage(), */
  };
}
