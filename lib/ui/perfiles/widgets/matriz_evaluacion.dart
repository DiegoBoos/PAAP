import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/agrupacion/agrupacion_cubit.dart';
import '../../../domain/cubits/criterio/criterio_cubit.dart';
import '../../../domain/cubits/evaluacion_respuesta/evaluacion_respuesta_cubit.dart';
import '../../../domain/cubits/opcion/opcion_cubit.dart';
import '../../../domain/entities/agrupacion_entity.dart';
import '../../../domain/entities/criterio_entity.dart';
import '../../../domain/entities/opcion_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class MatrizEvaluacion extends StatefulWidget {
  const MatrizEvaluacion({super.key});

  @override
  State<MatrizEvaluacion> createState() => _MatrizEvaluacionState();
}

class _MatrizEvaluacionState extends State<MatrizEvaluacion> {
  late AgrupacionEntity agrupacion = AgrupacionEntity(
      agrupacionId: '', nombre: '', descripcion: '', convocatoriaId: '');
  bool showOpciones = false;

  @override
  Widget build(BuildContext context) {
    final agrupacionCubit = BlocProvider.of<AgrupacionCubit>(context);
    final criterioCubit = BlocProvider.of<CriterioCubit>(context);
    final opcionCubit = BlocProvider.of<OpcionCubit>(context);

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
            onChanged: (String? value) {
              setState(() {
                agrupacion = agrupacionCubit.state.agrupaciones!
                    .firstWhere(((element) => element.agrupacionId == value));

                criterioCubit.getCriteriosDB(agrupacion.agrupacionId);
              });
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
              Text('Puntaje Obtenido en ${agrupacion.nombre}',
                  style: Styles.subtitleStyle),
              const SizedBox(height: 20),
              Text('Descripción: Puntaje Obtenido en ${agrupacion.nombre}',
                  style: Styles.subtitleStyle),
              const SizedBox(height: 20),
              Text('Variable: Puntaje Obtenido en ${agrupacion.nombre}',
                  style: Styles.subtitleStyle),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                  isExpanded: true,
                  items: criterioCubit.state.criterios!
                      .map<DropdownMenuItem<String>>((CriterioEntity value) {
                    return DropdownMenuItem<String>(
                      value: value.criterioId,
                      child: Text(value.nombre),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    opcionCubit.getOpcionesDB(value!);

                    evaluacionRespuestaCubit.changeCriterio(value);
                    evaluacionRespuestaCubit.changeOpcion('');

                    setState(() => showOpciones = true);
                  },
                  hint: const Text('Criterios')),
              if (showOpciones)
                DropdownButtonFormField(
                    isExpanded: true,
                    value: evaluacionRespuestaCubit
                                .state.evaluacionRespuesta!.opcionId !=
                            ''
                        ? evaluacionRespuestaCubit
                            .state.evaluacionRespuesta!.opcionId
                        : null,
                    items: opcionCubit.state.opciones!
                        .map<DropdownMenuItem<String>>((OpcionEntity value) {
                      return DropdownMenuItem<String>(
                        value: value.opcionId,
                        child: Text(value.nombre),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      evaluacionRespuestaCubit.changeOpcion(value!);
                    },
                    hint: const Text('Opciones')),
              const SizedBox(height: 20),
              TextFormField(
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Observaciones', labelText: 'Observaciones'),
                onSaved: (String? newValue) {
                  evaluacionRespuestaCubit.changeObservacion(newValue!);
                },
              )
            ],
          ),
      ],
    );
  }
}
