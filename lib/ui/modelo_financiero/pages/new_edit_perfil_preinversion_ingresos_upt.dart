import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../ui/cubits/perfil_preinversion_ingresos_utp/perfil_preinversion_ingresos_utp_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_plan_negocio_form.dart';
import '../widgets/perfil_preinversion_precio_form.dart';

class NewEditPerfilPreInversionIngresosUPT extends StatefulWidget {
  const NewEditPerfilPreInversionIngresosUPT({super.key});

  @override
  State<NewEditPerfilPreInversionIngresosUPT> createState() =>
      _NewEditPerfilPreInversionIngresosUPTState();
}

class _NewEditPerfilPreInversionIngresosUPTState
    extends State<NewEditPerfilPreInversionIngresosUPT> {
  final formKeyIngresosUPT = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final perfilPreInversionIngresosUPTCubit =
        BlocProvider.of<PerfilPreInversionIngresosUPTCubit>(context);

    final tipoMovimientoId =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
            title: Text(perfilPreInversionIngresosUPTCubit.state
                        .perfilPreInversionIngresosUPT.actividadFinancieraId !=
                    null
                ? 'Editar'
                : 'Crear'),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: NetworkIcon(),
              )
            ]),
        body: Form(
          key: formKeyIngresosUPT,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: ListView(children: [
                const Text(
                  'Ingresos UPT',
                  style: Styles.titleStyle,
                ),
                const SizedBox(height: 20),
                const PerfilPreInversionPrecioForm(),
                const SizedBox(height: 20),
                const PerfilPreInversionPlanNegocioForm(),
                const SizedBox(height: 20),
                SaveBackButtons(
                  onSaved: () {
                    if (!formKeyIngresosUPT.currentState!.validate()) {
                      return;
                    }

                    formKeyIngresosUPT.currentState!.save();

                    final perfilPreInversionId = vPerfilPreInversionCubit
                        .state.vPerfilPreInversion!.perfilPreInversionId;
                    final perfilPreInversionIngresosUPT =
                        perfilPreInversionIngresosUPTCubit
                            .state.perfilPreInversionIngresosUPT;
                    final perfilPreInversionPlanNegocio =
                        PerfilPreInversionPlanNegocioEntity(
                            perfilPreInversionId: perfilPreInversionId,
                            rubroId: perfilPreInversionIngresosUPT.rubroId,
                            year: perfilPreInversionIngresosUPT.year,
                            valor: perfilPreInversionIngresosUPT.valor,
                            cantidad: perfilPreInversionIngresosUPT.cantidad,
                            unidadId: perfilPreInversionIngresosUPT.unidadId,
                            productoId:
                                perfilPreInversionIngresosUPT.productoId!,
                            tipoCalidadId:
                                perfilPreInversionIngresosUPT.tipoCalidadId!);
                    perfilPreInversionIngresosUPTCubit
                        .savePerfilPreInversionIngresosUPTDB(
                            perfilPreInversionPlanNegocio, tipoMovimientoId);
                  },
                )
              ])),
        ));
  }
}
