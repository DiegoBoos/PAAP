import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/utils/custom_snack_bar.dart';

import '../../../domain/blocs/perfil_preinversion_planes_negocios/perfil_preinversion_planes_negocios_bloc.dart';
import '../../../domain/cubits/perfil_preinversion_costos_utp/perfil_preinversion_costos_utp_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/cubits/v_perfiles_preinversiones_plan_negocios/v_perfiles_preinversiones_plan_negocios_cubit.dart';
import '../../../domain/entities/v_perfil_preinversion_plan_negocio_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/perfiles_preinversiones_plan_negocios_rows.dart';

class CostosUPTPage extends StatefulWidget {
  const CostosUPTPage({super.key});

  @override
  State<CostosUPTPage> createState() => _CostosUPTPageState();
}

const String tipoMovimiento = '3';

class _CostosUPTPageState extends State<CostosUPTPage> {
  @override
  void initState() {
    super.initState();
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final vPerfilesPreInversionesPlanNegociosCubit =
        BlocProvider.of<VPerfilesPreInversionesPlanNegociosCubit>(context);
    vPerfilesPreInversionesPlanNegociosCubit
        .getVPerfilesPreInversionesPlanNegociosDB(
            vPerfilPreInversionCubit
                .state.vPerfilPreInversion!.perfilPreInversionId,
            tipoMovimiento);
  }

  @override
  Widget build(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final vPerfilesPreInversionesPlanNegociosCubit =
        BlocProvider.of<VPerfilesPreInversionesPlanNegociosCubit>(context);

    return BlocListener<PerfilPreInversionCostosUPTCubit,
        PerfilPreInversionCostosUPTState>(listener: (context, state) {
      if (state is PerfilPreInversionCostosUPTSaved) {
        CustomSnackBar.showSnackBar(
            context, 'Datos guardados satisfactoriamente', Colors.green);

        vPerfilesPreInversionesPlanNegociosCubit
            .getVPerfilesPreInversionesPlanNegociosDB(
                vPerfilPreInversionCubit
                    .state.vPerfilPreInversion!.perfilPreInversionId,
                tipoMovimiento);
      }
    }, child: BlocBuilder<VPerfilesPreInversionesPlanNegociosCubit,
        VPerfilesPreInversionesPlanNegociosState>(
      builder: (context, state) {
        if (state is PerfilPreInversionPlanesNegociosLoading) {
          return const CustomCircularProgress(alignment: Alignment.center);
        } else if (state is VPerfilesPreInversionesPlanNegociosLoaded) {
          List<VPerfilPreInversionPlanNegocioEntity>
              vPerfilesPreInversionesPlanNegocios =
              state.vPerfilesPreInversionesPlanNegociosLoaded;
          if (vPerfilesPreInversionesPlanNegocios.isEmpty) {
            return const SizedBox(
                child: Center(child: NoDataSvg(title: 'No hay resultados')));
          }
          return PerfilPreInversionPlanesNegociosRows(
              vPerfilesPreInversionesPlanNegocios:
                  vPerfilesPreInversionesPlanNegocios,
              subtitleStyle: Styles.subtitleStyle,
              tipoMovimiento: tipoMovimiento);
        }
        return const NoDataSvg(
          title: 'No hay resultados',
        );
      },
    ));
  }
}
