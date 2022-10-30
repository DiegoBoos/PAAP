import 'package:flutter/material.dart';

import 'ui/auth/pages/sign_in_page.dart';
import 'ui/perfiles/pages/perfil_page.dart';
import 'ui/perfiles/pages/perfiles_page.dart';
import 'ui/perfiles/pages/registro_visita_page.dart';
import 'ui/tabs/pages/tabs_page.dart';

class AppRouter {
  static const initialRoute = 'sign-in';

  static Map<String, Widget Function(BuildContext)> routes = {
    'sign-in': (BuildContext context) => const SignInPage(),
    'tabs': (BuildContext context) => const TabsPage(),
    'VPerfiles': (BuildContext context) => const PerfilesPage(),
    'VPerfil': (BuildContext context) => const PerfilPage(),
    'VPrimeraVisita': (BuildContext context) => const RegistroVisitaPage(),
  };
}
