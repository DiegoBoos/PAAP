import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/perfil_aliados/perfil_aliados_bloc.dart';
import '../../cubits/menu/menu_cubit.dart';
import '../../cubits/perfil_aliado/perfil_aliado_cubit.dart';
import '../../perfiles/widgets/perfil_drawer.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../widgets/perfil_aliado_form.dart';

class NewEditPerfilAliadoPage extends StatelessWidget {
  const NewEditPerfilAliadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final perfilAliadosBloc = BlocProvider.of<PerfilAliadosBloc>(context);
    final perfilAliadoCubit = BlocProvider.of<PerfilAliadoCubit>(context);
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    final perfilAliado = perfilAliadoCubit.state.perfilAliado;

    return BlocListener<PerfilAliadoCubit, PerfilAliadoState>(
      listener: (context, state) {
        if (state is PerfilAliadoError) {
          CustomSnackBar.showSnackBar(context, state.message, Colors.red);
        }

        if (state is PerfilAliadoSaved) {
          CustomSnackBar.showSnackBar(
              context, 'Datos guardados satisfactoriamente', Colors.green);

          final perfilId = state.perfilAliado.perfilId;
          perfilAliadosBloc.add(GetPerfilAliados(perfilId!));
        }
      },
      child: Scaffold(
          drawer: BlocBuilder<MenuCubit, MenuState>(
            builder: (context, state) {
              final menuHijo = menuCubit.perfilesMenuSorted(state.menus!);
              return PerfilDrawer(
                menuHijo: menuHijo,
              );
            },
          ),
          appBar: AppBar(
              title: Text(perfilAliado.perfilId == '' ? 'Crear' : 'Editar'),
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
                    PerfilAliadoForm(perfilAliado: perfilAliado),
                    const SizedBox(height: 20),
                    SaveBackButtons(
                      onSaved: () {
                        if (!formKey.currentState!.validate()) return;

                        formKey.currentState!.save();

                        perfilAliadoCubit.savePerfilAliadoDB();
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
