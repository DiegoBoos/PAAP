import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_bloc.dart';
import '../../../domain/blocs/perfil_preinversion_cofinanciador_desembolsos/perfil_preinversion_cofinanciador_desembolsos_bloc.dart';
import '../../../domain/blocs/perfil_preinversion_cofinanciador_rubros/perfil_preinversion_cofinanciador_rubros_bloc.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_cofinanciador_actividad_financiera_form.dart';
import '../widgets/perfil_preinversion_cofinanciador_desembolso_form.dart';
import '../widgets/perfil_preinversion_cofinanciador_form.dart';
import '../widgets/perfil_preinversion_cofinanciador_rubro_form.dart';

class NewEditPerfilPreInversionCofinanciadorPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  NewEditPerfilPreInversionCofinanciadorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    final perfilPreInversionCofinanciadorDesembolsosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsosBloc>(
            context);

    final perfilPreInversionCofinanciadorActividadesFinancierasBloc =
        BlocProvider.of<
            PerfilPreInversionCofinanciadorActividadesFinancierasBloc>(context);

    final perfilPreInversionCofinanciadorRubrosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubrosBloc>(context);

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
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('COFINANCIADOR', style: Styles.titleStyle),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: BlocBuilder<PerfilPreInversionCofinanciadorCubit,
                    PerfilPreInversionCofinanciadorState>(
                  builder: (context, state) {
                    if (state is PerfilPreInversionCofinanciadorInitial) {
                      return Column(
                        children: [
                          const Text('Creación', style: Styles.subtitleStyle),
                          const PerfilPreInversionCofinanciadorForm(),
                          const SizedBox(height: 20),
                          SaveBackButtons(onSaved: () {})
                        ],
                      );
                    }
                    if (state is PerfilPreInversionCofinanciadorLoaded) {
                      final perfilPreInversionCofinanciadorLoaded =
                          state.perfilPreInversionCofinanciadorLoaded!;

                      final cofinanciadorId =
                          perfilPreInversionCofinanciadorLoaded.cofinanciadorId;

                      perfilPreInversionCofinanciadorDesembolsosBloc.add(
                          GetPerfilPreInversionCofinanciadorDesembolsos(
                              cofinanciadorId: cofinanciadorId));

                      perfilPreInversionCofinanciadorActividadesFinancierasBloc.add(
                          GetPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
                              cofinanciadorId: cofinanciadorId));

                      perfilPreInversionCofinanciadorRubrosBloc.add(
                          GetPerfilPreInversionCofinanciadorRubros(
                              cofinanciadorId: cofinanciadorId));

                      return Column(
                        children: [
                          const Text('Editar', style: Styles.subtitleStyle),
                          const PerfilPreInversionCofinanciadorForm(),
                          const PerfilPreInversionCofinanciadorDesembolsoForm(),
                          const PerfilPreInversionCofinanciadorActividadFinancieraForm(),
                          const PerfilPreInversionCofinanciadorRubroForm(),
                          const SizedBox(height: 20),
                          SaveBackButtons(onSaved: () {})
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ]),
        ));
  }
}
