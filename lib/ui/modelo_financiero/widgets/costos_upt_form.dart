import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/actividad_financiera/actividad_financiera_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_costos_utp/perfil_preinversion_costos_utp_cubit.dart';
import '../../../domain/cubits/rubro/rubro_cubit.dart';
import '../../../domain/cubits/unidad/unidad_cubit.dart';
import '../../../domain/entities/actividad_financiera_entity.dart';
import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../../domain/entities/rubro_entity.dart';
import '../../../domain/entities/unidad_entity.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class CostosUPTForm extends StatefulWidget {
  const CostosUPTForm({super.key});

  @override
  State<CostosUPTForm> createState() => _CostosUPTFormState();
}

class _CostosUPTFormState extends State<CostosUPTForm> {
  List<RubroEntity> rubrosFiltered = [];

  String? actividadFinancieraId;
  String? rubroId;
  String? unidadId;

  final yearCtrl = TextEditingController();
  final cantidadCtrl = TextEditingController();
  final valorCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAccesories();
  }

  Future<void> loadAccesories() async {
    final perfilPreInversionCostosUPTCubit =
        BlocProvider.of<PerfilPreInversionCostosUPTCubit>(context);
    final rubroCubit = BlocProvider.of<RubroCubit>(context);

    await rubroCubit.getRubrosDB();

    if (rubroCubit.state is RubrosLoaded) {
      rubrosFiltered = rubroCubit.state.rubros!;
    }

    if (perfilPreInversionCostosUPTCubit.state
        is PerfilPreInversionCostosUPTLoaded) {
      final perfilPreInversionCostosUPTLoaded =
          perfilPreInversionCostosUPTCubit.state.perfilPreInversionCostosUPT;
      loadPerfilPreInversionCostosUPT(perfilPreInversionCostosUPTLoaded);
    }
  }

  void loadPerfilPreInversionCostosUPT(
      PerfilPreInversionPlanNegocioEntity perfilPreInversionCostosUPTLoaded) {
    rubroId = perfilPreInversionCostosUPTLoaded.rubroId;
    unidadId = perfilPreInversionCostosUPTLoaded.unidadId;
    yearCtrl.text = perfilPreInversionCostosUPTLoaded.year;
    cantidadCtrl.text = perfilPreInversionCostosUPTLoaded.cantidad;
    valorCtrl.text = perfilPreInversionCostosUPTLoaded.valor;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionCostosUPTCubit =
        BlocProvider.of<PerfilPreInversionCostosUPTCubit>(context);
    final rubroCubit = BlocProvider.of<RubroCubit>(context);

    return BlocListener<PerfilPreInversionCostosUPTCubit,
        PerfilPreInversionCostosUPTState>(
      listener: (context, state) {
        if (state is PerfilPreInversionCostosUPTLoaded) {
          final perfilPreInversionCostosUPTLoaded =
              state.perfilPreInversionCostosUPTLoaded;
          loadPerfilPreInversionCostosUPT(perfilPreInversionCostosUPTLoaded);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: ListView(children: [
          const Text(
            'Costos UPT',
            style: Styles.titleStyle,
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  BlocBuilder<ActividadFinancieraCubit,
                      ActividadFinancieraState>(
                    builder: (context, state) {
                      if (state is ActividadesFinancierasLoaded) {
                        return DropdownButtonFormField(
                            isExpanded: true,
                            value: actividadFinancieraId != ''
                                ? actividadFinancieraId
                                : null,
                            items: state.actividadesFinancierasLoaded!
                                .where((actividadFinanciera) =>
                                    actividadFinanciera.tipoMovimientoId == '2')
                                .map<DropdownMenuItem<String>>(
                                    (ActividadFinancieraEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.actividadFinancieraId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                rubrosFiltered = rubroCubit.state.rubros!
                                    .where(((rubro) =>
                                        rubro.actividadFinancieraId == value))
                                    .toList();

                                rubroId = null;
                              });
                            },
                            hint: const Text('Activida Financiera'));
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                      isExpanded: true,
                      value: rubroId,
                      items: rubrosFiltered
                          .map<DropdownMenuItem<String>>((RubroEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.rubroId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        perfilPreInversionCostosUPTCubit.changeRubro(value);
                      },
                      hint: const Text('Rubro')),
                  const SizedBox(height: 20),
                  BlocBuilder<UnidadCubit, UnidadState>(
                    builder: (context, state) {
                      if (state is UnidadesLoaded) {
                        return DropdownButtonFormField(
                            isExpanded: true,
                            value: unidadId != '' ? unidadId : null,
                            items: state.unidades!
                                .map<DropdownMenuItem<String>>(
                                    (UnidadEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.unidadId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              perfilPreInversionCostosUPTCubit
                                  .changeUnidad(value);
                            },
                            hint: const Text('Unidad'));
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: yearCtrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Año', labelText: 'Año'),
                      onSaved: (String? newValue) {
                        perfilPreInversionCostosUPTCubit.changeYear(newValue);
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: cantidadCtrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Cantidad', labelText: 'Cantidad'),
                      onSaved: (String? newValue) {
                        perfilPreInversionCostosUPTCubit
                            .changeCantidad(newValue);
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: valorCtrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Valor', labelText: 'Valor'),
                      onSaved: (String? newValue) {
                        perfilPreInversionCostosUPTCubit.changeValor(newValue);
                      }),
                ])),
          ),
          const SizedBox(height: 20),
          const SaveBackButtons(
            onSaved: null,
            routeName: 'tabs',
          )
        ]),
      ),
    );
  }
}
