import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/cofinanciador/cofinanciador_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../domain/entities/cofinanciador_entity.dart';
import '../../utils/input_decoration.dart';

class PerfilPreInversionCofinanciadorForm extends StatefulWidget {
  const PerfilPreInversionCofinanciadorForm({super.key});

  @override
  State<PerfilPreInversionCofinanciadorForm> createState() =>
      _PerfilPreInversionCofinanciadorFormState();
}

class _PerfilPreInversionCofinanciadorFormState
    extends State<PerfilPreInversionCofinanciadorForm> {
  final formKeyCofinanciador = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    return BlocBuilder<PerfilPreInversionCofinanciadorCubit,
        PerfilPreInversionCofinanciadorState>(builder: (context, state) {
      final perfilPreInversionCofinanciador =
          perfilPreInversionCofinanciadorCubit
              .state.perfilPreInversionCofinanciador;
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(children: [
            BlocBuilder<CofinanciadorCubit, CofinanciadorState>(
              builder: (context, state) {
                if (state is CofinanciadoresLoaded) {
                  return DropdownButtonFormField(
                      isExpanded: true,
                      value:
                          perfilPreInversionCofinanciador.cofinanciadorId != ''
                              ? perfilPreInversionCofinanciador.cofinanciadorId
                              : null,
                      items: state.cofinanciadores!
                          .map<DropdownMenuItem<String>>(
                              (CofinanciadorEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Debe seleccionar un cofinanciador';
                        }
                        return null;
                      },
                      onChanged: (String? value) {
                        perfilPreInversionCofinanciadorCubit
                            .changeCofinanciador(value);
                      },
                      hint: const Text('Cofinanciador'));
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
                key: UniqueKey(),
                initialValue: perfilPreInversionCofinanciador.monto,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Monto', labelText: 'Monto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Requerido';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  perfilPreInversionCofinanciadorCubit.changeMonto(newValue);
                }),
            const SizedBox(height: 20),
            TextFormField(
                key: UniqueKey(),
                initialValue: perfilPreInversionCofinanciador.participacion,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Participación', labelText: 'Participación'),
                onSaved: (String? newValue) {
                  perfilPreInversionCofinanciadorCubit
                      .changeParticipacion(newValue);
                }),
            const SizedBox(height: 20),
            Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                    heroTag: 'canCreateDesembolsoBtn',
                    onPressed: () {
                      if (!formKeyCofinanciador.currentState!.validate()) {
                        return;
                      }
                      formKeyCofinanciador.currentState!.save();

                      perfilPreInversionCofinanciadorCubit
                          .canCreateDesembolso();
                    },
                    child: const Icon(Icons.add))),
          ]),
        ),
      );
    });
  }
}
