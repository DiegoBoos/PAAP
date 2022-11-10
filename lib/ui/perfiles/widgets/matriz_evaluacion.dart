import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  /* static const List<String> puntos = <String>['1', '2', '3', '4'];
  String puntosValue = puntos.first; */
  late AgrupacionEntity agrupacion = AgrupacionEntity(
      agrupacionId: '', nombre: '', descripcion: '', convocatoriaId: '');
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
                    /* const SizedBox(height: 20),
                    Text(
                        'Descripción: Puntaje Obtenido en ${agrupacion.nombre}',
                        style: Styles.subtitleStyle),
                     const SizedBox(height: 20),
                    Text('Variable: Puntaje Obtenido en ${agrupacion.nombre}',
                        style: Styles.subtitleStyle),
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                        items: puntos
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {},
                        hint: const Text('Puntos')), */
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
