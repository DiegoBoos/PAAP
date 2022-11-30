import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/rubro/rubro_cubit.dart';
import '../../../domain/cubits/unidad/unidad_cubit.dart';
import '../../../domain/entities/actividad_financiera_entity.dart';
import '../../../domain/entities/rubro_entity.dart';
import '../../../domain/entities/unidad_entity.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class CostosUPTForm extends StatefulWidget {
  const CostosUPTForm(this.actividadesFinancieras, {super.key});

  final List<ActividadFinancieraEntity> actividadesFinancieras;

  @override
  State<CostosUPTForm> createState() => _CostosUPTFormState();
}

class _CostosUPTFormState extends State<CostosUPTForm> {
  final anioCtrl = TextEditingController();
  final cantidadCtrl = TextEditingController();
  final valorCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ListView(children: [
        const Text(
          'Costos UPT',
          style: Styles.titleStyle,
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                DropdownButtonFormField(
                    isExpanded: true,
                    items: widget.actividadesFinancieras
                        .where((actividadFinanciera) =>
                            actividadFinanciera.tipoMovimientoId == '2')
                        .map<DropdownMenuItem<String>>(
                            (ActividadFinancieraEntity value) {
                      return DropdownMenuItem<String>(
                        value: value.actividadFinancieraId,
                        child: Text(value.nombre),
                      );
                    }).toList(),
                    onChanged: (String? value) {},
                    hint: const Text('Actividad Financiera')),
                const SizedBox(height: 20),
                BlocBuilder<RubroCubit, RubroState>(
                  builder: (context, state) {
                    if (state is RubrosLoaded) {
                      return DropdownButtonFormField(
                          isExpanded: true,
                          items: state.rubros!.map<DropdownMenuItem<String>>(
                              (RubroEntity value) {
                            return DropdownMenuItem<String>(
                              value: value.rubroId,
                              child: Text(value.nombre),
                            );
                          }).toList(),
                          onChanged: (String? value) {},
                          hint: const Text('Rubro'));
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<UnidadCubit, UnidadState>(
                  builder: (context, state) {
                    if (state is UnidadesLoaded) {
                      return DropdownButtonFormField(
                          isExpanded: true,
                          items: state.unidades!.map<DropdownMenuItem<String>>(
                              (UnidadEntity value) {
                            return DropdownMenuItem<String>(
                              value: value.unidadId,
                              child: Text(value.nombre),
                            );
                          }).toList(),
                          onChanged: (String? value) {},
                          hint: const Text('Unidad'));
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: anioCtrl,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Año', labelText: 'Año')),
                const SizedBox(height: 20),
                TextFormField(
                    controller: cantidadCtrl,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Cantidad', labelText: 'Cantidad')),
                const SizedBox(height: 20),
                TextFormField(
                    controller: valorCtrl,
                    decoration: CustomInputDecoration.inputDecoration(
                        hintText: 'Valor', labelText: 'Valor')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SaveBackButtons(
          onSaved: null,
          routeName: 'tabs',
        )
      ]),
    );
  }
}
