import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/perfil_preinversion_beneficiarios/perfil_preinversion_beneficiarios_bloc.dart';
import '../../../ui/cubits/menu/menu_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/sync_pages.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import 'perfil_preinversion_beneficiarios_rows.dart';

class PerfilPreInversionBeneficiariosPage extends StatefulWidget {
  const PerfilPreInversionBeneficiariosPage({super.key});

  @override
  State<PerfilPreInversionBeneficiariosPage> createState() =>
      _PerfilPreInversionBeneficiariosPageState();
}

class _PerfilPreInversionBeneficiariosPageState
    extends State<PerfilPreInversionBeneficiariosPage> {
  @override
  void initState() {
    super.initState();
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionBeneficiariosBloc =
        BlocProvider.of<PerfilPreInversionBeneficiariosBloc>(context);

    final perfilPreInversionId = vPerfilPreInversionCubit
        .state.vPerfilPreInversion!.perfilPreInversionId;

    perfilPreInversionBeneficiariosBloc
        .add(GetPerfilPreInversionBeneficiarios(perfilPreInversionId));
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    final perfilPreInversionBeneficiariosBloc =
        BlocProvider.of<PerfilPreInversionBeneficiariosBloc>(context);
    final perfilPreInversionBeneficiarios = perfilPreInversionBeneficiariosBloc
        .state.perfilPreInversionBeneficiarios;

    return Scaffold(
      drawer: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          final menuHijo = menuCubit.preInversionMenuSorted(state.menus!);
          return PerfilPreInversionDrawer(
            menuHijo: menuHijo,
          );
        },
      ),
      floatingActionButton: perfilPreInversionBeneficiarios != null &&
              perfilPreInversionBeneficiarios.isEmpty
          ? FloatingActionButton(
              child: const Icon(Icons.save),
              onPressed: () => Navigator.pushNamed(
                  context, 'NewEditVBeneficiarioPreInversion'))
          : null,
      appBar: AppBar(title: const Text('Consulta'), actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: NetworkIcon(),
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocBuilder<PerfilPreInversionBeneficiariosBloc,
            PerfilPreInversionBeneficiariosState>(
          builder: (context, state) {
            if (state is PerfilPreInversionBeneficiariosLoading) {
              return const CustomCircularProgress(alignment: Alignment.center);
            }
            if (state is PerfilPreInversionBeneficiariosLoaded) {
              final perfilPreInversionBeneficiarios =
                  state.perfilPreInversionBeneficiariosLoaded;
              if (perfilPreInversionBeneficiarios.isEmpty) {
                return const SizedBox(
                    child:
                        Center(child: NoDataSvg(title: 'No hay resultados')));
              }
              return PerfilPreInversionBeneficiariosRows(
                perfilPreInversionBeneficiarios:
                    perfilPreInversionBeneficiarios,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
