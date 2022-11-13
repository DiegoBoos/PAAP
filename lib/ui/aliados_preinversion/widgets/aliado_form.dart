import 'package:flutter/material.dart';

/* import '../../../domain/entities/aliado_preinversion_entity.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/input_decoration.dart'; */

class AliadoPreinversionForm extends StatelessWidget {
  const AliadoPreinversionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox();

    /* return BlocBuilder<AliadoPreinversionCubit, AliadoPreinversionState>(
      builder: (context, state) {
        if (state is AliadoPreinversionLoading) {
          return const Center(
              heightFactor: 2, child: CircularProgressIndicator());
        }
        if (state is AliadoPreinversionLoaded) {
          final aliadoPreinversion = state.aliadoPreinversionLoaded!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue: aliadoPreinversion.aliadoPreinversionId,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'ID Aliado Preinversion',
                            labelText: 'ID Aliado Preinversion')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue: aliadoPreinversion.aniosExperiencia,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Años de experiencia',
                            labelText: 'Años de experiencia')),
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliadoPreinversion.nombre,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre', labelText: 'Nombre')),
              TextFormField(
                  initialValue: aliadoPreinversion.nombreContacto,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del contacto',
                      labelText: 'Nombre del contacto')),
              TextFormField(
                  initialValue: aliadoPreinversion.ciudad,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Ciudad', labelText: 'Ciudad')),
              TextFormField(
                  initialValue: aliadoPreinversion.correo,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Correo', labelText: 'Correo')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliadoPreinversion.telefonoMovil,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Teléfono Móvil', labelText: 'Teléfono Móvil')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliadoPreinversion.estado,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Estado', labelText: 'Estado')),
              const SizedBox(height: 20),
              const SaveBackButtons(onSaved: null)
            ]),
          );
        }
        return const SizedBox();
      },
    ); */
  }
}
