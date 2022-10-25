import 'package:flutter/material.dart';
import 'package:paap/ui/perfiles/pages/perfil_detail_page.dart';
import 'package:paap/ui/tabs/pages/tabs_page.dart';
import 'ui/auth/pages/sign_in_page.dart';

class AppRouter {
  static const initialRoute = 'sign-in';

  static Map<String, Widget Function(BuildContext)> routes = {
    'sign-in': (BuildContext context) => const SignInPage(),
    'tabs': (BuildContext context) => const TabsPage(),
    'perfil-detail': (BuildContext context) => const PerfilDetailPage(),
  };
}
