import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_planes_negocios/perfil_preinversion_planes_negocios_bloc.dart';
import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_planes_negocios_rows.dart';

class CostosUPTPage extends StatefulWidget {
  const CostosUPTPage({super.key});

  @override
  State<CostosUPTPage> createState() => _CostosUPTPageState();
}

class _CostosUPTPageState extends State<CostosUPTPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PerfilPreInversionPlanesNegociosBloc,
        PerfilPreInversionPlanesNegociosState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is PerfilPreInversionPlanesNegociosLoading) {
          return const CustomCircularProgress(alignment: Alignment.center);
        } else if (state is PerfilPreInversionPlanesNegociosLoaded) {
          List<PerfilPreInversionPlanNegocioEntity>
              perfilPreInversionPlanesNegocios =
              state.perfilPreInversionPlanesNegociosLoaded!;
          if (perfilPreInversionPlanesNegocios.isEmpty) {
            return const SizedBox(
                child: Center(child: NoDataSvg(title: 'No hay resultados')));
          }
          return PerfilPreInversionPlanesNegociosRows(
              perfilPreInversionPlanesNegocios:
                  perfilPreInversionPlanesNegocios,
              subtitleStyle: Styles.subtitleStyle);
        }
        return const NoDataSvg(
          title: 'No hay resultados',
        );
      },
    );
  }
}
