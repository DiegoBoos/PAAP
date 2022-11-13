import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/evaluacion/evaluacion_cubit.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class Conceptos extends StatelessWidget {
  const Conceptos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvaluacionCubit, EvaluacionState>(
      builder: (context, state) {
        if (state is EvaluacionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EvaluacionLoaded) {
          final evaluacionDB = state.evaluacionLoaded;
          if (evaluacionDB != null) {
            return Column(
              children: [
                Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text('Conceptos',
                            style: Styles.subtitleStyle
                                .copyWith(color: Colors.white)),
                        const SizedBox(height: 10),
                        Text('Fortalezas, Debilidades, Riesgos y Resumen',
                            style: Styles.subtitleStyle
                                .copyWith(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: evaluacionDB.fortalezas,
                  maxLines: null,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Fortalezas', labelText: 'Fortalezas'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: evaluacionDB.debilidades,
                  maxLines: null,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Debilidadaes', labelText: 'Debilidadaes'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: evaluacionDB.riesgos,
                  maxLines: null,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Riesgos', labelText: 'Riesgos'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: evaluacionDB.resumen,
                  maxLines: null,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Resumen', labelText: 'Resumen'),
                )
              ],
            );
          } else {
            return Column(
              children: [
                Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text('Conceptos',
                            style: Styles.subtitleStyle
                                .copyWith(color: Colors.white)),
                        const SizedBox(height: 10),
                        Text('Fortalezas, Debilidades, Riesgos y Resumen',
                            style: Styles.subtitleStyle
                                .copyWith(color: Colors.white)),
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
        return const SizedBox();
      },
    );
  }
}
