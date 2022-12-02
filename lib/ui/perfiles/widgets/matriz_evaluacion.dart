import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/agrupacion/agrupacion_cubit.dart';
import '../../../domain/cubits/criterio/criterio_cubit.dart';
import '../../../domain/cubits/evaluacion/evaluacion_cubit.dart';
import '../../../domain/cubits/evaluacion_respuesta/evaluacion_respuesta_cubit.dart';
import '../../../domain/cubits/opcion/opcion_cubit.dart';
import '../../../domain/entities/agrupacion_entity.dart';
import '../../../domain/entities/criterio_entity.dart';
import '../../../domain/entities/opcion_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/loading_page.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';

class MatrizEvaluacion extends StatefulWidget {
  const MatrizEvaluacion({super.key});

  @override
  State<MatrizEvaluacion> createState() => _MatrizEvaluacionState();
}

class _MatrizEvaluacionState extends State<MatrizEvaluacion> {
  AgrupacionEntity agrupacion = AgrupacionEntity(
      agrupacionId: '', nombre: '', descripcion: '', convocatoriaId: '');
  bool showOpciones = false;

  String? opcionId;
  final observacionCtrl = TextEditingController();

  List<OpcionEntity> opciones = [];

  @override
  Widget build(BuildContext context) {
    final agrupacionCubit = BlocProvider.of<AgrupacionCubit>(context);
    final opcionCubit = BlocProvider.of<OpcionCubit>(context);
    final criterioCubit = BlocProvider.of<CriterioCubit>(context);

    final evaluacionRespuestaCubit =
        BlocProvider.of<EvaluacionRespuestaCubit>(context);

    return Column(
      children: [
        DropdownButtonFormField(
            isExpanded: true,
            items: agrupacionCubit.state.agrupaciones!
                .map<DropdownMenuItem<String>>((AgrupacionEntity value) {
              return DropdownMenuItem<String>(
                value: value.agrupacionId,
                child: Text(value.nombre),
              );
            }).toList(),
            onChanged: (String? value) async {
              showOpciones = false;
              setState(() {
                agrupacion = agrupacionCubit.state.agrupaciones!
                    .firstWhere(((element) => element.agrupacionId == value));
              });
              await criterioCubit.getCriteriosDB(agrupacion.agrupacionId);
            },
            hint: const Text('Agrupación')),
        if (agrupacion.agrupacionId != '')
          Column(
            children: [
              const SizedBox(height: 10),
              Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(agrupacion.nombre,
                          style: Styles.subtitleStyle
                              .copyWith(color: Colors.white)),
                      const SizedBox(height: 10),
                      Text(agrupacion.descripcion,
                          style: Styles.subtitleStyle
                              .copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<EvaluacionCubit, EvaluacionState>(
                builder: (context, state) {
                  final evaluacion = state.evaluacion;

                  return BlocBuilder<CriterioCubit, CriterioState>(
                    builder: (context, state) {
                      if (state is CriteriosLoading) {
                        return const CustomCircularProgress(
                            alignment: Alignment.center);
                      } else if (state is CriteriosLoaded) {
                        List<CriterioEntity> criterios = state.criteriosLoaded!;
                        if (criterios.isEmpty) {
                          showOpciones = false;
                          return const Center(
                              child: NoDataSvg(title: 'No hay criterios'));
                        }
                        return DropdownButtonFormField(
                            isExpanded: true,
                            items: criterioCubit.state.criterios!
                                .map<DropdownMenuItem<String>>(
                                    (CriterioEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.criterioId,
                                child: Text(value.nombre),
                              );
                            }).toList(),
                            onChanged: (String? value) async {
                              opcionId = null;

                              final evaluacionRespuesta =
                                  await evaluacionRespuestaCubit
                                      .getEvaluacionRespuestaDB(
                                          value!, evaluacion!.evaluacionId);

                              if (evaluacionRespuesta != null) {
                                observacionCtrl.text =
                                    evaluacionRespuesta.observacion;
                                opcionId = evaluacionRespuesta.opcionId;
                              }

                              opciones = await opcionCubit.getOpcionesDB(value);
                              evaluacionRespuestaCubit.changeCriterio(value);

                              showOpciones = true;

                              setState(() {});
                            },
                            hint: const Text('Criterios'));
                      }
                      return Container();
                    },
                  );
                },
              ),
              if (showOpciones)
                opciones.isEmpty
                    ? const Center(child: NoDataSvg(title: 'No hay opciones'))
                    : Column(
                        children: [
                          DropdownButtonFormField(
                              isExpanded: true,
                              value: opcionId != '' ? opcionId : null,
                              items: opciones.map<DropdownMenuItem<String>>(
                                  (OpcionEntity value) {
                                return DropdownMenuItem<String>(
                                  value: value.opcionId,
                                  child: Text(value.nombre),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                evaluacionRespuestaCubit.changeOpcion(value!);
                                setState(() {
                                  opcionId = value;
                                });
                              },
                              hint: const Text('Opciones')),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: observacionCtrl,
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Observaciones',
                                labelText: 'Observaciones'),
                            onSaved: (String? newValue) {
                              evaluacionRespuestaCubit
                                  .changeObservacion(newValue!);
                            },
                          )
                        ],
                      ),
            ],
          ),
      ],
    );
  }
}
