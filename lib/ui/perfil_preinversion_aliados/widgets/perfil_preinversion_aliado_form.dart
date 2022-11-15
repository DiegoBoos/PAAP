import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/perfil_preinversion_aliado/perfil_preinversion_aliado_cubit.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/input_decoration.dart';

class PerfilPreInversionAliadoForm extends StatelessWidget {
  const PerfilPreInversionAliadoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerfilPreInversionAliadoCubit,
        PerfilPreInversionAliadoState>(
      builder: (context, state) {
        if (state is PerfilPreInversionAliadoLoading) {
          return const Center(
              heightFactor: 2, child: CircularProgressIndicator());
        }
        if (state is PerfilPreInversionAliadoLoaded) {
          final perfilPreInversionAliado =
              state.perfilPreInversionAliadoLoaded!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                        initialValue: perfilPreInversionAliado.aliadoId,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'ID Aliado PreInversion',
                            labelText: 'ID Aliado PreInversion')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                        initialValue: perfilPreInversionAliado.frecuenciaId,
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Años de experiencia',
                            labelText: 'Años de experiencia')),
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfilPreInversionAliado.perfilPreInversionId,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre', labelText: 'Nombre')),
              TextFormField(
                  initialValue: perfilPreInversionAliado.porcentajeCompra,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del contacto',
                      labelText: 'Nombre del contacto')),
              TextFormField(
                  initialValue: perfilPreInversionAliado.productoId,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Ciudad', labelText: 'Ciudad')),
              TextFormField(
                  initialValue: perfilPreInversionAliado.unidadId,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Correo', labelText: 'Correo')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfilPreInversionAliado.sitioEntregaId,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Teléfono Móvil', labelText: 'Teléfono Móvil')),
              const SizedBox(height: 20),
              TextFormField(
                  initialValue: perfilPreInversionAliado.volumenCompra,
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
