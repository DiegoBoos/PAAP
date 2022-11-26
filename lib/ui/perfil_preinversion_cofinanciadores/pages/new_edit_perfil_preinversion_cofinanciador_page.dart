import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_bloc.dart';
import '../../../domain/blocs/perfil_preinversion_cofinanciador_desembolsos/perfil_preinversion_cofinanciador_desembolsos_bloc.dart';
import '../../../domain/blocs/perfil_preinversion_cofinanciador_rubros/perfil_preinversion_cofinanciador_rubros_bloc.dart';
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
  @override
  void deactivate() {
    super.deactivate();

    BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(
      context,
    ).initState();

    BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
      context,
    ).initState();

    BlocProvider.of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(
      context,
    ).initState();
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context,
            listen: true);

    final perfilPreInversionCofinanciadorDesembolsoCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
      context,
    );

    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(
      context,
    );

    final perfilPreInversionCofinanciadorDesembolsosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsosBloc>(
            context);

    final perfilPreInversionCofinanciadorActividadesFinancierasBloc =
        BlocProvider.of<
            PerfilPreInversionCofinanciadorActividadesFinancierasBloc>(context);

    final perfilPreInversionCofinanciadorRubrosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubrosBloc>(context);

    final perfilPreInversionCofinanciador = perfilPreInversionCofinanciadorCubit
        .state.perfilPreInversionCofinanciador;

    if (perfilPreInversionCofinanciador.isEditing) {
      final cofinanciadorId = perfilPreInversionCofinanciador.cofinanciadorId;
      final vPerfilPreInversionId = vPerfilPreInversionCubit
          .state.vPerfilPreInversion!.perfilPreInversionId;

      perfilPreInversionCofinanciadorDesembolsosBloc.add(
          GetPerfilPreInversionCofinanciadorDesembolsosByCofinanciador(
              perfilPreInversionId: vPerfilPreInversionId,
              cofinanciadorId: cofinanciadorId));

      perfilPreInversionCofinanciadorActividadesFinancierasBloc.add(
          GetPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
              perfilPreInversionId: vPerfilPreInversionId,
              cofinanciadorId: cofinanciadorId));

      perfilPreInversionCofinanciadorRubrosBloc.add(
          GetPerfilPreInversionCofinanciadorRubrosByCofinanciador(
              perfilPreInversionId: vPerfilPreInversionId,
              cofinanciadorId: cofinanciadorId));
    }

    final perfilPreInversionCofinanciadorDesembolso =
        perfilPreInversionCofinanciadorDesembolsoCubit
            .state.perfilPreInversionCofinanciadorDesembolso;

    final perfilPreInversionCofinanciadorActividadFinanciera =
        perfilPreInversionCofinanciadorActividadFinancieraCubit
            .state.perfilPreInversionCofinanciadorActividadFinanciera;

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
          AppBar(title: const Text('Detalle Cofinanciador'), actions: const [
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  perfilPreInversionCofinanciador.isEditing
                      ? 'Editar'
                      : 'Creación',
                  style: Styles.subtitleStyle),
              const SizedBox(height: 20),
              perfilPreInversionCofinanciador.isEditing
                  ? Column(
                      children: [
                        const PerfilPreInversionCofinanciadorForm(),
                        const PerfilPreInversionCofinanciadorDesembolsoForm(),
                        const PerfilPreInversionCofinanciadorActividadFinancieraForm(),
                        const PerfilPreInversionCofinanciadorRubroForm(),
                        const SizedBox(height: 20),
                        SaveBackButtons(
                            onSaved: () {
                              savePerfilPreInversionCofinanciador(context);
                              savePerfilPreInversionDesembolso();
                              savePerfilPreInversionActividadFinanciera();
                              savePerfilPreInversionRubro();
                            },
                            routeName: 'VCofinanciadoresPreInversion')
                      ],
                    )
                  : Column(
                      children: [
                        const PerfilPreInversionCofinanciadorForm(),
                        if (perfilPreInversionCofinanciador.canCreateDesembolso)
                          const PerfilPreInversionCofinanciadorDesembolsoForm(),
                        if (perfilPreInversionCofinanciadorDesembolso
                            .canCreateActividadFinanciera)
                          const PerfilPreInversionCofinanciadorActividadFinancieraForm(),
                        if (perfilPreInversionCofinanciadorActividadFinanciera
                            .canCreateRubro)
                          const PerfilPreInversionCofinanciadorRubroForm(),
                        const SizedBox(height: 20),
                        SaveBackButtons(
                            onSaved: () {
                              savePerfilPreInversionCofinanciador(context);
                              savePerfilPreInversionDesembolso();
                              savePerfilPreInversionActividadFinanciera();
                              savePerfilPreInversionRubro();
                            },
                            routeName: 'VCofinanciadoresPreInversion')
                      ],
                    ),
            ],
          ),
        ]),
      ),
    );
  }

  void savePerfilPreInversionCofinanciador(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context,
            listen: true);
    final perfilPreInversionId = vPerfilPreInversionCubit
        .state.vPerfilPreInversion!.perfilPreInversionId;

    perfilPreInversionCofinanciadorCubit
        .changePerfilPreInversionId(perfilPreInversionId);

    perfilPreInversionCofinanciadorCubit.savePerfilPreInversionCofinanciadorDB(
        perfilPreInversionCofinanciadorCubit
            .state.perfilPreInversionCofinanciador);
  }

  void savePerfilPreInversionDesembolso() {}

  void savePerfilPreInversionActividadFinanciera() {}

  void savePerfilPreInversionRubro() {}
}
