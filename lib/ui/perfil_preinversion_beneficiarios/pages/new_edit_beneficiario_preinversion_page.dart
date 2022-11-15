import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/beneficiario_experiencia_agricola_form.dart';
import '../widgets/beneficiario_form.dart';
import '../widgets/beneficiario_perfil_form.dart';
import '../widgets/beneficiario_preinversion_form.dart';
import '../widgets/conyuge_form.dart';

class NewEditPerfilPreInversionBeneficiarioPage extends StatelessWidget {
  const NewEditPerfilPreInversionBeneficiarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    return Scaffold(
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final menuHijo = menuCubit.preInversionMenuSorted(state.menus!);
            return PerfilPreInversionDrawer(
              menuHijo: menuHijo,
            );
          },
        ),
        appBar:
            AppBar(title: const Text('Detalle Beneficiario'), actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: NetworkIcon(),
          )
        ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(children: const [
              Text('BENEFICIARIOS', style: Styles.titleStyle),
              SizedBox(height: 10),
              /*  Text(beneficiarioId == '' ? 'Creación' : 'Editar',
                  style: Styles.subtitleStyle), */
              SizedBox(height: 10),
              BeneficiarioForm(),
              ConyugeForm(),
              BeneficiarioPerfilForm(),
              PerfilPreInversionBeneficiarioForm(),
              BeneficiarioExperienciaAgricolaForm(),
            ]),
          ),
        ));
  }
}
