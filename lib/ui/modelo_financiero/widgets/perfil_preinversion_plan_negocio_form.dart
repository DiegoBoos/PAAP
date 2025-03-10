import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/cubits/actividad_financiera/actividad_financiera_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_ingresos_utp/perfil_preinversion_ingresos_utp_cubit.dart';
import '../../../ui/cubits/rubro/rubro_cubit.dart';
import '../../../ui/cubits/unidad/unidad_cubit.dart';
import '../../../domain/entities/actividad_financiera_entity.dart';
import '../../../domain/entities/rubro_entity.dart';
import '../../../domain/entities/unidad_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class PerfilPreInversionPlanNegocioForm extends StatefulWidget {
  const PerfilPreInversionPlanNegocioForm({super.key});

  @override
  State<PerfilPreInversionPlanNegocioForm> createState() =>
      _PerfilPreInversionPlanNegocioFormState();
}

class _PerfilPreInversionPlanNegocioFormState
    extends State<PerfilPreInversionPlanNegocioForm> {
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

    final perfilPreInverperfilPreInversionIngresosUPTCubit =
        BlocProvider.of<PerfilPreInversionIngresosUPTCubit>(context);

    final perfilPreInversionIngresosUPT =
        perfilPreInverperfilPreInversionIngresosUPTCubit
            .state.perfilPreInversionIngresosUPT;

    final rubroCubit = BlocProvider.of<RubroCubit>(context);
    allRubros = rubrosFiltered = rubroCubit.state.rubros!;

    setState(() {
      actividadFinancieraId =
          perfilPreInversionIngresosUPT.actividadFinancieraId;
      rubroId = perfilPreInversionIngresosUPT.rubroId;
      unidadId = perfilPreInversionIngresosUPT.unidadId;
      yearCtrl.text = perfilPreInversionIngresosUPT.year ?? '';
      cantidadCtrl.text = perfilPreInversionIngresosUPT.cantidad ?? '';
      valorCtrl.text = perfilPreInversionIngresosUPT.valor ?? '';

      rubrosFiltered = allRubros
          .where(
              ((rubro) => rubro.actividadFinancieraId == actividadFinancieraId))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionIngresosUPTCubit =
        BlocProvider.of<PerfilPreInversionIngresosUPTCubit>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Cantidad Esperada Por Año', style: Styles.titleStyle),
            const SizedBox(height: 20),
            BlocBuilder<ActividadFinancieraCubit, ActividadFinancieraState>(
              builder: (context, state) {
                if (state is ActividadesFinancierasLoaded) {
                  return DropdownButtonFormField(
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Actividad', labelText: 'Actividad'),
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
                        child: Text(value.nombre!),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Campo Requerido';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      setState(() {
                        rubrosFiltered = allRubros
                            .where(((rubro) =>
                                rubro.actividadFinancieraId == value))
                            .toList();

                        actividadFinancieraId = value;
                        rubroId = null;
                      });
                    },
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<RubroCubit, RubroState>(
              builder: (context, state) {
                return DropdownButtonFormField(
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Rubro', labelText: 'Rubro'),
                  isExpanded: true,
                  value: rubroId,
                  items: rubrosFiltered
                      .map<DropdownMenuItem<String>>((RubroEntity value) {
                    return DropdownMenuItem<String>(
                      value: value.rubroId,
                      child: Text(value.nombre!),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Campo Requerido';
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    perfilPreInversionIngresosUPTCubit.changeRubro(value);
                    setState(() {
                      rubroId = value;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<UnidadCubit, UnidadState>(
              builder: (context, state) {
                if (state is UnidadesLoaded) {
                  return DropdownButtonFormField(
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Unidad', labelText: 'Unidad'),
                    isExpanded: true,
                    value: unidadId != '' ? unidadId : null,
                    items: state.unidades!
                        .map<DropdownMenuItem<String>>((UnidadEntity value) {
                      return DropdownMenuItem<String>(
                        value: value.unidadId,
                        child: Text(value.nombre!),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Campo Requerido';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      perfilPreInversionIngresosUPTCubit.changeUnidad(value);
                    },
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
                controller: yearCtrl,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Año', labelText: 'Año'),
                validator: (value) {
                  final intNumber = int.tryParse(value ?? '');
                  if (intNumber != null && intNumber <= 10) {
                    return null;
                  }
                  return '¡Para el Año debe ingresar del Cero al Diez!';
                },
                onSaved: (String? newValue) {
                  perfilPreInversionIngresosUPTCubit.changeYear(newValue);
                }),
            const SizedBox(height: 20),
            TextFormField(
                controller: cantidadCtrl,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Cantidad', labelText: 'Cantidad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Requerido';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  cantidadCtrl.text = newValue!;
                  perfilPreInversionIngresosUPTCubit.changeCantidad(newValue);
                }),
            const SizedBox(height: 20),
            TextFormField(
                controller: valorCtrl,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Valor', labelText: 'Valor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Requerido';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  perfilPreInversionIngresosUPTCubit.changeValor(newValue);
                }),
          ],
        ),
      ),
    );
  }
}
