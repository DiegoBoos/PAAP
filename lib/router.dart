import 'package:flutter/material.dart';

import 'ui/alianzas/pages/alianza_detail_page.dart';
import 'ui/alianzas_beneficiarios/pages/alianzas_beneficiarios_page.dart';
import 'ui/alianzas_beneficiarios/pages/new_edit_alianza_beneficiario_page.dart';
import 'ui/perfil_preinversion_consultores/pages/perfil_preinversion_consultores.dart';
import 'ui/modelo_financiero/pages/modelo_financiero_page.dart';
import 'ui/perfil_preinversion_aliados/pages/new_edit_perfil_preinversion_aliado_page.dart';
import 'ui/perfil_preinversion_aliados/pages/perfil_preinversion_aliados_page.dart';
import 'ui/auth/pages/sign_in_page.dart';
import 'ui/perfil_preinversion_beneficiarios/pages/new_edit_perfil_preinversion_beneficiario_page.dart';
import 'ui/perfil_preinversion_beneficiarios/pages/perfil_preinversion_beneficiarios_page.dart';
import 'ui/perfil_preinversion_cofinanciadores/pages/new_edit_perfil_preinversion_cofinanciador_page.dart';
import 'ui/perfil_preinversion_cofinanciadores/pages/perfil_preinversion_cofinanciadores_page.dart';
import 'ui/perfiles/pages/perfil_detail_page.dart';
import 'ui/perfiles/pages/registro_visita_page.dart';
import 'ui/perfil_preinversion/pages/perfil_preinversion_detail_page.dart';
import 'ui/tabs/pages/tabs_page.dart';

class AppRouter {
  static const initialRoute = 'sign-in';

  static Map<String, Widget Function(BuildContext)> routes = {
    'sign-in': (BuildContext context) => const SignInPage(),
    'tabs': (BuildContext context) => const TabsPage(),
    'VPerfil': (BuildContext context) => const PerfilDetailPage(),
    'VPrimeraVisita': (BuildContext context) => const RegistroVisitaPage(),
    'VPerfilPreInversion': (BuildContext context) {
      return const PerfilPreInversionDetailPage();
    },
    'VBeneficiarioPreInversion': (BuildContext context) {
      return const PerfilPreInversionBeneficiariosPage();
    },
    'NewEditVBeneficiarioPreInversion': (BuildContext context) {
      return const NewEditPerfilPreInversionBeneficiarioPage();
    },
    'VAliadoPreInversion': (BuildContext context) {
      return const PerfilPreInversionAliadosPage();
    },
    'NewEditAliadoPreInversion': (BuildContext context) {
      return const NewEditPerfilPreInversionAliadoPage();
    },
    'VCofinanciadoresPreInversion': (BuildContext context) {
      return const PerfilPreInversionCofinanciadoresPage();
    },
    'NewEditVCofinanciadorPreInversion': (BuildContext context) {
      return const NewEditPerfilPreInversionCofinanciadorPage();
    },
    'VAsignacionConsultorPreInversion': (BuildContext context) {
      return const PerfilPreInversionConsultoresPage();
    },
    'VModeloFinanciero': (BuildContext context) {
      return const ModeloFinancieroPage();
    },
    'VAlianza': (BuildContext context) {
      return const AlianzaDetailPage();
    },
    'VBeneficiarioAlianza': (BuildContext context) {
      return const AlianzasBeneficiariosPage();
    },
    'NewEditVBeneficiarioAlianza': (BuildContext context) {
      return const NewEditAlianzaBeneficiarioPage();
    }
  };
}
