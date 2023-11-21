import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/aliado/aliado_exports.dart';
import '../../blocs/aliados/aliados_bloc.dart';
import '../../cubits/menu/menu_cubit.dart';
import '../../perfiles/widgets/perfil_drawer.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../widgets/aliado_form.dart';

class NewEditAliadoPage extends StatelessWidget {
  const NewEditAliadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final aliadosBloc = BlocProvider.of<AliadosBloc>(context);
    final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    final aliado = ModalRoute.of(context)?.settings.arguments as AliadoEntity?;

    return BlocListener<AliadoCubit, AliadoState>(
      listener: (context, state) {
        if (state is AliadoError) {
          CustomSnackBar.showSnackBar(context, state.message, Colors.red);
        }

        if (state is AliadoSaved) {
          CustomSnackBar.showSnackBar(
              context, 'Datos guardados satisfactoriamente', Colors.green);
          //TODO: perfilId
          aliadosBloc.add(const GetAliados("1"));
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
              title: Text(aliado?.aliadoId == '' ? 'Crear' : 'Editar'),
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
                    AliadoForm(aliado: aliado),
                    const SizedBox(height: 20),
                    SaveBackButtons(
                      onSaved: () {
                        if (!formKey.currentState!.validate()) return;

                        formKey.currentState!.save();

                        aliadoCubit.saveAliadoDB(aliadoCubit.state.aliado);
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
