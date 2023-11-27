import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/perfil_preinversion_beneficiarios/perfil_preinversion_beneficiarios_bloc.dart';
import '../../../ui/cubits/beneficiario/beneficiario_cubit.dart';
import '../../../ui/cubits/experiencia_agricola/experiencia_agricola_cubit.dart';
import '../../../ui/cubits/experiencia_pecuaria/experiencia_pecuaria_cubit.dart';
import '../../../ui/cubits/menu/menu_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../widgets/experiencia_agricola_form.dart';
import '../widgets/beneficiario_form.dart';
import '../widgets/experiencia_pecuaria_form.dart';
import '../widgets/perfil_beneficiario_form.dart';
import '../widgets/perfil_preinversion_beneficiario_form.dart';
import '../widgets/conyuge_form.dart';

class NewEditPerfilPreInversionBeneficiarioPage extends StatelessWidget {
  const NewEditPerfilPreInversionBeneficiarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    final perfilPreInversionBeneficiariosBloc =
        BlocProvider.of<PerfilPreInversionBeneficiariosBloc>(context);
    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    final perfilPreInversionBeneficiario = perfilPreInversionBeneficiarioCubit
        .state.perfilPreInversionBeneficiario;

    return BlocListener<PerfilPreInversionBeneficiarioCubit,
            PerfilPreInversionBeneficiarioState>(
        listener: (context, state) {
          if (state is PerfilPreInversionBeneficiarioError) {
            CustomSnackBar.showSnackBar(
                context, 'Error al cargar/guardar datos', Colors.red);
          }
          if (state is PerfilPreInversionBeneficiarioSaved) {
            CustomSnackBar.showSnackBar(
                context, 'Datos guardados satisfactoriamente', Colors.green);

            final perfilPreInversionId =
                state.perfilPreInversionBeneficiario.perfilPreInversionId!;
            perfilPreInversionBeneficiariosBloc
                .add(GetPerfilPreInversionBeneficiarios(perfilPreInversionId));
            Navigator.pop(context);
          }
        },
        child: Scaffold(
            drawer: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                final menuHijo = menuCubit.preInversionMenuSorted(state.menus!);
                return PerfilPreInversionDrawer(
                  menuHijo: menuHijo,
                );
              },
            ),
            appBar: AppBar(
                title: Text(perfilPreInversionBeneficiario.beneficiarioId == ''
                    ? 'Crear'
                    : 'Editar'),
                actions: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: NetworkIcon(),
                  )
                ]),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      BeneficiarioForm(
                          perfilPreInversionBeneficiario:
                              perfilPreInversionBeneficiario),
                      PerfilBeneficiarioForm(
                        perfilPreInversionBeneficiario:
                            perfilPreInversionBeneficiario,
                      ),
                      const PerfilPreInversionBeneficiarioForm(),
                      if (perfilPreInversionBeneficiario.estadoCivilId == '2' ||
                          perfilPreInversionBeneficiario.estadoCivilId == '5')
                        ConyugeForm(
                          perfilPreInversionBeneficiario:
                              perfilPreInversionBeneficiario,
                        ),
                      const BeneficiarioExperiencia(),
                      const SizedBox(height: 10),
                      SaveBackButtons(
                        onSaved: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          formKey.currentState!.save();

                          saveBeneficiario(context);
                          savePerfilPreInversionBeneficiario(context);
                          saveExperiencia(context);
                        },
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
            )));
  }

  void saveBeneficiario(BuildContext context) {
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    beneficiarioCubit.changeActivo(true);

    beneficiarioCubit.saveBeneficiarioDB();
  }

  void savePerfilPreInversionBeneficiario(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionBeneficiarioCubit =
        BlocProvider.of<PerfilPreInversionBeneficiarioCubit>(context);

    final perfilPreInversionId = vPerfilPreInversionCubit
        .state.vPerfilPreInversion!.perfilPreInversionId!;

    final perfilPreInversionBeneficiario = perfilPreInversionBeneficiarioCubit
        .state.perfilPreInversionBeneficiario;

    perfilPreInversionBeneficiarioCubit
        .changePerfilPreInversionId(perfilPreInversionId);

    perfilPreInversionBeneficiarioCubit.changeConocePerfil('true');

    if (perfilPreInversionBeneficiario.fueBeneficiado == '') {
      perfilPreInversionBeneficiarioCubit.changeFueBeneficiado('false');
    }
    if (perfilPreInversionBeneficiario.activo == '') {
      perfilPreInversionBeneficiarioCubit.changeActivo('false');
    }
    if (perfilPreInversionBeneficiario.cotizanteBeps == '') {
      perfilPreInversionBeneficiarioCubit.changeCotizanteBeps(false);
    }
    if (perfilPreInversionBeneficiario.accesoExplotacionTierra == '') {
      perfilPreInversionBeneficiarioCubit.changeAccesoExplotacionTierra(false);
    }

    perfilPreInversionBeneficiarioCubit.savePerfilPreInversionBeneficiarioDB();
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

    final beneficiarioId = beneficiarioCubit.state.beneficiario.beneficiarioId!;

    if (tipoProyecto == 'Agrícola') {
      experienciaAgricolaCubit.changeBeneficiarioId(beneficiarioId);

      final experienciaAgricola =
          experienciaAgricolaCubit.state.experienciaAgricola;

      experienciaAgricolaCubit.saveExperienciaAgricolaDB(experienciaAgricola);
    } else if (tipoProyecto == 'Pecuario') {
      experienciaPecuariaCubit.changeBeneficiarioId(beneficiarioId);

      experienciaPecuariaCubit.saveExperienciaPecuariaDB();
    }
  }
}

class BeneficiarioExperiencia extends StatelessWidget {
  const BeneficiarioExperiencia({super.key});

  @override
  Widget build(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final experienciaAgricolaCubit =
        BlocProvider.of<ExperienciaAgricolaCubit>(context);
    final experienciaPecuariaCubit =
        BlocProvider.of<ExperienciaPecuariaCubit>(context);
    final tipoProyecto =
        vPerfilPreInversionCubit.state.vPerfilPreInversion!.tipoProyecto;

    return BlocListener<BeneficiarioCubit, BeneficiarioState>(
      listener: (context, state) {
        if (state is BeneficiarioLoaded) {
          final beneficiarioId = state.beneficiarioLoaded.beneficiarioId!;

          if (tipoProyecto == 'Agrícola') {
            experienciaAgricolaCubit.loadExperienciaAgricola(
                '1', beneficiarioId);
          } else if (tipoProyecto == 'Pecuario') {
            experienciaPecuariaCubit.loadExperienciaPecuaria(
                '1', beneficiarioId);
          }
        }
      },
      child: Column(
        children: [
          BlocBuilder<ExperienciaAgricolaCubit, ExperienciaAgricolaState>(
            builder: (context, state) {
              if (state is ExperienciaAgricolaLoaded) {
                return const ExperienciaAgricolaForm();
              } else {
                return Container();
              }
            },
          ),
          BlocBuilder<ExperienciaPecuariaCubit, ExperienciaPecuariaState>(
            builder: (context, state) {
              if (state is ExperienciaPecuariaLoaded) {
                return const ExperienciaPecuariaForm();
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
