import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../domain/cubits/experiencia_agricola/experiencia_agricola_cubit.dart';
import '../../../domain/cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/beneficiario_experiencia_form.dart';
import '../widgets/beneficiario_form.dart';
import '../widgets/perfil_beneficiario_form.dart';
import '../widgets/perfil_preinversion_beneficiario_form.dart';
import '../widgets/conyuge_form.dart';

class NewEditPerfilPreInversionBeneficiarioPage extends StatelessWidget {
  const NewEditPerfilPreInversionBeneficiarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
                BlocConsumer<PerfilPreInversionBeneficiarioCubit,
                    PerfilPreInversionBeneficiarioState>(
                  listener: (context, state) {
                    if (state is PerfilPreInversionBeneficiarioError) {
                      CustomSnackBar.showSnackBar(
                          context, 'Error al guardar datos', Colors.red);
                    }
                    if (state is PerfilPreInversionBeneficiarioSaved) {
                      CustomSnackBar.showSnackBar(context,
                          'Datos guardados satisfactoriamente', Colors.green);

                      Navigator.pushNamedAndRemoveUntil(context,
                          'VBeneficiarioPreInversion', (route) => false);
                    }
                  },
                  builder: (context, state) {
                    final perfilPreInversionBeneficiario =
                        state.perfilPreInversionBeneficiario;

                    final beneficiarioId =
                        perfilPreInversionBeneficiario.beneficiarioId;

                    final estadoCivilId =
                        perfilPreInversionBeneficiario.estadoCivilId;

                    return Column(
                      children: [
                        Text(beneficiarioId == '' ? 'Creación' : 'Editar',
                            style: Styles.subtitleStyle),
                        const SizedBox(height: 10),
                        const BeneficiarioForm(),
                        const PerfilBeneficiarioForm(),
                        const PerfilPreInversionBeneficiarioForm(),
                        if (estadoCivilId == '2' || estadoCivilId == '5')
                          const ConyugeForm(),
                        const BeneficiarioExperienciaForm(),
                        const SizedBox(height: 10),
                        SaveBackButtons(
                          onSaved: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            formKey.currentState!.save();

                            saveBeneficiario(context);
                            savePerfilBeneficiario(context);
                            savePerfilPreInversionBeneficiario(context);
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

  void savePerfilPreInversionBeneficiario(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context);
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    final perfilPreInversionId = vPerfilPreInversionCubit
        .state.vPerfilPreInversion!.perfilPreInversionId;

    final perfilBeneficiario = perfilBeneficiarioCubit.state.perfilBeneficiario;

    final perfilPreInversionBeneficiario = perfilPreInversionBeneficiarioCubit
        .state.perfilPreInversionBeneficiario;

    perfilPreInversionBeneficiarioCubit
        .changePerfilPreInversionId(perfilPreInversionId);
    perfilPreInversionBeneficiarioCubit
        .changeBeneficiarioId(perfilBeneficiario.beneficiarioId);
    perfilPreInversionBeneficiarioCubit
        .changeMunicipioId(perfilBeneficiario.municipioId);
    perfilPreInversionBeneficiarioCubit
        .changeVeredaId(perfilBeneficiario.veredaId);
    perfilPreInversionBeneficiarioCubit
        .changeAreaFinca(perfilBeneficiario.areaFinca);
    perfilPreInversionBeneficiarioCubit
        .changeAreaProyecto(perfilBeneficiario.areaProyecto);
    perfilPreInversionBeneficiarioCubit
        .changeTipoTenencia(perfilBeneficiario.tipoTenenciaId);
    perfilPreInversionBeneficiarioCubit
        .changeExperiencia(perfilBeneficiario.experiencia);
    perfilPreInversionBeneficiarioCubit
        .changeAsociado(perfilBeneficiario.asociado);
    perfilPreInversionBeneficiarioCubit
        .changeConocePerfil(perfilBeneficiario.conocePerfil);
    perfilPreInversionBeneficiarioCubit
        .changeFueBeneficiado(perfilBeneficiario.fueBeneficiado);
    perfilPreInversionBeneficiarioCubit
        .changeCualBeneficio(perfilBeneficiario.cualBeneficio);

    if (perfilPreInversionBeneficiario.cotizanteBeps == '') {
      perfilPreInversionBeneficiarioCubit.changeCotizanteBeps(false);
    }
    if (perfilPreInversionBeneficiario.accesoExplotacionTierra == '') {
      perfilPreInversionBeneficiarioCubit.changeAccesoExplotacionTierra(false);
    }

    perfilPreInversionBeneficiarioCubit.savePerfilPreInversionBeneficiarioDB(
        perfilPreInversionBeneficiarioCubit
            .state.perfilPreInversionBeneficiario);
  }

  void saveExperiencia(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    final experienciaAgricolaCubit =
        BlocProvider.of<ExperienciaAgricolaCubit>(context);
    final experienciaPecuariaCubit =
        BlocProvider.of<ExperienciaPecuariaCubit>(context);
    final tipoProyecto =
        vPerfilPreInversionCubit.state.vPerfilPreInversion!.tipoProyecto;

    final beneficiarioId = beneficiarioCubit.state.beneficiario.beneficiarioId;

    if (tipoProyecto == 'Agrícola') {
      experienciaAgricolaCubit.changeBeneficiarioId(beneficiarioId);

      final experienciaAgricola =
          experienciaAgricolaCubit.state.experienciaAgricola;

      experienciaAgricolaCubit.saveExperienciaAgricolaDB(experienciaAgricola);
    } else if (tipoProyecto == 'Pecuario') {
      experienciaPecuariaCubit.changeBeneficiarioId(beneficiarioId);

      experienciaPecuariaCubit.saveExperienciaPecuariaDB(
          experienciaPecuariaCubit.state.experienciaPecuaria);
    }
  }
}
