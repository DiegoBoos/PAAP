import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/cubits/agrupacion/agrupacion_cubit.dart';
import 'package:paap/domain/entities/agrupacion_entity.dart';

import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class Conceptos extends StatelessWidget {
  const Conceptos({
    Key? key,
  }) : super(key: key);

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
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text('Conceptos',
                    style: Styles.subtitleStyle.copyWith(color: Colors.white)),
                const SizedBox(height: 10),
                Text('Fortalezas, Debilidades, Riesgos y Resumen',
                    style: Styles.subtitleStyle.copyWith(color: Colors.white)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: CustomInputDecoration.inputDecoration(
              hintText: 'Fortalezas', labelText: 'Fortalezas'),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: CustomInputDecoration.inputDecoration(
              hintText: 'Debilidadaes', labelText: 'Debilidadaes'),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: CustomInputDecoration.inputDecoration(
              hintText: 'Riesgos', labelText: 'Riesgos'),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: CustomInputDecoration.inputDecoration(
              hintText: 'Resumen', labelText: 'Resumen'),
        )
      ],
    );
  }
}
