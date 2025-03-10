import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/perfil_cofinanciadores/perfil_cofinanciadores_bloc.dart';
import '../../cubits/menu/menu_cubit.dart';
import '../../cubits/perfil_cofinanciador/perfil_cofinanciador_cubit.dart';
import '../../cubits/cofinanciador/cofinanciador_cubit.dart';
import '../../cubits/rubro/rubro_cubit.dart';
import '../../cubits/v_perfil/v_perfil_cubit.dart';
import '../../perfiles/widgets/perfil_drawer.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../widgets/perfil_cofinanciador_form.dart';

class NewEditPerfilCofinanciadorPage extends StatefulWidget {
  const NewEditPerfilCofinanciadorPage({super.key});

  @override
  State<NewEditPerfilCofinanciadorPage> createState() =>
      _NewEditPerfilCofinanciadorPageState();
}

class _NewEditPerfilCofinanciadorPageState
    extends State<NewEditPerfilCofinanciadorPage> {
  final formKeyCofinanciador = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CofinanciadorCubit>(context).getCofinanciadores();
    BlocProvider.of<RubroCubit>(context).getRubrosDB();
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    final perfilCofinanciadoresBloc =
        BlocProvider.of<PerfilCofinanciadoresBloc>(context);

    final perfilCofinanciadorCubit =
        BlocProvider.of<PerfilCofinanciadorCubit>(context);

    final perfilCofinanciador =
        perfilCofinanciadorCubit.state.perfilCofinanciador;

    return MultiBlocListener(
      listeners: [
        BlocListener<PerfilCofinanciadorCubit, PerfilCofinanciadorState>(
          listener: (context, state) {
            if (state is PerfilCofinanciadorSaved) {
              CustomSnackBar.showSnackBar(
                  context, 'Datos guardados satisfactoriamente', Colors.green);

              final perfilCofinanciadorSaved = state.perfilCofinanciador;

              // Actualizar el monto del cofinanciador
              BlocProvider.of<PerfilCofinanciadorCubit>(context)
                  .changeMonto(perfilCofinanciadorSaved.monto);

              perfilCofinanciadoresBloc.add(
                  GetPerfilCofinanciadores(perfilCofinanciadorSaved.perfilId!));

              Navigator.pop(context);
            }
          },
        ),
      ],
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
            title: Text(perfilCofinanciador.cofinanciadorId == null
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
                      return PerfilCofinanciadorForm(
                        cofinanciadores: state.cofinanciadoresLoaded!,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(height: 20),
                SaveBackButtons(
                  onSaved: () async {
                    if (!formKeyCofinanciador.currentState!.validate()) {
                      return;
                    }

                    formKeyCofinanciador.currentState!.save();
                    savePerfilCofinanciador();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void savePerfilCofinanciador() {
    final vPerfilCubit = BlocProvider.of<VPerfilCubit>(context);

    final perfilCofinanciadorCubit =
        BlocProvider.of<PerfilCofinanciadorCubit>(context);

    final perfil = vPerfilCubit.state.vPerfil!;

    final perfilCofinanciador =
        perfilCofinanciadorCubit.state.perfilCofinanciador;

    double participacion = 0;

    if (perfilCofinanciador.monto != null && perfilCofinanciador.monto != '') {
      participacion = double.parse(perfilCofinanciador.monto!) *
          100 /
          double.parse(perfil.valorTotalProyecto!);
    }

    perfilCofinanciadorCubit.changePerfilId(perfil.perfilId);
    perfilCofinanciadorCubit.changeParticipacion(participacion.toString());
    perfilCofinanciadorCubit.savePerfilCofinanciadorDB();
  }
}
