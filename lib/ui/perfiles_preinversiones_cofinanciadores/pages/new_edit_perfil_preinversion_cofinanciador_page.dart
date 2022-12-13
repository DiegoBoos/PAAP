import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_cofinanciadores/perfil_preinversion_cofinanciadores_bloc.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
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

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    final perfilPreInversionCofinanciadoresBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadoresBloc>(context);

    final perfilPreInversion =
        vPerfilPreInversionCubit.state.vPerfilPreInversion!;

    return MultiBlocListener(
        listeners: [
          BlocListener<PerfilPreInversionCofinanciadorCubit,
              PerfilPreInversionCofinanciadorState>(
            listener: (context, state) {
              if (state is PerfilPreInversionCofinanciadorSaved) {
                perfilPreInversionCofinanciadoresBloc.add(
                    GetPerfilPreInversionCofinanciadores(
                        vPerfilPreInversionCubit
                            .state.vPerfilPreInversion!.perfilPreInversionId));

                setState(() {
                  isPerfilPreInversionCofinanciadorDesembolsoEnabled = true;
                });
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
              title: const Text('Detalle Cofinanciador'),
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: NetworkIcon(),
                )
              ]),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(children: [
              const SizedBox(height: 30),
              const Text('COFINANCIADOR', style: Styles.titleStyle),
              const SizedBox(height: 20),
              Form(
                key: formKeyCofinanciador,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<PerfilPreInversionCofinanciadorCubit,
                        PerfilPreInversionCofinanciadorState>(
                      builder: (context, state) {
                        if (state is PerfilPreInversionCofinanciadorLoaded) {
                          return const Text('Editar',
                              style: Styles.subtitleStyle);
                        } else {
                          return const Text('Creación',
                              style: Styles.subtitleStyle);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    const PerfilPreInversionCofinanciadorForm(),
                    if (isPerfilPreInversionCofinanciadorDesembolsoEnabled)
                      const PerfilPreInversionCofinanciadorDesembolsoForm(),
                    if (isPerfilPreInversionCofinanciadorActividadFinancieraEnabled)
                      const PerfilPreInversionCofinanciadorActividadFinancieraForm(),
                    if (isPerfilPreInversionCofinanciadorRubroEnabled)
                      const PerfilPreInversionCofinanciadorRubroForm(),
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
                                perfilPreInversionCofinanciadorCubit.state
                                    .perfilPreInversionCofinanciador.monto) *
                            100 /
                            double.parse(perfilPreInversion.valorTotalProyecto);

                        perfilPreInversionCofinanciadorCubit
                            .changeParticipacion(participacion.toString());

                        perfilPreInversionCofinanciadorCubit
                            .savePerfilPreInversionCofinanciadorDB(
                                perfilPreInversionCofinanciadorCubit
                                    .state.perfilPreInversionCofinanciador);
                      },
                    )
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
