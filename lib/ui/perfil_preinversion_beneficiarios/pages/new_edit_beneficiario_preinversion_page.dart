import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import 'package:paap/ui/utils/floating_buttons.dart';

import '../../../domain/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../domain/cubits/experiencia_agricola/experiencia_agricola_cubit.dart';
import '../../../domain/cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
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
    final formKey = GlobalKey<FormState>();
    final beneficiarioId = ModalRoute.of(context)!.settings.arguments as String;
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
            child: Form(
              key: formKey,
              child: Column(children: [
                const Text('BENEFICIARIOS', style: Styles.titleStyle),
                const SizedBox(height: 10),
                Text(beneficiarioId == '' ? 'Creación' : 'Editar',
                    style: Styles.subtitleStyle),
                const SizedBox(height: 10),
                const BeneficiarioForm(),
                const ConyugeForm(),
                const BeneficiarioPerfilForm(),
                const PerfilPreInversionBeneficiarioForm(),
                const BeneficiarioExperienciaAgricolaForm(),
                SaveBackButtons(onSaved: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  formKey.currentState!.save();

                  //TODO: Guardar en tabla beneficiario, perfil preinversion beneficiario,
                  //perfil beneficiario, experiencia agricola o experiencia pecuaria (deacuerdo al tipo de proyecto solo se usa una)

                  final beneficiarioCubit =
                      BlocProvider.of<BeneficiarioCubit>(context);
                  final beneficiario = beneficiarioCubit.state.beneficiario;

                  final perfilPreInversionBeneficiarioCubit =
                      BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(
                          context);

                  final perfilPreInversionBeneficiario =
                      perfilPreInversionBeneficiarioCubit
                          .state.perfilPreInversionBeneficiario;

                  final perfilBeneficiarioCubit =
                      BlocProvider.of<PerfilBeneficiarioCubit>(context);

                  final perfilBeneficiario =
                      perfilBeneficiarioCubit.state.perfilBeneficiario;

                  final experienciaAgricolaCubit =
                      BlocProvider.of<ExperienciaAgricolaCubit>(context);

                  final experienciaAgricola =
                      experienciaAgricolaCubit.state.experienciaAgricola;

                  final experienciaPecuariaCubit =
                      BlocProvider.of<ExperienciaPecuariaCubit>(context);

                  final experienciaPecuaria =
                      experienciaPecuariaCubit.state.experienciaPecuaria;
                })
              ]),
            ),
          ),
        ));
  }
}
