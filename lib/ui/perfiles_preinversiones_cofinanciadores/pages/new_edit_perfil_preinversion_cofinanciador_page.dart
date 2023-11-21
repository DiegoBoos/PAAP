import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/cubits/cofinanciador/cofinanciador_cubit.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../../ui/blocs/perfil_preinversion_cofinanciadores/perfil_preinversion_cofinanciadores_bloc.dart';
import '../../../ui/cubits/menu/menu_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../cubits/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_cubit.dart';
import '../../cubits/rubro/rubro_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../widgets/perfil_preinversion_cofinanciador_actividad_financiera_form.dart';
import '../widgets/perfil_preinversion_cofinanciador_desembolso_form.dart';
import '../widgets/perfil_preinversion_cofinanciador_form.dart';
import '../widgets/perfil_preinversion_cofinanciador_rubro_form.dart';

class NewEditPerfilPreInversionCofinanciadorPage extends StatefulWidget {
  const NewEditPerfilPreInversionCofinanciadorPage({super.key});

  @override
  State<NewEditPerfilPreInversionCofinanciadorPage> createState() =>
      _NewEditPerfilPreInversionCofinanciadorPageState();
}

class _NewEditPerfilPreInversionCofinanciadorPageState
    extends State<NewEditPerfilPreInversionCofinanciadorPage> {
  final formKeyCofinanciador = GlobalKey<FormState>();

  bool isPerfilPreInversionCofinanciadorDesembolsoEnabled = false;
  bool isPerfilPreInversionCofinanciadorActividadFinancieraEnabled = false;
  bool isPerfilPreInversionCofinanciadorRubroEnabled = false;

  @override
  void initState() {
    super.initState();
    final perfilPreInversionCofinanciadorDesembolsoCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
            context);

    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(context);

    setState(() {
      if (perfilPreInversionCofinanciadorDesembolsoCubit.state
          is PerfilPreInversionCofinanciadorDesembolsoLoaded) {
        isPerfilPreInversionCofinanciadorDesembolsoEnabled = true;
        isPerfilPreInversionCofinanciadorActividadFinancieraEnabled = true;
      }

      if (perfilPreInversionCofinanciadorActividadFinancieraCubit.state
          is PerfilPreInversionCofinanciadorActividadFinancieraLoaded) {
        isPerfilPreInversionCofinanciadorActividadFinancieraEnabled = true;
        isPerfilPreInversionCofinanciadorRubroEnabled = true;
      }
    });

    BlocProvider.of<CofinanciadorCubit>(context).getCofinanciadores();
    BlocProvider.of<RubroCubit>(context).getRubrosDB();
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);
    final perfilPreInversionCofinanciadorDesembolsoCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
            context);
    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(context);
    final perfilPreInversionCofinanciadorRubroCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(context);

    final perfilPreInversionCofinanciadoresBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadoresBloc>(context);

    final perfilPreInversion =
        vPerfilPreInversionCubit.state.vPerfilPreInversion!;

    final perfilPreInversionCofinanciador = ModalRoute.of(context)!
        .settings
        .arguments as PerfilPreInversionCofinanciadorEntity?;
    final perfilPreInversionCofinanciadorDesembolso =
        perfilPreInversionCofinanciadorDesembolsoCubit
            .state.perfilPreInversionCofinanciadorDesembolso;
    final perfilPreInversionCofinanciadorActividadFinanciera =
        perfilPreInversionCofinanciadorActividadFinancieraCubit
            .state.perfilPreInversionCofinanciadorActividadFinanciera;
    final perfilPreInversionCofinanciadorRubro =
        perfilPreInversionCofinanciadorRubroCubit
            .state.perfilPreInversionCofinanciadorRubro;

    return MultiBlocListener(
      listeners: [
        BlocListener<PerfilPreInversionCofinanciadorCubit,
            PerfilPreInversionCofinanciadorState>(
          listener: (context, state) {
            if (state is PerfilPreInversionCofinanciadorSaved) {
              CustomSnackBar.showSnackBar(
                  context, 'Datos guardados satisfactoriamente', Colors.green);

              setState(() {
                isPerfilPreInversionCofinanciadorDesembolsoEnabled = true;
              });

              perfilPreInversionCofinanciadoresBloc.add(
                  GetPerfilPreInversionCofinanciadores(
                      perfilPreInversion.perfilPreInversionId));
            }
          },
        ),
        BlocListener<PerfilPreInversionCofinanciadorDesembolsoCubit,
            PerfilPreInversionCofinanciadorDesembolsoState>(
          listener: (context, state) {
            if (state is PerfilPreInversionCofinanciadorDesembolsoSaved) {
              setState(() {
                isPerfilPreInversionCofinanciadorActividadFinancieraEnabled =
                    true;
              });
            }
          },
        ),
        BlocListener<PerfilPreInversionCofinanciadorActividadFinancieraCubit,
            PerfilPreInversionCofinanciadorActividadFinancieraState>(
          listener: (context, state) {
            if (state
                is PerfilPreInversionCofinanciadorActividadFinancieraSaved) {
              setState(() {
                isPerfilPreInversionCofinanciadorRubroEnabled = true;
              });
            }
          },
        ),
      ],
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
            title: BlocBuilder<PerfilPreInversionCofinanciadorCubit,
                PerfilPreInversionCofinanciadorState>(
              builder: (context, state) {
                if (state is PerfilPreInversionCofinanciadorLoaded) {
                  return const Text('Editar');
                } else {
                  return const Text('Crear');
                }
              },
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: NetworkIcon(),
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKeyCofinanciador,
            child: ListView(
              children: [
                BlocBuilder<CofinanciadorCubit, CofinanciadorState>(
                  builder: (context, state) {
                    if (state is CofinanciadoresLoaded) {
                      return PerfilPreInversionCofinanciadorForm(
                        perfilPreInversionCofinanciador:
                            perfilPreInversionCofinanciador,
                        cofinanciadores: state.cofinanciadoresLoaded!,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                if (isPerfilPreInversionCofinanciadorDesembolsoEnabled)
                  PerfilPreInversionCofinanciadorDesembolsoForm(
                    perfilPreInversionCofinanciadorDesembolso:
                        perfilPreInversionCofinanciadorDesembolso,
                  ),
                if (isPerfilPreInversionCofinanciadorActividadFinancieraEnabled)
                  PerfilPreInversionCofinanciadorActividadFinancieraForm(
                    perfilPreInversionCofinanciadorActividadFinanciera:
                        perfilPreInversionCofinanciadorActividadFinanciera,
                  ),
                if (isPerfilPreInversionCofinanciadorRubroEnabled)
                  PerfilPreInversionCofinanciadorRubroForm(
                    perfilPreInversionCofinanciadorRubro:
                        perfilPreInversionCofinanciadorRubro,
                  ),
                const SizedBox(height: 20),
                SaveBackButtons(
                  onSaved: () async {
                    if (!formKeyCofinanciador.currentState!.validate()) {
                      return;
                    }

                    formKeyCofinanciador.currentState!.save();

                    perfilPreInversionCofinanciadorCubit
                        .changePerfilPreInversionId(
                            perfilPreInversion.perfilPreInversionId);

                    final participacion = double.parse(
                            perfilPreInversionCofinanciadorCubit
                                .state.perfilPreInversionCofinanciador.monto) *
                        100 /
                        double.parse(perfilPreInversion.valorTotalProyecto);

                    perfilPreInversionCofinanciadorCubit
                        .changeParticipacion(participacion.toString());

                    perfilPreInversionCofinanciadorCubit
                        .savePerfilPreInversionCofinanciadorDB(
                            perfilPreInversionCofinanciador!);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
