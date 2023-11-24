import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/perfil_cofinanciador/perfil_cofinanciador_cubit.dart';
import '../../../domain/entities/cofinanciador_entity.dart';
import '../../utils/input_decoration.dart';

class PerfilCofinanciadorForm extends StatefulWidget {
  const PerfilCofinanciadorForm({super.key, required this.cofinanciadores});
  final List<CofinanciadorEntity> cofinanciadores;

  @override
  State<PerfilCofinanciadorForm> createState() =>
      _PerfilCofinanciadorFormState();
}

class _PerfilCofinanciadorFormState extends State<PerfilCofinanciadorForm> {
  List<CofinanciadorEntity> cofinanciadoresFiltered = [];

  String? cofinanciadorId;
  TextEditingController _cofinanciadorController = TextEditingController();
  final participacionCtrl = TextEditingController();
  final montoCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    final perfilCofinanciadorCubit =
        BlocProvider.of<PerfilCofinanciadorCubit>(context);

    final perfilCofinanciador =
        perfilCofinanciadorCubit.state.perfilCofinanciador;

    setState(() {
      cofinanciadoresFiltered = widget.cofinanciadores
          .where((cofinanciador) =>
              cofinanciador.municipio == perfilCofinanciador.municipio)
          .toList();

      cofinanciadorId = perfilCofinanciador.cofinanciadorId;

      if (cofinanciadorId != null) {
        final initialCofinanciador = cofinanciadoresFiltered.firstWhere(
          (cofinanciador) =>
              cofinanciador.id == perfilCofinanciador.cofinanciadorId,
        );
        _cofinanciadorController =
            TextEditingController(text: initialCofinanciador.nombre);
      }

      participacionCtrl.text = perfilCofinanciador.participacion ?? '';
      montoCtrl.text = perfilCofinanciador.monto ?? '';
    });
  }

  void clearSelection() {
    setState(() {
      cofinanciadorId = null;
      _cofinanciadorController.clear();
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<PerfilCofinanciadorCubit>(
      context,
    ).initState();
  }

  @override
  Widget build(BuildContext context) {
    final perfilCofinanciadorCubit =
        BlocProvider.of<PerfilCofinanciadorCubit>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(children: [
          Autocomplete<CofinanciadorEntity>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return cofinanciadoresFiltered.where((cofinanciador) {
                  return cofinanciador.nombre!
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              displayStringForOption: (CofinanciadorEntity option) =>
                  option.nombre!,
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                _cofinanciadorController = textEditingController;
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Cofinanciador',
                          labelText: 'Cofinanciador',
                        ),
                        controller: _cofinanciadorController,
                        focusNode: focusNode,
                        onFieldSubmitted: (value) {
                          onFieldSubmitted();
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: clearSelection,
                    ),
                  ],
                );
              },
              onSelected: (CofinanciadorEntity value) {
                setState(() {
                  cofinanciadorId = value.id;
                });
              },
              initialValue: _cofinanciadorController.value),
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
                perfilCofinanciadorCubit.changeMonto(newValue);
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
