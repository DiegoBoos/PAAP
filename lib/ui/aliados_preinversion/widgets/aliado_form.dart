import 'package:flutter/material.dart';

class AliadoPreinversionForm extends StatefulWidget {
  const AliadoPreinversionForm({super.key});

  @override
  State<AliadoPreinversionForm> createState() => _AliadoPreinversionFormState();
}

class _AliadoPreinversionFormState extends State<AliadoPreinversionForm> {
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
          final aliadopreinversion = state.aliadopreinversionLoaded!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue: aliadopreinversion.aliadopreinversionId,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'ID AliadoPreinversion',
                            labelText: 'ID AliadoPreinversion')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue: aliadopreinversion.aniosExperiencia,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Años de experiencia',
                            labelText: 'Años de experiencia')),
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliadopreinversion.nombre,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre', labelText: 'Nombre')),
              TextFormField(
                  initialValue: aliadopreinversion.nombreContacto,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del contacto',
                      labelText: 'Nombre del contacto')),
              TextFormField(
                  initialValue: aliadopreinversion.ciudad,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Ciudad', labelText: 'Ciudad')),
              TextFormField(
                  initialValue: aliadopreinversion.correo,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Correo', labelText: 'Correo')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliadopreinversion.telefonoMovil,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Teléfono Móvil', labelText: 'Teléfono Móvil')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: aliadopreinversion.estado,
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
