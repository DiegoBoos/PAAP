import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/cubits/actividad_financiera/actividad_financiera_cubit.dart';
import 'package:paap/domain/cubits/rubro/rubro_cubit.dart';

import '../../../domain/cubits/desembolso/desembolso_cubit.dart';
import '../../../domain/entities/actividad_financiera_entity.dart';
import '../../../domain/entities/desembolso_entity.dart';
import '../../../domain/entities/rubro_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class EditCofinanciadorForm extends StatefulWidget {
  const EditCofinanciadorForm({super.key});

  @override
  State<EditCofinanciadorForm> createState() => _EditCofinanciadorFormState();
}

class _EditCofinanciadorFormState extends State<EditCofinanciadorForm> {
  @override
  Widget build(BuildContext context) {
    final desembolsoCubit = BlocProvider.of<DesembolsoCubit>(context);
    final actividadFinancieraCubit =
        BlocProvider.of<ActividadFinancieraCubit>(context);
    final rubroCubit = BlocProvider.of<RubroCubit>(context);
    return Column(
      children: [
        desembolsoCard(desembolsos: desembolsoCubit.state.desembolsos),
        actividadesCard(
            desembolsos: desembolsoCubit.state.desembolsos,
            actividadesFinancieras:
                actividadFinancieraCubit.state.actividadesFinancieras),
        rubrosCard(
            desembolsos: desembolsoCubit.state.desembolsos,
            actividadesFinancieras:
                actividadFinancieraCubit.state.actividadesFinancieras,
            rubros: rubroCubit.state.rubros)
      ],
    );
  }

  Card desembolsoCard({List<DesembolsoEntity>? desembolsos}) {
    return Card(
      child: Column(
        children: [
          DropdownButtonFormField(
              items: desembolsos!
                  .map<DropdownMenuItem<String>>((DesembolsoEntity value) {
                return DropdownMenuItem<String>(
                  value: value.desembolsoId,
                  child: Text(value.nombre),
                );
              }).toList(),
              onChanged: (value) {},
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Desembolso', labelText: 'Desembolso')),
          const SizedBox(height: 20),
          FloatingActionButton(
            heroTag: 'btn-add',
            onPressed: () {},
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.add),
          ),
          DataTable(
            headingRowColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary),
            dividerThickness: 1,
            columnSpacing: 10,
            dataRowHeight: 150,
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text('Nombre',
                      style:
                          Styles.subtitleStyle.copyWith(color: Colors.white)),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(''),
                ),
              ),
            ],
            rows: List.generate(desembolsos.length, (index) {
              DesembolsoEntity desembolso = desembolsos[index];

              return DataRow(cells: <DataCell>[
                DataCell(Text(desembolso.nombre)),
                DataCell(IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.cancel,
                    ))),
              ]);
            }),
          )
        ],
      ),
    );
  }

  Card actividadesCard(
      {List<DesembolsoEntity>? desembolsos,
      List<ActividadFinancieraEntity>? actividadesFinancieras}) {
    return Card(
      child: Column(
        children: [
          DropdownButtonFormField(
              items: actividadesFinancieras!.map<DropdownMenuItem<String>>(
                  (ActividadFinancieraEntity value) {
                return DropdownMenuItem<String>(
                  value: value.actividadFinancieraId,
                  child: Text(value.nombre),
                );
              }).toList(),
              onChanged: (value) {},
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Actividad', labelText: 'Actividad')),
          DropdownButtonFormField(
              items: desembolsos!
                  .map<DropdownMenuItem<String>>((DesembolsoEntity value) {
                return DropdownMenuItem<String>(
                  value: value.desembolsoId,
                  child: Text(value.nombre),
                );
              }).toList(),
              onChanged: (value) {},
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Desembolso', labelText: 'Desembolso')),
          const SizedBox(height: 20),
          TextFormField(
              initialValue: actividadFinanciera.valor,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Valor', labelText: 'Valor')),
          FloatingActionButton(
            heroTag: 'btn-add',
            onPressed: () {},
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.add),
          ),
          DataTable(
            headingRowColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary),
            dividerThickness: 1,
            columnSpacing: 10,
            dataRowHeight: 150,
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text('Actividad Financiera',
                      style:
                          Styles.subtitleStyle.copyWith(color: Colors.white)),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Valor',
                      style:
                          Styles.subtitleStyle.copyWith(color: Colors.white)),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(''),
                ),
              ),
            ],
            rows: List.generate(actividadesFinancieras.length, (index) {
              ActividadFinancieraEntity actividadFinanciera =
                  actividadesFinancieras[index];

              return DataRow(cells: <DataCell>[
                DataCell(Text(actividadFinanciera.nombre)),
                DataCell(IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.cancel,
                    ))),
              ]);
            }),
          )
        ],
      ),
    );
  }

  Card rubrosCard(
      {List<DesembolsoEntity>? desembolsos,
      List<ActividadFinancieraEntity>? actividadesFinancieras,
      List<RubroEntity>? rubros}) {
    return Card(
      child: Column(
        children: [
          DropdownButtonFormField(
              items: actividadesFinancieras!.map<DropdownMenuItem<String>>(
                  (ActividadFinancieraEntity value) {
                return DropdownMenuItem<String>(
                  value: value.actividadFinancieraId,
                  child: Text(value.nombre),
                );
              }).toList(),
              onChanged: (value) {},
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Actividad', labelText: 'Actividad')),
          DropdownButtonFormField(
              items: rubros!.map<DropdownMenuItem<String>>((RubroEntity value) {
                return DropdownMenuItem<String>(
                  value: value.rubroId,
                  child: Text(value.nombre),
                );
              }).toList(),
              onChanged: (value) {},
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Rubro', labelText: 'Rubro')),
          DropdownButtonFormField(
              items: desembolsos!
                  .map<DropdownMenuItem<String>>((DesembolsoEntity value) {
                return DropdownMenuItem<String>(
                  value: value.desembolsoId,
                  child: Text(value.nombre),
                );
              }).toList(),
              onChanged: (value) {},
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Desembolso', labelText: 'Desembolso')),
          const SizedBox(height: 20),
          TextFormField(
              initialValue: actividadFinanciera.valor,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Valor', labelText: 'Valor')),
          FloatingActionButton(
            heroTag: 'btn-add',
            onPressed: () {},
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.add),
          ),
          DataTable(
            headingRowColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary),
            dividerThickness: 1,
            columnSpacing: 10,
            dataRowHeight: 150,
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text('Rubro',
                      style:
                          Styles.subtitleStyle.copyWith(color: Colors.white)),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Valor',
                      style:
                          Styles.subtitleStyle.copyWith(color: Colors.white)),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(''),
                ),
              ),
            ],
            rows: List.generate(rubros.length, (index) {
              RubroEntity rubro = rubros[index];

              return DataRow(cells: <DataCell>[
                DataCell(Text(rubro.nombre)),
                DataCell(IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.cancel,
                    ))),
              ]);
            }),
          )
        ],
      ),
    );
  }
}
