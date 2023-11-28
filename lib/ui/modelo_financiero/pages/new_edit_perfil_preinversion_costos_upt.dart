import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/actividad_financiera_entity.dart';
import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../../domain/entities/rubro_entity.dart';
import '../../../domain/entities/unidad_entity.dart';
import '../../cubits/actividad_financiera/actividad_financiera_cubit.dart';
import '../../cubits/perfil_preinversion_costos_utp/perfil_preinversion_costos_utp_cubit.dart';
import '../../cubits/rubro/rubro_cubit.dart';
import '../../cubits/unidad/unidad_cubit.dart';
import '../../cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/input_decoration.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';

class NewEditPerfilPreInversionCostosUPT extends StatefulWidget {
  const NewEditPerfilPreInversionCostosUPT({super.key});

  @override
  State<NewEditPerfilPreInversionCostosUPT> createState() =>
      _NewEditPerfilPreInversionCostosUPTState();
}

class _NewEditPerfilPreInversionCostosUPTState
    extends State<NewEditPerfilPreInversionCostosUPT> {
  final formKeyCostosUPT = GlobalKey<FormState>();

  List<RubroEntity> allRubros = [];
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

    final perfilPreInversionCostosUPTCubit =
        BlocProvider.of<PerfilPreInversionCostosUPTCubit>(context);

    final rubroCubit = BlocProvider.of<RubroCubit>(context);
    allRubros = rubrosFiltered = rubroCubit.state.rubros!;

    final perfilPreInversionCostosUPT =
        perfilPreInversionCostosUPTCubit.state.perfilPreInversionCostosUPT;

    setState(() {
      actividadFinancieraId = perfilPreInversionCostosUPT.actividadFinancieraId;
      rubroId = perfilPreInversionCostosUPT.rubroId;
      unidadId = perfilPreInversionCostosUPT.unidadId;
      yearCtrl.text = perfilPreInversionCostosUPT.year ?? '';
      cantidadCtrl.text = perfilPreInversionCostosUPT.cantidad ?? '';
      valorCtrl.text = perfilPreInversionCostosUPT.valor ?? '';

      rubrosFiltered = allRubros
          .where(
              ((rubro) => rubro.actividadFinancieraId == actividadFinancieraId))
          .toList();
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<PerfilPreInversionCostosUPTCubit>(context).initState();
  }

  @override
  Widget build(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final perfilPreInversionCostosUPTCubit =
        BlocProvider.of<PerfilPreInversionCostosUPTCubit>(context);

    final tipoMovimientoId =
        ModalRoute.of(context)!.settings.arguments as String;

    return BlocBuilder<PerfilPreInversionCostosUPTCubit,
        PerfilPreInversionCostosUPTState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    state.perfilPreInversionCostosUPT.actividadFinancieraId !=
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
              key: formKeyCostosUPT,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
                                  decoration:
                                      CustomInputDecoration.inputDecoration(
                                          hintText: 'Actividad Financiera',
                                          labelText: 'Actividad Financiera'),
                                  isExpanded: true,
                                  value: actividadFinancieraId,
                                  items: state.actividadesFinancierasLoaded!
                                      .where((actividadFinanciera) =>
                                          actividadFinanciera
                                              .tipoMovimientoId ==
                                          '3')
                                      .map<DropdownMenuItem<String>>(
                                          (ActividadFinancieraEntity value) {
                                    return DropdownMenuItem<String>(
                                      value: value.actividadFinancieraId,
                                      child: Text(value.nombre!),
                                    );
                                  }).toList(),
                                  validator: ((value) {
                                    if (value == null) {
                                      return 'Campo Requerido';
                                    }
                                    return null;
                                  }),
                                  onChanged: (String? value) {
                                    setState(() {
                                      rubrosFiltered = allRubros
                                          .where(((rubro) =>
                                              rubro.actividadFinancieraId ==
                                              value))
                                          .toList();

                                      rubroId = null;
                                    });
                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField(
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Rubro', labelText: 'Rubro'),
                            isExpanded: true,
                            value: rubroId,
                            items: rubrosFiltered.map<DropdownMenuItem<String>>(
                                (RubroEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.rubroId,
                                child: Text(value.nombre!),
                              );
                            }).toList(),
                            validator: ((value) {
                              if (value == null) {
                                return 'Campo Requerido';
                              }
                              return null;
                            }),
                            onChanged: (String? value) {
                              perfilPreInversionCostosUPTCubit
                                  .changeRubro(value);

                              setState(() {
                                rubroId = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          BlocBuilder<UnidadCubit, UnidadState>(
                            builder: (context, state) {
                              if (state is UnidadesLoaded) {
                                return DropdownButtonFormField(
                                  decoration:
                                      CustomInputDecoration.inputDecoration(
                                          hintText: 'Unidad',
                                          labelText: 'Unidad'),
                                  isExpanded: true,
                                  value: unidadId,
                                  items: state.unidades!
                                      .map<DropdownMenuItem<String>>(
                                          (UnidadEntity value) {
                                    return DropdownMenuItem<String>(
                                      value: value.unidadId,
                                      child: Text(value.nombre!),
                                    );
                                  }).toList(),
                                  validator: ((value) {
                                    if (value == null) {
                                      return 'Campo Requerido';
                                    }
                                    return null;
                                  }),
                                  onChanged: (String? value) {
                                    perfilPreInversionCostosUPTCubit
                                        .changeUnidad(value);
                                  },
                                );
                              }
                              return Container();
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                              keyboardType: TextInputType.number,
                              controller: yearCtrl,
                              decoration: CustomInputDecoration.inputDecoration(
                                  hintText: 'Año', labelText: 'Año'),
                              validator: ((value) {
                                final intNumber = int.tryParse(value ?? '');
                                if (intNumber != null && intNumber <= 10) {
                                  return null;
                                }
                                return '¡Para el Año debe ingresar del Cero al Diez!';
                              }),
                              onSaved: (String? newValue) {
                                perfilPreInversionCostosUPTCubit
                                    .changeYear(newValue);
                              }),
                          const SizedBox(height: 20),
                          TextFormField(
                              keyboardType: TextInputType.number,
                              controller: cantidadCtrl,
                              decoration: CustomInputDecoration.inputDecoration(
                                  hintText: 'Cantidad', labelText: 'Cantidad'),
                              validator: ((value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo Requerido';
                                }
                                return null;
                              }),
                              onSaved: (String? newValue) {
                                perfilPreInversionCostosUPTCubit
                                    .changeCantidad(newValue);
                              }),
                          const SizedBox(height: 20),
                          TextFormField(
                              keyboardType: TextInputType.number,
                              controller: valorCtrl,
                              decoration: CustomInputDecoration.inputDecoration(
                                  hintText: 'Valor', labelText: 'Valor'),
                              validator: ((value) {
                                if (value == null || value.isEmpty) {
                                  return 'Campo Requerido';
                                }
                                return null;
                              }),
                              onSaved: (String? newValue) {
                                perfilPreInversionCostosUPTCubit
                                    .changeValor(newValue);
                              }),
                        ])),
                  ),
                  const SizedBox(height: 20),
                  SaveBackButtons(
                    onSaved: () {
                      if (!formKeyCostosUPT.currentState!.validate()) {
                        return;
                      }

                      formKeyCostosUPT.currentState!.save();

                      final perfilPreInversionId = vPerfilPreInversionCubit
                          .state.vPerfilPreInversion!.perfilPreInversionId;
                      final perfilPreInversionCostosUPT =
                          perfilPreInversionCostosUPTCubit
                              .state.perfilPreInversionCostosUPT;

                      final perfilPreInversionPlanNegocio =
                          PerfilPreInversionPlanNegocioEntity(
                        perfilPreInversionId: perfilPreInversionId,
                        rubroId: perfilPreInversionCostosUPT.rubroId,
                        year: perfilPreInversionCostosUPT.year,
                        valor: perfilPreInversionCostosUPT.valor,
                        cantidad: perfilPreInversionCostosUPT.cantidad,
                        unidadId: perfilPreInversionCostosUPT.unidadId,
                        productoId: perfilPreInversionCostosUPT.productoId,
                        tipoCalidadId:
                            perfilPreInversionCostosUPT.tipoCalidadId,
                      );
                      perfilPreInversionCostosUPTCubit
                          .savePerfilPreInversionCostosUPTDB(
                              perfilPreInversionPlanNegocio, tipoMovimientoId);
                    },
                  )
                ]),
              ),
            ));
      },
    );
  }
}
