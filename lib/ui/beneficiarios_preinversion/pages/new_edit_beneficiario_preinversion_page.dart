import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/usecases/beneficiario_preinversion/beneficiario_preinversion_exports.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/beneficiario_form.dart';
import '../widgets/beneficiarios_preinversion_drawer.dart';

class NewEditBeneficiarioPreinversionPage extends StatelessWidget {
  const NewEditBeneficiarioPreinversionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final beneficiarioPreinversion = ModalRoute.of(context)?.settings.arguments
        as BeneficiarioPreinversionEntity;
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    return Scaffold(
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final menuHijo = menuCubit.preInversionMenuSorted(state.menus!);
            return BeneficiariosPreinversionDrawer(
              menuHijo: menuHijo,
              beneficiarioPreinversion: beneficiarioPreinversion,
            );
          },
        ),
        appBar:
            AppBar(title: const Text('Detalle Beneficiario'), actions: const [
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
                  Text('BENEFICIARIO', style: Styles.titleStyle),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                  beneficiarioPreinversion.beneficiarioId == '0'
                      ? 'Creación'
                      : 'Editar',
                  style: Styles.subtitleStyle),
            ),
            const BeneficiarioForm()
          ]),
        ));
  }
}
