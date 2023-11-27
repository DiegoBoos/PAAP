import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../domain/entities/cofinanciador_entity.dart';
import '../../cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
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
  TextEditingController _cofinanciadorController = TextEditingController();
  final participacionCtrl = TextEditingController();
  final montoCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final municipioPerfil =
        vPerfilPreInversionCubit.state.vPerfilPreInversion!.municipio;

    cofinanciadorId = widget.perfilPreInversionCofinanciador?.cofinanciadorId;

    setState(() {
      // Si se está editando un registro de la tabla PerfilPreInversionCofinanciador
      // Se filtra la lista de cofinanciadores por municipio y se asigna el valor inicial al controlador
      if (cofinanciadorId != null) {
        cofinanciadoresFiltered = widget.cofinanciadores
            .where((cofinanciador) =>
                cofinanciador.municipio ==
                widget.perfilPreInversionCofinanciador?.municipio)
            .toList();

        final initialValue = cofinanciadoresFiltered.firstWhere(
          (cofinanciador) =>
              cofinanciador.id ==
              widget.perfilPreInversionCofinanciador?.cofinanciadorId,
        );

        _cofinanciadorController =
            TextEditingController(text: initialValue.nombre);
      } else {
        cofinanciadoresFiltered = widget.cofinanciadores
            .where(
                (cofinanciador) => cofinanciador.municipio == municipioPerfil)
            .toList();
      }

      participacionCtrl.text =
          widget.perfilPreInversionCofinanciador?.participacion ?? '';
      montoCtrl.text = widget.perfilPreInversionCofinanciador?.monto ?? '';
    });
  }

  void clearSelection() {
    setState(() {
      cofinanciadorId = null;
      _cofinanciadorController.clear();
    });

    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(
      context,
    );

    perfilPreInversionCofinanciadorCubit.changeCofinanciadorId(cofinanciadorId);
  }

  // @override
  // void deactivate() {
  //   super.deactivate();

  //   final perfilPreInversionCofinanciadorCubit =
  //       BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(
  //     context,
  //   );

  //   perfilPreInversionCofinanciadorCubit.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

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
                perfilPreInversionCofinanciadorCubit
                    .changeCofinanciadorId(cofinanciadorId);
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
                perfilPreInversionCofinanciadorCubit.changeMonto(newValue);
              }),
          const SizedBox(height: 20),
          TextFormField(
            enabled: false,
            controller: participacionCtrl,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Participación', labelText: 'Participación'),
          )
        ]),
      ),
    );
  }
}
