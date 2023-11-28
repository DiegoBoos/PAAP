import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/perfil_preinversion_cofinanciadores/perfil_preinversion_cofinanciadores_bloc.dart';
import '../../../ui/cubits/menu/menu_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../cubits/cofinanciador/cofinanciador_cubit.dart';
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
  bool isDesembolsoVisible = false;
  bool isActividadesVisible = false;
  bool isRubrosVisible = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CofinanciadorCubit>(context).getCofinanciadores();
    BlocProvider.of<RubroCubit>(context).getRubrosDB();

    final perfilPreInversionCofinanciadorDesembolsoCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
            context);

    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(context);

    final perfilPreInversionCofinanciadorRubroCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(context);

    if (perfilPreInversionCofinanciadorDesembolsoCubit.state
        is PerfilPreInversionCofinanciadorDesembolsoLoaded) {
      isDesembolsoVisible = true;
    }

    if (perfilPreInversionCofinanciadorActividadFinancieraCubit.state
        is PerfilPreInversionCofinanciadorActividadFinancieraLoaded) {
      isActividadesVisible = true;
    }

    if (perfilPreInversionCofinanciadorRubroCubit.state
        is PerfilPreInversionCofinanciadorRubroLoaded) {
      isRubrosVisible = true;
    }
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

    final perfilPreInversionCofinanciador = perfilPreInversionCofinanciadorCubit
        .state.perfilPreInversionCofinanciador;

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

              // Actualizar la lista de cofinanciadores
              perfilPreInversionCofinanciadoresBloc.add(
                  GetPerfilPreInversionCofinanciadores(
                      perfilPreInversion.perfilPreInversionId!));

              final perfilPreInversionCofinanciadorSaved =
                  state.perfilPreInversionCofinanciador;

              // Actualizar el monto del cofinanciador
              BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context)
                  .changeMonto(perfilPreInversionCofinanciadorSaved.monto);

              perfilPreInversionCofinanciadorDesembolsoCubit
                  .getPerfilPreInversionCofinanciadorDesembolso(
                      perfilPreInversionCofinanciadorSaved
                          .perfilPreInversionId!,
                      perfilPreInversionCofinanciadorSaved.cofinanciadorId!);

              setState(() {
                isDesembolsoVisible = true;
              });
            }
          },
        ),
        BlocListener<PerfilPreInversionCofinanciadorDesembolsoCubit,
            PerfilPreInversionCofinanciadorDesembolsoState>(
          listener: (context, state) {
            if (state is PerfilPreInversionCofinanciadorDesembolsoSaved) {
              final perfilPreInversionCofinanciadorDesembolsoSaved =
                  state.perfilPreInversionCofinanciadorDesembolso;

              perfilPreInversionCofinanciadorActividadFinancieraCubit
                  .getPerfilPreInversionCofinanciadorActividadFinanciera(
                      perfilPreInversionCofinanciadorDesembolsoSaved
                          .perfilPreInversionId!,
                      perfilPreInversionCofinanciadorDesembolsoSaved
                          .cofinanciadorId!);
              setState(() {
                isActividadesVisible = true;
              });
            }
          },
        ),
        BlocListener<PerfilPreInversionCofinanciadorActividadFinancieraCubit,
            PerfilPreInversionCofinanciadorActividadFinancieraState>(
          listener: (context, state) {
            if (state
                is PerfilPreInversionCofinanciadorActividadFinancieraSaved) {
              final perfilPreInversionCofinanciadorActividadFinancieraSaved =
                  state.perfilPreInversionCofinanciadorActividadFinanciera;

              perfilPreInversionCofinanciadorRubroCubit
                  .getPerfilPreInversionCofinanciadorRubro(
                      perfilPreInversionCofinanciadorActividadFinancieraSaved
                          .perfilPreInversionId!,
                      perfilPreInversionCofinanciadorActividadFinancieraSaved
                          .cofinanciadorId!);

              setState(() {
                isRubrosVisible = true;
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
            title: Text(perfilPreInversionCofinanciador.cofinanciadorId == null
                ? 'Crear'
                : 'Editar'),
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
                if (isDesembolsoVisible)
                  PerfilPreInversionCofinanciadorDesembolsoForm(
                      perfilPreInversionCofinanciadorDesembolso),
                if (isActividadesVisible)
                  PerfilPreInversionCofinanciadorActividadFinancieraForm(
                      perfilPreInversionCofinanciadorActividadFinanciera),
                if (isRubrosVisible)
                  PerfilPreInversionCofinanciadorRubroForm(
                      perfilPreInversionCofinanciadorRubro),
                const SizedBox(height: 20),
                SaveBackButtons(
                  onSaved: () async {
                    if (!formKeyCofinanciador.currentState!.validate()) {
                      return;
                    }

                    formKeyCofinanciador.currentState!.save();

                    savePerfilPreInversionCofinanciador();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void savePerfilPreInversionCofinanciador() {
    final vPerfilCubit = BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    final perfilPreInversion = vPerfilCubit.state.vPerfilPreInversion!;

    final perfilPreInversionCofinanciador = perfilPreInversionCofinanciadorCubit
        .state.perfilPreInversionCofinanciador;

    double participacion = 0;

    if (perfilPreInversionCofinanciador.monto != null &&
        perfilPreInversionCofinanciador.monto != '') {
      participacion = double.parse(perfilPreInversionCofinanciador.monto!) *
          100 /
          double.parse(perfilPreInversion.valorTotalProyecto!);
    }

    perfilPreInversionCofinanciadorCubit
        .changePerfilPreInversionId(perfilPreInversion.perfilId);
    perfilPreInversionCofinanciadorCubit
        .changeParticipacion(participacion.toString());
    perfilPreInversionCofinanciadorCubit
        .savePerfilPreInversionCofinanciadorDB();
  }
}
