import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/cubits/agrupacion/agrupacion_cubit.dart';
import '../../../ui/cubits/criterio/criterio_cubit.dart';
import '../../../ui/cubits/evaluacion/evaluacion_cubit.dart';
import '../../../ui/cubits/evaluacion_respuesta/evaluacion_respuesta_cubit.dart';
import '../../../ui/cubits/opcion/opcion_cubit.dart';
import '../../../domain/entities/agrupacion_entity.dart';
import '../../../domain/entities/criterio_entity.dart';
import '../../../domain/entities/opcion_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/sync_pages.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';

class MatrizEvaluacion extends StatefulWidget {
  const MatrizEvaluacion({super.key});

  @override
  State<MatrizEvaluacion> createState() => _MatrizEvaluacionState();
}

class _MatrizEvaluacionState extends State<MatrizEvaluacion> {
  AgrupacionEntity agrupacion = AgrupacionEntity();
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
          decoration: CustomInputDecoration.inputDecoration(
              hintText: 'Agrupación', labelText: 'Agrupación'),
          isExpanded: true,
          items: agrupacionCubit.state.agrupaciones!
              .map<DropdownMenuItem<String>>((AgrupacionEntity value) {
            return DropdownMenuItem<String>(
              value: value.agrupacionId,
              child: Text(value.nombre!),
            );
          }).toList(),
          onChanged: (String? value) async {
            showOpciones = false;
            setState(() {
              agrupacion = agrupacionCubit.state.agrupaciones!
                  .firstWhere(((element) => element.agrupacionId == value));
            });
            criterioCubit.getCriteriosDB(agrupacion.agrupacionId!);
          },
        ),
        if (agrupacion.agrupacionId != null)
          Column(
            children: [
              const SizedBox(height: 10),
              Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(agrupacion.nombre!,
                          style: Styles.subtitleStyle
                              .copyWith(color: Colors.white)),
                      const SizedBox(height: 10),
                      Text(agrupacion.descripcion!,
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
                          decoration: CustomInputDecoration.inputDecoration(
                              hintText: 'Criterios', labelText: 'Criterios'),
                          isExpanded: true,
                          items: criterioCubit.state.criterios!
                              .map<DropdownMenuItem<String>>(
                                  (CriterioEntity value) {
                            return DropdownMenuItem<String>(
                              value: value.criterioId,
                              child: Text(value.nombre!),
                            );
                          }).toList(),
                          onChanged: (String? value) async {
                            evaluacionRespuestaCubit
                                .changeEvaluacion(evaluacion.evaluacionId!);
                            evaluacionRespuestaCubit.changeCriterio(value!);

                            final evaluacionRespuesta =
                                await evaluacionRespuestaCubit
                                    .getEvaluacionRespuestaDB(
                                        value,
                                        evaluacionRespuestaCubit.state
                                            .evaluacionRespuesta.evaluacionId!);

                            if (evaluacionRespuesta != null) {
                              observacionCtrl.text =
                                  evaluacionRespuesta.observacion!;
                              opcionId = evaluacionRespuesta.opcionId;
                              evaluacionRespuestaCubit
                                  .getEvaluacionRespuestaOpcionDB(
                                      evaluacionRespuestaCubit.state
                                          .evaluacionRespuesta.criterioId!,
                                      evaluacionRespuestaCubit.state
                                          .evaluacionRespuesta.evaluacionId!,
                                      opcionId!);
                            }

                            opciones = await opcionCubit.getOpcionesDB(value);

                            showOpciones = true;

                            setState(() {});
                          },
                        );
                      }
                      return Container();
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              if (showOpciones)
                opciones.isEmpty
                    ? const Center(child: NoDataSvg(title: 'No hay opciones'))
                    : Column(
                        children: [
                          DropdownButtonFormField(
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Opciones', labelText: 'Opciones'),
                            isExpanded: true,
                            value: opcionId != '' ? opcionId : null,
                            items: opciones.map<DropdownMenuItem<String>>(
                                (OpcionEntity value) {
                              return DropdownMenuItem<String>(
                                value: value.opcionId,
                                child: Text(value.nombre!),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              evaluacionRespuestaCubit
                                  .getEvaluacionRespuestaOpcionDB(
                                      evaluacionRespuestaCubit.state
                                          .evaluacionRespuesta.criterioId!,
                                      evaluacionRespuestaCubit.state
                                          .evaluacionRespuesta.evaluacionId!,
                                      value!);

                              opcionId = value;

                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 20),
                          BlocConsumer<EvaluacionRespuestaCubit,
                              EvaluacionRespuestaState>(
                            listener: (context, state) {
                              if (state is EvaluacionRespuestaLoaded) {
                                observacionCtrl.text = state
                                    .evaluacionRespuestaLoaded.observacion!;
                              }
                            },
                            builder: (context, state) {
                              return TextFormField(
                                controller: observacionCtrl,
                                decoration:
                                    CustomInputDecoration.inputDecoration(
                                        hintText: 'Observaciones',
                                        labelText: 'Observaciones'),
                                onSaved: (String? newValue) {
                                  evaluacionRespuestaCubit
                                      .changeOpcion(opcionId!);

                                  evaluacionRespuestaCubit
                                      .changeObservacion(newValue!);
                                },
                              );
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
