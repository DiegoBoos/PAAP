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
import '../widgets/perfil_beneficiario_form.dart';
import '../widgets/perfil_preinversion_beneficiario_form.dart';
import '../widgets/conyuge_form.dart';

class NewEditPerfilPreInversionBeneficiarioPage extends StatefulWidget {
  const NewEditPerfilPreInversionBeneficiarioPage({super.key});

  @override
  State<NewEditPerfilPreInversionBeneficiarioPage> createState() =>
      _NewEditPerfilPreInversionBeneficiarioPageState();
}

class _NewEditPerfilPreInversionBeneficiarioPageState
    extends State<NewEditPerfilPreInversionBeneficiarioPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BeneficiarioCubit>(context).initState();
    BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context).initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);
    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context);
    final experienciaAgricolaCubit =
        BlocProvider.of<ExperienciaAgricolaCubit>(context);
    final experienciaPecuariaCubit =
        BlocProvider.of<ExperienciaPecuariaCubit>(context);

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
                BlocBuilder<PerfilPreInversionBeneficiarioCubit,
                    PerfilPreInversionBeneficiarioState>(
                  builder: (context, state) {
                    if (state is PerfilPreInversionBeneficiarioLoaded) {
                      return Text(
                          state.perfilPreInversionBeneficiarioLoaded!
                                      .beneficiarioId ==
                                  '0'
                              ? 'Creación'
                              : 'Editar',
                          style: Styles.subtitleStyle);
                    }
                    return const SizedBox();
                  },
                ),
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

                  final beneficiario = beneficiarioCubit.state.beneficiario;

                  final perfilPreInversionBeneficiario =
                      perfilPreInversionBeneficiarioCubit
                          .state.perfilPreInversionBeneficiario;

                  final perfilBeneficiario =
                      perfilBeneficiarioCubit.state.perfilBeneficiario;

                  final experienciaAgricola =
                      experienciaAgricolaCubit.state.experienciaAgricola;

                  final experienciaPecuaria =
                      experienciaPecuariaCubit.state.experienciaPecuaria;

                  beneficiarioCubit.saveBeneficiarioDB(beneficiario!);
                })
              ]),
            ),
          ),
        ));
  }
}
