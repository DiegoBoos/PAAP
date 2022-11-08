import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/entities/municipio_entity.dart';

import '../../../domain/cubits/cofinanciador/cofinanciador_cubit.dart';
import '../../../domain/cubits/municipio/municipio_cubit.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/input_decoration.dart';
import 'edit_cofinanciador_form.dart';

class CofinanciadorForm extends StatefulWidget {
  const CofinanciadorForm(this.cofinanciadorId, {super.key});
  final String cofinanciadorId;
  @override
  State<CofinanciadorForm> createState() => _CofinanciadorFormState();
}

class _CofinanciadorFormState extends State<CofinanciadorForm> {
  @override
  Widget build(BuildContext context) {
    final municipioCubit = BlocProvider.of<MunicipioCubit>(context);
    return BlocBuilder<CofinanciadorCubit, CofinanciadorState>(
      builder: (context, state) {
        if (state is CofinanciadorLoading) {
          return const Center(
              heightFactor: 2, child: CircularProgressIndicator());
        }
        if (state is CofinanciadorLoaded) {
          final cofinanciador = state.cofinanciadorLoaded!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(children: [
              Card(
                child: Column(
                  children: [
                    DropdownButtonFormField(
                        items: municipioCubit.state.municipios!
                            .map<DropdownMenuItem<String>>(
                                (MunicipioEntity value) {
                          return DropdownMenuItem<String>(
                            value: value.id,
                            child: Text(value.nombre),
                          );
                        }).toList(),
                        onChanged: (value) {},
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Gobernación Atlántico',
                            labelText: 'Gobernación Atlántico')),
                    const SizedBox(height: 20),
                    TextFormField(
                        initialValue: cofinanciador.id,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Digite Monto',
                            labelText: 'Digite Monto')),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (widget.cofinanciadorId != '0') const EditCofinanciadorForm(),
              const SaveBackButtons(onSaved: null)
            ]),
          );
        }
        return const SizedBox();
      },
    );
  }
}
