import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/perfil_preinversion_aliados/perfil_preinversion_aliados_bloc.dart';
import '../../../ui/cubits/aliado/aliado_cubit.dart';
import '../../../ui/cubits/menu/menu_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_aliado/perfil_preinversion_aliado_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
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

    final perfilPreInversionAliado =
        perfilPreInversionAliadoCubit.state.perfilPreInversionAliado;

    return BlocListener<PerfilPreInversionAliadoCubit,
        PerfilPreInversionAliadoState>(
      listener: (context, state) {
        if (state is PerfilPreInversionAliadoError) {
          CustomSnackBar.showSnackBar(context, state.message, Colors.red);
        }

        if (state is PerfilPreInversionAliadoSaved) {
          CustomSnackBar.showSnackBar(
              context, 'Datos guardados satisfactoriamente', Colors.green);

          perfilPreInversionAliadosBloc.add(GetPerfilPreInversionAliados(
              vPerfilPreInversionCubit
                  .state.vPerfilPreInversion!.perfilPreInversionId!));
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
              title: Text(
                  perfilPreInversionAliado.aliadoId == '' ? 'Crear' : 'Editar'),
              actions: const [
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
                child: Column(
                  children: [
                    PerfilPreInversionAliadoForm(
                        perfilPreInversionAliado: perfilPreInversionAliado),
                    const SizedBox(height: 20),
                    SaveBackButtons(
                      onSaved: () {
                        if (!formKey.currentState!.validate()) return;

                        formKey.currentState!.save();

                        final vPerfilPreInversionId = vPerfilPreInversionCubit
                            .state.vPerfilPreInversion!.perfilPreInversionId;

                        aliadoCubit.saveAliadoDB(aliadoCubit.state.aliado);

                        perfilPreInversionAliadoCubit
                            .changePerfilPreInversionId(vPerfilPreInversionId!);

                        perfilPreInversionAliadoCubit
                            .savePerfilPreInversionAliadoDB();
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
