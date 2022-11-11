import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/usecases/criterio/criterio_exports.dart';
import 'package:paap/domain/usecases/opcion/opcion_exports.dart';

import '../../../domain/cubits/agrupacion/agrupacion_cubit.dart';
import '../../../domain/entities/agrupacion_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class MatrizEvaluacion extends StatefulWidget {
  const MatrizEvaluacion({
    required this.formKeyRegistro,
    Key? key,
  }) : super(key: key);

  final GlobalKey<FormState> formKeyRegistro;

  @override
  State<MatrizEvaluacion> createState() => _MatrizEvaluacionState();
}

class _MatrizEvaluacionState extends State<MatrizEvaluacion> {
  late AgrupacionEntity agrupacion = AgrupacionEntity(
      agrupacionId: '', nombre: '', descripcion: '', convocatoriaId: '');
  bool showOpciones = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgrupacionCubit, AgrupacionState>(
      builder: (context, state) {
        if (state is AgrupacionesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AgrupacionesLoaded) {
          return Column(
            children: [
              DropdownButtonFormField(
                  isExpanded: true,
                  items: state.agrupaciones!
                      .map<DropdownMenuItem<String>>((AgrupacionEntity value) {
                    return DropdownMenuItem<String>(
                      value: value.agrupacionId,
                      child: Text(value.nombre),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      agrupacion = state.agrupaciones!.firstWhere(
                          ((element) => element.agrupacionId == value));

                      final criterioCubit =
                          BlocProvider.of<CriterioCubit>(context);

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
                    Text(
                        'Descripción: Puntaje Obtenido en ${agrupacion.nombre}',
                        style: Styles.subtitleStyle),
                    const SizedBox(height: 20),
                    Text('Variable: Puntaje Obtenido en ${agrupacion.nombre}',
                        style: Styles.subtitleStyle),
                    const SizedBox(height: 20),
                    BlocBuilder<CriterioCubit, CriterioState>(
                      builder: (context, state) {
                        if (state is CriteriosLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is CriteriosLoaded) {
                          if (state.criteriosLoaded!.length > 1) {
                            return DropdownButtonFormField(
                                isExpanded: true,
                                items: state.criteriosLoaded!
                                    .map<DropdownMenuItem<String>>(
                                        (CriterioEntity value) {
                                  return DropdownMenuItem<String>(
                                    value: value.criterioId,
                                    child: Text(value.nombre),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  final opcionCubit =
                                      BlocProvider.of<OpcionCubit>(context);
                                  opcionCubit.getOpcionesDB(value.toString());
                                  setState(() => showOpciones = true);
                                },
                                hint: const Text('Criterios'));
                          } else if (state.criteriosLoaded!.length == 1) {
                            final opcionCubit =
                                BlocProvider.of<OpcionCubit>(context);
                            opcionCubit.getOpcionesDB(
                                state.criterios!.first.criterioId);
                            setState(() => showOpciones = true);
                          }
                        }
                        return const SizedBox();
                      },
                    ),
                    if (showOpciones)
                      BlocBuilder<OpcionCubit, OpcionState>(
                        builder: (context, state) {
                          if (state is OpcionesLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is OpcionesLoaded) {
                            if (state.opcionesLoaded!.length > 1) {
                              return DropdownButtonFormField(
                                  isExpanded: true,
                                  items: state.opcionesLoaded!
                                      .map<DropdownMenuItem<String>>(
                                          (OpcionEntity value) {
                                    return DropdownMenuItem<String>(
                                      value: value.opcionId,
                                      child: Text(value.nombre),
                                    );
                                  }).toList(),
                                  onChanged: (value) {},
                                  hint: const Text('Opciones'));
                            }
                          }
                          return const SizedBox();
                        },
                      ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Observaciones',
                          labelText: 'Observaciones'),
                    )
                  ],
                ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
