import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/beneficiario_entity.dart';
import '../../blocs/beneficiarios/beneficiarios_bloc.dart';
import '../../cubits/beneficiario/beneficiario_cubit.dart';
import '../../cubits/menu/menu_cubit.dart';
import '../../cubits/v_perfil/v_perfil_cubit.dart';
import '../../perfiles/widgets/perfil_drawer.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../widgets/beneficiario_form.dart';

class NewEditBeneficiarioPage extends StatelessWidget {
  const NewEditBeneficiarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    final vPerfilCubit = BlocProvider.of<VPerfilCubit>(context);
    final beneficiariosBloc = BlocProvider.of<BeneficiariosBloc>(context);
    final beneficiarioCubit = BlocProvider.of<BeneficiarioCubit>(context);
    final beneficiario =
        ModalRoute.of(context)!.settings.arguments as BeneficiarioEntity?;

    return BlocListener<BeneficiarioCubit, BeneficiarioState>(
        listener: (context, state) {
          if (state is BeneficiarioError) {
            CustomSnackBar.showSnackBar(
                context, 'Error al guardar datos', Colors.red);
          }
          if (state is BeneficiarioSaved) {
            CustomSnackBar.showSnackBar(
                context, 'Datos guardados satisfactoriamente', Colors.green);

            beneficiariosBloc
                .add(GetBeneficiarios(vPerfilCubit.state.vPerfil!.perfilId));
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
              title:
                  Text(beneficiario?.beneficiarioId == '' ? 'Crear' : 'Editar'),
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
                    BeneficiarioForm(beneficiario: beneficiario),
                    const SizedBox(height: 10),
                    SaveBackButtons(
                      onSaved: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        formKey.currentState!.save();

                        beneficiarioCubit.saveBeneficiarioDB(
                            beneficiarioCubit.state.beneficiario);
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
