import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/perfil_aliados/perfil_aliados_bloc.dart';
import '../../cubits/aliado/aliado_cubit.dart';
import '../../cubits/menu/menu_cubit.dart';
import '../../cubits/perfil_aliado/perfil_aliado_cubit.dart';
import '../../cubits/v_perfil/v_perfil_cubit.dart';
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
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    final perfilAliadosBloc = BlocProvider.of<PerfilAliadosBloc>(context);
    final perfilAliadoCubit = BlocProvider.of<PerfilAliadoCubit>(context);

    final perfilAliado = perfilAliadoCubit.state.perfilAliado;

    return BlocListener<PerfilAliadoCubit, PerfilAliadoState>(
      listener: (context, state) {
        if (state is PerfilAliadoError) {
          CustomSnackBar.showSnackBar(context, state.message, Colors.red);
        }

        if (state is PerfilAliadoSaved) {
          CustomSnackBar.showSnackBar(
              context, 'Datos guardados satisfactoriamente', Colors.green);

          final perfilId = state.perfilAliado.perfilId!;
          perfilAliadosBloc.add(GetPerfilAliados(perfilId));
          Navigator.pop(context);
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
              title: Text(perfilAliado.perfilId == null ? 'Crear' : 'Editar'),
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

                        saveAliado(context);
                        savePerfilAliado(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void saveAliado(BuildContext context) {
    final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
    if (aliadoCubit.state.aliado.activo == null) {
      aliadoCubit.changeActivo('true');
    }
    if (aliadoCubit.state.aliado.fechaCreacion == null) {
      aliadoCubit.changeFechaCreacion(DateTime.now().toString());
    }
    if (aliadoCubit.state.aliado.fechaCambio == null) {
      aliadoCubit.changeFechaCambio(DateTime.now().toString());
    }
    if (aliadoCubit.state.aliado.fechaActivacion == null) {
      aliadoCubit.changeFechaActivacion(DateTime.now().toString());
    }
    if (aliadoCubit.state.aliado.fechaDesactivacion == null) {
      aliadoCubit.changeFechaDesactivacion(DateTime.now().toString());
    }
    aliadoCubit.saveAliadoDB();
  }

  void savePerfilAliado(BuildContext context) {
    final vPerfilCubit = BlocProvider.of<VPerfilCubit>(context);
    final perfilAliadoCubit = BlocProvider.of<PerfilAliadoCubit>(context);
    final perfilAliado = perfilAliadoCubit.state.perfilAliado;

    final perfilId = vPerfilCubit.state.vPerfil!.perfilId!;
    final aliadoId = perfilAliado.aliadoId;

    perfilAliadoCubit.changePerfilId(perfilId);
    perfilAliadoCubit.changeAliadoId(aliadoId);

    perfilAliadoCubit.savePerfilAliadoDB();
  }
}
