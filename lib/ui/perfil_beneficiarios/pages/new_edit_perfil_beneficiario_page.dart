import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/perfil_beneficiarios/perfil_beneficiarios_bloc.dart';
import '../../cubits/menu/menu_cubit.dart';
import '../../cubits/perfil_beneficiario/perfil_beneficiario_cubit.dart';
import '../../cubits/v_perfil/v_perfil_cubit.dart';
import '../../perfiles/widgets/perfil_drawer.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../widgets/perfil_beneficiario_form.dart';

class NewEditPerfilBeneficiarioPage extends StatelessWidget {
  const NewEditPerfilBeneficiarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    final vPerfilCubit = BlocProvider.of<VPerfilCubit>(context);
    final perfilBeneficiariosBloc =
        BlocProvider.of<PerfilBeneficiariosBloc>(context);
    final perfilBeneficiarioCubit =
        BlocProvider.of<PerfilBeneficiarioCubit>(context);

    final perfilId = vPerfilCubit.state.vPerfil!.perfilId!;

    final perfilBeneficiario = perfilBeneficiarioCubit.state.perfilBeneficiario;

    return BlocListener<PerfilBeneficiarioCubit, PerfilBeneficiarioState>(
        listener: (context, state) {
          if (state is PerfilBeneficiarioError) {
            CustomSnackBar.showSnackBar(
                context, 'Error al guardar datos', Colors.red);
          }
          if (state is PerfilBeneficiarioSaved) {
            CustomSnackBar.showSnackBar(
                context, 'Datos guardados satisfactoriamente', Colors.green);

            perfilBeneficiariosBloc.add(GetPerfilBeneficiarios(perfilId));
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
              title: Text(
                  perfilBeneficiario.beneficiarioId == '' ? 'Crear' : 'Editar'),
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
                    PerfilBeneficiarioForm(
                        perfilBeneficiario: perfilBeneficiario),
                    const SizedBox(height: 10),
                    SaveBackButtons(
                      onSaved: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        formKey.currentState!.save();

                        perfilBeneficiarioCubit.savePerfilBeneficiarioDB();
                      },
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
