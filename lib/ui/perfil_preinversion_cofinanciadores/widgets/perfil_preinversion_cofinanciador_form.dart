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
  String? cofinanciadorId;
  final montoCtrl = TextEditingController();
  final participacionCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    if (perfilPreInversionCofinanciadorCubit.state
        is PerfilPreInversionCofinanciadorLoaded) {
      final perfilPreInversionCofinanciador =
          perfilPreInversionCofinanciadorCubit
              .state.perfilPreInversionCofinanciador!;

      cofinanciadorId = perfilPreInversionCofinanciador.cofinanciadorId;
      montoCtrl.text = perfilPreInversionCofinanciador.monto;
      participacionCtrl.text = perfilPreInversionCofinanciador.participacion;
    }
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreinversionCofinanciadorCubit =
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
                      value: cofinanciadorId,
                      items: state.cofinanciadores!
                          .map<DropdownMenuItem<String>>(
                              (CofinanciadorEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.id,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        perfilPreinversionCofinanciadorCubit
                            .changeCofinanciador(value);
                      },
                      hint: const Text('Cofinanciador'));
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
                controller: montoCtrl,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Monto', labelText: 'Monto'),
                onSaved: (String? newValue) {
                  perfilPreinversionCofinanciadorCubit.changeMonto(newValue);
                }),
            const SizedBox(height: 20),
            TextFormField(
                controller: participacionCtrl,
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Participación', labelText: 'Participación'),
                onSaved: (String? newValue) {
                  perfilPreinversionCofinanciadorCubit
                      .changeParticipacion(newValue);
                }),
          ]),
        ),
      );
    });
  }
}
