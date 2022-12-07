import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/alianza_beneficiario/alianza_beneficiario_cubit.dart';
import '../../../domain/cubits/alianza_experiencia_agricola/alianza_experiencia_agricola_cubit.dart';
import '../../../domain/cubits/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_cubit.dart';
import '../../../domain/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../alianzas/widgets/alianza_drawer.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/alianza_beneficiario_experiencia_form.dart';
import '../widgets/alianza_beneficiario_form.dart';
import '../widgets/alianza_perfil_beneficiario_form.dart';
import '../widgets/beneficiario_form.dart';
import '../widgets/conyuge_form.dart';

class NewEditAlianzaBeneficiarioPage extends StatelessWidget {
  const NewEditAlianzaBeneficiarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    return Scaffold(
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final menuHijo = menuCubit.alianzaMenuSorted(state.menus!);
            return AlianzaDrawer(
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
                BlocConsumer<AlianzaBeneficiarioCubit,
                    AlianzaBeneficiarioState>(
                  listener: (context, state) {
                    if (state is AlianzaBeneficiarioError) {
                      CustomSnackBar.showSnackBar(
                          context, 'Error al guardar datos', Colors.red);
                    }
                    if (state is AlianzaBeneficiarioSaved) {
                      CustomSnackBar.showSnackBar(context,
                          'Datos guardados satisfactoriamente', Colors.green);

                      Navigator.pushNamedAndRemoveUntil(context,
                          'VBeneficiarioPreInversion', (route) => false);
                    }
                  },
                  builder: (context, state) {
                    final alianzaBeneficiario = state.alianzaBeneficiario;

                    final beneficiarioId = alianzaBeneficiario.beneficiarioId;

                    final estadoCivilId = alianzaBeneficiario.estadoCivilId;

                    return Column(
                      children: [
                        Text(beneficiarioId == '' ? 'Creación' : 'Editar',
                            style: Styles.subtitleStyle),
                        const SizedBox(height: 10),
                        const BeneficiarioForm(),
                        const AlianzaPerfilBeneficiarioForm(),
                        const AlianzaBeneficiarioForm(),
                        if (estadoCivilId == '2' || estadoCivilId == '5')
                          const ConyugeForm(),
                        const AlianzaBeneficiarioExperienciaForm(),
                        const SizedBox(height: 10),
                        SaveBackButtons(
                          onSaved: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            formKey.currentState!.save();

                            saveBeneficiario(context);
                            savePerfilBeneficiario(context);
                            saveAlianzaBeneficiario(context);
                            saveExperiencia(context);
                          },
                          routeName: 'VBeneficiarioPreInversion',
                        ),
                        const SizedBox(height: 10)
                      ],
                    );
                  },
                ),
              ]),
            ),
          ),
        ));
  }

  void saveBeneficiario(BuildContext context) {
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    beneficiarioCubit.changeActivo(true);

    final beneficiario = beneficiarioCubit.state.beneficiario;
    beneficiarioCubit.saveBeneficiarioDB(beneficiario);
  }

  void savePerfilBeneficiario(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context);

    final perfilId =
        vPerfilPreInversionCubit.state.vPerfilPreInversion!.perfilId;
    final beneficiarioId = beneficiarioCubit.state.beneficiario.beneficiarioId;
    final perfilBeneficiario = perfilBeneficiarioCubit.state.perfilBeneficiario;

    perfilBeneficiarioCubit.changePerfilId(perfilId);
    perfilBeneficiarioCubit.changeBeneficiarioId(beneficiarioId);
    if (perfilBeneficiario.asociado == '') {
      perfilBeneficiarioCubit.changeAsociado(false);
    }
    if (perfilBeneficiario.activo == '') {
      perfilBeneficiarioCubit.changeActivo(false);
    }
    if (perfilBeneficiario.fueBeneficiado == '') {
      perfilBeneficiarioCubit.changeFueBeneficiado(false);
    }

    perfilBeneficiarioCubit.savePerfilBeneficiarioDB(
        perfilBeneficiarioCubit.state.perfilBeneficiario);
  }

  void saveAlianzaBeneficiario(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context);
    final alianzaBeneficiarioCubit =
        BlocProvider.of<AlianzaBeneficiarioCubit>(context);

    final perfilPreInversionId = vPerfilPreInversionCubit
        .state.vPerfilPreInversion!.perfilPreInversionId;

    final perfilBeneficiario = perfilBeneficiarioCubit.state.perfilBeneficiario;

    final alianzaBeneficiario =
        alianzaBeneficiarioCubit.state.alianzaBeneficiario;

    alianzaBeneficiarioCubit.changeAlianzaId(perfilPreInversionId);
    alianzaBeneficiarioCubit
        .changeBeneficiarioId(perfilBeneficiario.beneficiarioId);
    alianzaBeneficiarioCubit.changeMunicipioId(perfilBeneficiario.municipioId);
    alianzaBeneficiarioCubit.changeVeredaId(perfilBeneficiario.veredaId);
    alianzaBeneficiarioCubit.changeAreaFinca(perfilBeneficiario.areaFinca);
    alianzaBeneficiarioCubit
        .changeAreaProyecto(perfilBeneficiario.areaProyecto);
    alianzaBeneficiarioCubit
        .changeTipoTenencia(perfilBeneficiario.tipoTenenciaId);
    alianzaBeneficiarioCubit.changeExperiencia(perfilBeneficiario.experiencia);
    alianzaBeneficiarioCubit.changeAsociado(perfilBeneficiario.asociado);
    alianzaBeneficiarioCubit
        .changeConocePerfil(perfilBeneficiario.conocePerfil);
    alianzaBeneficiarioCubit
        .changeFueBeneficiado(perfilBeneficiario.fueBeneficiado);
    alianzaBeneficiarioCubit
        .changeCualBeneficio(perfilBeneficiario.cualBeneficio);

    if (alianzaBeneficiario.cotizanteBeps == '') {
      alianzaBeneficiarioCubit.changeCotizanteBeps(false);
    }
    if (alianzaBeneficiario.accesoExplotacionTierra == '') {
      alianzaBeneficiarioCubit.changeAccesoExplotacionTierra(false);
    }

    alianzaBeneficiarioCubit.saveAlianzaBeneficiarioDB(
        alianzaBeneficiarioCubit.state.alianzaBeneficiario);
  }

  void saveExperiencia(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    final alianzaExperienciaAgricolaCubit =
        BlocProvider.of<AlianzaExperienciaAgricolaCubit>(context);
    final alianzaExperienciaPecuariaCubit =
        BlocProvider.of<AlianzaExperienciaPecuariaCubit>(context);
    final tipoProyecto =
        vPerfilPreInversionCubit.state.vPerfilPreInversion!.tipoProyecto;

    final beneficiarioId = beneficiarioCubit.state.beneficiario.beneficiarioId;

    if (tipoProyecto == 'Agrícola') {
      alianzaExperienciaAgricolaCubit.changeBeneficiarioId(beneficiarioId);

      final alianzaExperienciaAgricola =
          alianzaExperienciaAgricolaCubit.state.alianzaExperienciaAgricola;

      alianzaExperienciaAgricolaCubit
          .saveAlianzaExperienciaAgricolaDB(alianzaExperienciaAgricola);
    } else if (tipoProyecto == 'Pecuario') {
      alianzaExperienciaPecuariaCubit.changeBeneficiarioId(beneficiarioId);

      alianzaExperienciaPecuariaCubit.saveAlianzaExperienciaPecuariaDB(
          alianzaExperienciaPecuariaCubit.state.alianzaExperienciaPecuaria);
    }
  }
}
