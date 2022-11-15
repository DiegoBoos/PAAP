import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/input_decoration.dart';

class PerfilPreInversionCofinanciadorForm extends StatelessWidget {
  const PerfilPreInversionCofinanciadorForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerfilPreInversionCofinanciadorCubit,
        PerfilPreInversionCofinanciadorState>(
      builder: (context, state) {
        if (state is PerfilPreInversionCofinanciadorLoading) {
          return const Center(
              heightFactor: 2, child: CircularProgressIndicator());
        }
        if (state is PerfilPreInversionCofinanciadorLoaded) {
          final perfilPreInversionCofinanciador =
              state.perfilPreInversionCofinanciadorLoaded!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue:
                            perfilPreInversionCofinanciador.cofinanciadorId,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'ID Cofinanciador PreInversion',
                            labelText: 'ID Cofinanciador PreInversion')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue: perfilPreInversionCofinanciador.monto,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Años de experiencia',
                            labelText: 'Años de experiencia')),
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfilPreInversionCofinanciador.participacion,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre', labelText: 'Nombre')),
              TextFormField(
                  initialValue:
                      perfilPreInversionCofinanciador.perfilPreInversionId,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del contacto',
                      labelText: 'Nombre del contacto')),
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
