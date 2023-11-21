import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/cofinanciador_entity.dart';
import '../../utils/input_decoration.dart';

class PerfilPreInversionCofinanciadorForm extends StatefulWidget {
  const PerfilPreInversionCofinanciadorForm(
      {super.key,
      required this.perfilPreInversionCofinanciador,
      required this.cofinanciadores});
  final PerfilPreInversionCofinanciadorEntity? perfilPreInversionCofinanciador;
  final List<CofinanciadorEntity> cofinanciadores;

  @override
  State<PerfilPreInversionCofinanciadorForm> createState() =>
      _PerfilPreInversionCofinanciadorFormState();
}

class _PerfilPreInversionCofinanciadorFormState
    extends State<PerfilPreInversionCofinanciadorForm> {
  List<CofinanciadorEntity> cofinanciadoresFiltered = [];

  String? cofinanciadorId;
  final participacionCtrl = TextEditingController();
  final montoCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final municipio =
        vPerfilPreInversionCubit.state.vPerfilPreInversion!.municipio;

    setState(() {
      cofinanciadoresFiltered = widget.cofinanciadores
          .where((cofinanciador) => cofinanciador.municipio == municipio)
          .toList();

      cofinanciadorId = widget.perfilPreInversionCofinanciador?.cofinanciadorId;
      participacionCtrl.text =
          widget.perfilPreInversionCofinanciador?.participacion ?? '';
      montoCtrl.text = widget.perfilPreInversionCofinanciador?.monto ?? '';
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(
      context,
    ).initState();
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(children: [
          DropdownButtonFormField(
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Cofinanciador', labelText: 'Cofinanciador'),
            isExpanded: true,
            value: cofinanciadorId,
            items: cofinanciadoresFiltered
                .map<DropdownMenuItem<String>>((CofinanciadorEntity value) {
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
              perfilPreInversionCofinanciadorCubit.changeCofinanciador(value);
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
              enabled: false,
              controller: participacionCtrl,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Participación', labelText: 'Participación'))
        ]),
      ),
    );
  }
}
