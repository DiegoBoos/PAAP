import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/perfil_preinversion_planes_negocios/perfil_preinversion_planes_negocios_bloc.dart';
import '../../../ui/cubits/perfil_preinversion_ingresos_utp/perfil_preinversion_ingresos_utp_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../ui/cubits/v_perfiles_preinversiones_plan_negocios/v_perfiles_preinversiones_plan_negocios_cubit.dart';
import '../../../domain/entities/v_perfil_preinversion_plan_negocio_entity.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/sync_pages.dart';
import '../../utils/no_data_svg.dart';
import 'perfiles_preinversiones_plan_negocios_rows.dart';

class IngresosUPTPage extends StatefulWidget {
  const IngresosUPTPage({super.key});

  @override
  State<IngresosUPTPage> createState() => _IngresosUPTPageState();
}

const String tipoMovimientoId = '2';

class _IngresosUPTPageState extends State<IngresosUPTPage> {
  @override
  void initState() {
    super.initState();
    final vPerfilesPreInversionesPlanNegociosCubit =
        BlocProvider.of<VPerfilesPreInversionesPlanNegociosCubit>(context);

    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionId = vPerfilPreInversionCubit
        .state.vPerfilPreInversion!.perfilPreInversionId!;

    vPerfilesPreInversionesPlanNegociosCubit
        .getVPerfilesPreInversionesPlanNegociosDB(
            perfilPreInversionId, tipoMovimientoId);
  }

  @override
  Widget build(BuildContext context) {
    final vPerfilesPreInversionesPlanNegociosCubit =
        BlocProvider.of<VPerfilesPreInversionesPlanNegociosCubit>(context);

    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionId = vPerfilPreInversionCubit
        .state.vPerfilPreInversion!.perfilPreInversionId!;

    return BlocListener<PerfilPreInversionIngresosUPTCubit,
        PerfilPreInversionIngresosUPTState>(listener: (context, state) {
      if (state is PerfilPreInversionIngresosUPTSaved) {
        CustomSnackBar.showSnackBar(
            context, 'Datos guardados satisfactoriamente', Colors.green);

        vPerfilesPreInversionesPlanNegociosCubit
            .getVPerfilesPreInversionesPlanNegociosDB(
                perfilPreInversionId, tipoMovimientoId);
      }

      if (state is PerfilPreInversionIngresosUPTError) {
        CustomSnackBar.showSnackBar(
            context, 'Error al cargar/guardar datos', Colors.red);
      }
    }, child: BlocBuilder<VPerfilesPreInversionesPlanNegociosCubit,
        VPerfilesPreInversionesPlanNegociosState>(
      builder: (context, state) {
        if (state is PerfilPreInversionPlanNegociosLoading) {
          return const CustomCircularProgress(alignment: Alignment.center);
        } else if (state is VPerfilesPreInversionesPlanNegociosLoaded) {
          List<VPerfilPreInversionPlanNegocioEntity>
              vPerfilesPreInversionesPlanNegocios =
              state.vPerfilesPreInversionesPlanNegociosLoaded;
          if (vPerfilesPreInversionesPlanNegocios.isEmpty) {
            return const SizedBox(
                child: Center(child: NoDataSvg(title: 'No hay resultados')));
          }
          return PerfilPreInversionPlanNegociosRows(
              perfilPreInversionPlanNegocios:
                  vPerfilesPreInversionesPlanNegocios,
              tipoMovimientoId: tipoMovimientoId);
        }
        return const NoDataSvg(
          title: 'No hay resultados',
        );
      },
    ));
  }
}
