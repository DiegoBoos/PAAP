import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/utils/floating_buttons.dart';

import '../../../domain/cubits/aliado/aliado_cubit.dart';
import '../../utils/input_decoration.dart';

class AliadoForm extends StatefulWidget {
  const AliadoForm({super.key});

  @override
  State<AliadoForm> createState() => _AliadoFormState();
}

class _AliadoFormState extends State<AliadoForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AliadoCubit, AliadoState>(
      builder: (context, state) {
        if (state is AliadoLoading) {
          return const Center(
              heightFactor: 2, child: CircularProgressIndicator());
        }
        if (state is AliadoLoaded) {
          final aliado = state.aliadoLoaded!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue: aliado.aliadoId,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'ID Aliado', labelText: 'ID Aliado')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue: aliado.aniosExperiencia,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Años de experiencia',
                            labelText: 'Años de experiencia')),
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliado.nombre,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre', labelText: 'Nombre')),
              TextFormField(
                  initialValue: aliado.nombreContacto,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del contacto',
                      labelText: 'Nombre del contacto')),
              TextFormField(
                  initialValue: aliado.ciudad,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Ciudad', labelText: 'Ciudad')),
              TextFormField(
                  initialValue: aliado.correo,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Correo', labelText: 'Correo')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliado.telefonoMovil,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Teléfono Móvil', labelText: 'Teléfono Móvil')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliado.estado,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Estado', labelText: 'Estado')),
              const SizedBox(height: 20),
              const SaveBackButtons(onSaved: null)
            ]),
          );
        }
        return const SizedBox();
      },
    );
  }
}
