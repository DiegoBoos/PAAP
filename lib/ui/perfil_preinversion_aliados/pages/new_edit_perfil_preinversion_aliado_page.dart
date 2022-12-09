import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/utils/custom_snack_bar.dart';

import '../../../domain/blocs/perfil_preinversion_aliados/perfil_preinversion_aliados_bloc.dart';
import '../../../domain/cubits/aliado/aliado_cubit.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_aliado/perfil_preinversion_aliado_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_aliado_form.dart';

class NewEditPerfilPreInversionAliadoPage extends StatelessWidget {
  const NewEditPerfilPreInversionAliadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final perfilPreInversionAliadoCubit =
        BlocProvider.of<PerfilPreInversionAliadoCubit>(context);
    final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionAliadosBloc =
        BlocProvider.of<PerfilPreInversionAliadosBloc>(context);

    return BlocListener<PerfilPreInversionAliadoCubit,
            PerfilPreInversionAliadoState>(
        listener: (context, state) {
          if (state is PerfilPreInversionAliadoSaved) {
            CustomSnackBar.showSnackBar(
                context, 'Datos guardados satisfactoriamente', Colors.green);

            perfilPreInversionAliadosBloc.add(GetPerfilPreInversionAliados(
                vPerfilPreInversionCubit
                    .state.vPerfilPreInversion!.perfilPreInversionId));
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
            appBar: AppBar(title: const Text('Detalle Aliado'), actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: NetworkIcon(),
              )
            ]),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: (ListView(children: [
                const SizedBox(height: 20),
                const Text('ALIADO', style: Styles.titleStyle),
                const SizedBox(height: 20),
                BlocBuilder<PerfilPreInversionAliadoCubit,
                    PerfilPreInversionAliadoState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text(
                            state.perfilPreInversionAliado.aliadoId == ''
                                ? 'Creación'
                                : 'Editar',
                            style: Styles.subtitleStyle),
                        const SizedBox(height: 20),
                        Form(
                            key: formKey,
                            child: PerfilPreInversionAliadoForm(formKey)),
                        const SizedBox(height: 20),
                        SaveBackButtons(
                          onSaved: () {
                            if (!formKey.currentState!.validate()) return;

                            formKey.currentState!.save();

                            final vPerfilPreInversionId =
                                vPerfilPreInversionCubit.state
                                    .vPerfilPreInversion!.perfilPreInversionId;

                            aliadoCubit.saveAliadoDB(aliadoCubit.state.aliado);

                            perfilPreInversionAliadoCubit
                                .changePerfilPreInversionId(
                                    vPerfilPreInversionId);

                            perfilPreInversionAliadoCubit
                                .savePerfilPreInversionAliadoDB(
                                    perfilPreInversionAliadoCubit
                                        .state.perfilPreInversionAliado);
                          },
                        )
                      ],
                    );
                  },
                ),
              ])),
            )));
  }
}
