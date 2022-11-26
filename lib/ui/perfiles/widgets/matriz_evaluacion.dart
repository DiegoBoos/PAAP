import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/evaluacion_respuesta_model.dart';
import '../../../domain/cubits/agrupacion/agrupacion_cubit.dart';
import '../../../domain/cubits/criterio/criterio_cubit.dart';
import '../../../domain/cubits/evaluacion/evaluacion_cubit.dart';
import '../../../domain/cubits/evaluacion_respuesta/evaluacion_respuesta_cubit.dart';
import '../../../domain/cubits/opcion/opcion_cubit.dart';
import '../../../domain/entities/agrupacion_entity.dart';
import '../../../domain/entities/criterio_entity.dart';
import '../../../domain/entities/evaluacion_respuesta_entity.dart';
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
  List<OpcionEntity>? opciones = [];
  List<EvaluacionRespuestaEntity> evaluacionesRespuestas = [];

  EvaluacionRespuestaModel evaluacionRespuesta = EvaluacionRespuestaModel(
      criterioId: '',
      evaluacionId: '',
      opcionId: '',
      observacion: '',
      recordStatus: '');

  @override
  Widget build(BuildContext context) {
    final agrupacionCubit = BlocProvider.of<AgrupacionCubit>(context);
    final opcionCubit = BlocProvider.of<OpcionCubit>(context);
    final criterioCubit = BlocProvider.of<CriterioCubit>(context);
    final evaluacionCubit = BlocProvider.of<EvaluacionCubit>(context);

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
              agrupacion = agrupacionCubit.state.agrupaciones!
                  .firstWhere(((element) => element.agrupacionId == value));

              await criterioCubit.getCriteriosDB(agrupacion.agrupacionId);

              if (criterioCubit.state is CriteriosLoaded &&
                  evaluacionCubit.state is EvaluacionLoaded) {
                opciones = await opcionCubit.getOpcionesDB();

                /*  final evaluacion = evaluacionCubit.state.evaluacion;
                final criterios = criterioCubit.state.criterios;

                for (var criterio in criterios!) {
                  final evaluacionesRespuestasDB =
                      await evaluacionRespuestaCubit
                          .getEvaluacionesRespuestasDB(
                              criterio.criterioId, evaluacion!.evaluacionId);

                  evaluacionesRespuestas.addAll(evaluacionesRespuestasDB!);
                }
                evaluacionRespuestaCubit
                    .selectEvaluacionesRespuestasDB(evaluacionesRespuestas); */
              }
              setState(() {});
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
              const SizedBox(height: 20),
              BlocBuilder<CriterioCubit, CriterioState>(
                builder: (context, state) {
                  if (state is CriteriosLoading) {
                    return const CustomCircularProgress(
                        alignment: Alignment.center);
                  } else if (state is CriteriosLoaded) {
                    List<CriterioEntity> criterios = state.criteriosLoaded!;

                    if (criterios.isEmpty) {
                      return const SizedBox(
                          child: Center(
                              child: NoDataSvg(title: 'No hay criterios')));
                    }

                    return BlocBuilder<EvaluacionRespuestaCubit,
                        EvaluacionRespuestaState>(
                      builder: (context, state) {
                        final evaluacionesRespuestas =
                            state.evaluacionesRespuestas;

                        return Column(
                            children: criterios
                                .indexedMap((criterio, index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(criterio.nombre,
                                            style: Styles.titleStyle
                                                .copyWith(fontSize: 20)),
                                        const SizedBox(height: 20),
                                        Text(
                                            'Descripción: ${criterio.descripcion}',
                                            style: Styles.subtitleStyle),
                                        const SizedBox(height: 20),
                                        Text('Variable: ${criterio.variable}',
                                            style: Styles.subtitleStyle),
                                        const SizedBox(height: 20),
                                        Column(
                                          children: [
                                            DropdownButtonFormField(
                                                isExpanded: true,
                                                /*  value: evaluacionesRespuestasLoaded[
                                                                  index]
                                                              .opcionId !=
                                                          ''
                                                      ? evaluacionesRespuestasLoaded[
                                                              index]
                                                          .opcionId
                                                      : null, */
                                                items: opciones!
                                                    .where((opcion) =>
                                                        opcion.criterioId ==
                                                        criterio.criterioId)
                                                    .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (OpcionEntity value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value.opcionId,
                                                    child: Text(value.nombre),
                                                  );
                                                }).toList(),
                                                onChanged: evaluacionCubit
                                                            .state
                                                            .evaluacion
                                                            ?.finalizado ==
                                                        'true'
                                                    ? null
                                                    : (String? value) {
                                                        evaluacionRespuesta
                                                            .opcionId = value!;
                                                      },
                                                hint: const Text('Opciones')),
                                            const SizedBox(height: 20),
                                            TextFormField(
                                              /*  initialValue:
                                                    evaluacionesRespuestasLoaded[
                                                            index]
                                                        .observacion, */
                                              enabled: evaluacionCubit
                                                          .state
                                                          .evaluacion
                                                          ?.finalizado ==
                                                      'true'
                                                  ? false
                                                  : true,
                                              decoration: CustomInputDecoration
                                                  .inputDecoration(
                                                      hintText: 'Observaciones',
                                                      labelText:
                                                          'Observaciones'),
                                              onSaved: (String? newValue) {
                                                evaluacionRespuesta
                                                    .observacion = newValue!;

                                                evaluacionesRespuestas.insert(
                                                    index, evaluacionRespuesta);

                                                evaluacionRespuestaCubit
                                                    .updateList(
                                                        evaluacionesRespuestas);
                                              },
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ))
                                .toList());
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
      ],
    );
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> indexedMap<T>(T Function(E element, int index) f) {
    var index = 0;
    return map((e) => f(e, index++));
  }
}
