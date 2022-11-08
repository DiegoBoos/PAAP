import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/agrupacion/agrupacion_cubit.dart';
import '../../../domain/entities/agrupacion_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class MatrizEvaluacion extends StatefulWidget {
  const MatrizEvaluacion({
    Key? key,
  }) : super(key: key);

  @override
  State<MatrizEvaluacion> createState() => _MatrizEvaluacionState();
}

class _MatrizEvaluacionState extends State<MatrizEvaluacion> {
  static const List<String> puntos = <String>['1', '2', '3', '4'];
  String puntosValue = puntos.first;

  @override
  Widget build(BuildContext context) {
    final agrupacionCubit = BlocProvider.of<AgrupacionCubit>(context);
    return Column(
      children: [
        DropdownButtonFormField(
            items: agrupacionCubit.state.agrupaciones!
                .map<DropdownMenuItem<String>>((AgrupacionEntity value) {
              return DropdownMenuItem<String>(
                value: value.agrupacionId,
                child: Text(value.nombre),
              );
            }).toList(),
            onChanged: (value) {},
            hint: const Text('Agrupación')),
        const SizedBox(height: 10),
        Card(
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text('Características de la Alianza',
                    style: Styles.subtitleStyle.copyWith(color: Colors.white)),
                const SizedBox(height: 10),
                Text(
                    'Valoración asociada a las condiciones comerciales y de experiencia de los productores con la Alianza.',
                    style: Styles.subtitleStyle.copyWith(color: Colors.white)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Puntaje Obtenido en Características de la Alianza',
            style: Styles.titleStyle),
        const SizedBox(height: 20),
        const Text(
            'Descripción: Puntaje Obtenido en Características de la Alianza',
            style: Styles.subtitleStyle),
        const SizedBox(height: 20),
        const Text(
            'Variable: Puntaje Obtenido en Características de la Alianza',
            style: Styles.subtitleStyle),
        const SizedBox(height: 20),
        DropdownButtonFormField(
            items: puntos.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {},
            hint: const Text('Puntos')),
        const SizedBox(height: 20),
        TextFormField(
          decoration: CustomInputDecoration.inputDecoration(
              hintText: 'Observaciones', labelText: 'Observaciones'),
        )
      ],
    );
  }
}
