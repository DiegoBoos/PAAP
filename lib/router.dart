import 'package:flutter/material.dart';
import 'package:paap/ui/alianzas/pages/alianza_detail_page.dart';

import 'ui/aliados_preinversion/pages/aliados_preinversion_page.dart';
import 'ui/aliados_preinversion/pages/new_edit_aliado_preinversion_page.dart';
import 'ui/auth/pages/sign_in_page.dart';
import 'ui/beneficiarios_preinversion/pages/beneficiarios_preinversion_page.dart';
import 'ui/beneficiarios_preinversion/pages/new_edit_beneficiario_preinversion_page.dart';
import 'ui/perfiles/pages/perfil_detail_page.dart';
import 'ui/perfiles/pages/registro_visita_page.dart';
import 'ui/preinversion/pages/perfil_preinversion_detail_page.dart';
import 'ui/tabs/pages/tabs_page.dart';

class AppRouter {
  static const initialRoute = 'sign-in';

  static Map<String, Widget Function(BuildContext)> routes = {
    'sign-in': (BuildContext context) => const SignInPage(),
    'tabs': (BuildContext context) => const TabsPage(),
    'VPerfil': (BuildContext context) => const PerfilDetailPage(),
    'VPrimeraVisita': (BuildContext context) => const RegistroVisitaPage(),
    'VPerfilPreInversion': (BuildContext context) {
      return const PerfilPreinversionDetailPage();
    },
    'VBeneficiariosPreInversion': (BuildContext context) {
      return const BeneficiariosPreinversionPage();
    },
    'VBeneficiarioPreInversion': (BuildContext context) {
      return const NewEditBeneficiarioPreinversionPage();
    },
    'VAliadosPreInversion': (BuildContext context) {
      return const AliadosPreinversionPage();
    },
    'VAliadoPreInversion': (BuildContext context) {
      return const NewEditAliadoPreinversionPage();
    },
    'VAlianza': (BuildContext context) {
      return const AlianzaDetailPage();
    }
  };
}
