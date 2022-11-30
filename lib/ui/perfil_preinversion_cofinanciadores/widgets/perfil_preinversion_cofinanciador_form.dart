import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/cofinanciador/cofinanciador_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../domain/entities/cofinanciador_entity.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
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

  String? cofinanciadorId;

  final participacionCtrl = TextEditingController();
  final montoCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    if (perfilPreInversionCofinanciadorCubit.state
        is PerfilPreInversionCofinanciadorLoaded) {
      final perfilPreInversionCofinanciadorLoaded =
          perfilPreInversionCofinanciadorCubit
              .state.perfilPreInversionCofinanciador;

      loadPerfilPreInversionCofinanciador(
          perfilPreInversionCofinanciadorLoaded);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(
      context,
    ).initState();
  }

  void loadPerfilPreInversionCofinanciador(
      PerfilPreInversionCofinanciadorEntity
          perfilPreInversionCofinanciadorLoaded) {
    cofinanciadorId = perfilPreInversionCofinanciadorLoaded.cofinanciadorId;

    participacionCtrl.text =
        perfilPreInversionCofinanciadorLoaded.participacion;
    montoCtrl.text = perfilPreInversionCofinanciadorLoaded.monto;
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    return BlocBuilder<PerfilPreInversionCofinanciadorCubit,
        PerfilPreInversionCofinanciadorState>(builder: (context, state) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(children: [
            BlocBuilder<CofinanciadorCubit, CofinanciadorState>(
              builder: (context, state) {
                if (state is CofinanciadoresLoaded) {
                  return DropdownButtonFormField(
                      isExpanded: true,
                      value: cofinanciadorId != '' ? cofinanciadorId : null,
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
                controller: montoCtrl,
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
                controller: participacionCtrl,
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
