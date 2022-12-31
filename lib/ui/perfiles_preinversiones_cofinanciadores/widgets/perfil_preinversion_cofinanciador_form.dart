import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/cofinanciador/cofinanciador_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/cofinanciador_entity.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../utils/custom_snack_bar.dart';
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
  String? departamento;

  final participacionCtrl = TextEditingController();
  final montoCtrl = TextEditingController();

  List<CofinanciadorEntity> cofinanciadoresFiltered = [];

  @override
  void initState() {
    super.initState();

    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    loadAccesories();

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

  Future<void> loadAccesories() async {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final cofinanciadorCubit = BlocProvider.of<CofinanciadorCubit>(context);

    await cofinanciadorCubit.getCofinanciadores();

    departamento =
        vPerfilPreInversionCubit.state.vPerfilPreInversion!.departamento;

    cofinanciadoresFiltered = cofinanciadorCubit.state.cofinanciadores!
        /*TODO: En método SOAP obtener datos TablaCofinanciadores se encuentran invertidos los campos municipio y departamento*/
        .where((cofinanciador) => cofinanciador.municipio == departamento)
        .toList();

    setState(() {});
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

    return BlocConsumer<PerfilPreInversionCofinanciadorCubit,
        PerfilPreInversionCofinanciadorState>(listener: (context, state) {
      if (state is PerfilPreInversionCofinanciadorSaved) {
        CustomSnackBar.showSnackBar(
            context, 'Datos guardados satisfactoriamente', Colors.green);
      }
    }, builder: (context, state) {
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
    });
  }
}
