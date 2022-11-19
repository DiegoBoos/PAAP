import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_bloc.dart';
import '../../../domain/cubits/actividad_financiera/actividad_financiera_cubit.dart';
import '../../../domain/cubits/desembolso/desembolso_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../../domain/entities/actividad_financiera_entity.dart';
import '../../../domain/entities/desembolso_entity.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/loading_page.dart';
import '../../utils/styles.dart';

class PerfilPreInversionCofinanciadorActividadFinancieraForm
    extends StatefulWidget {
  const PerfilPreInversionCofinanciadorActividadFinancieraForm({super.key});

  @override
  State<PerfilPreInversionCofinanciadorActividadFinancieraForm> createState() =>
      _PerfilPreInversionCofinanciadorActividadFinancieraFormState();
}

class _PerfilPreInversionCofinanciadorActividadFinancieraFormState
    extends State<PerfilPreInversionCofinanciadorActividadFinancieraForm> {
  @override
  Widget build(BuildContext context) {
    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(children: [
          BlocBuilder<ActividadFinancieraCubit, ActividadFinancieraState>(
            builder: (context, state) {
              if (state is ActividadesFinancierasLoaded) {
                return DropdownButtonFormField(
                    isExpanded: true,
                    items: state.actividadesFinancieras!
                        .map<DropdownMenuItem<String>>(
                            (ActividadFinancieraEntity value) {
                      return DropdownMenuItem<String>(
                        value: value.actividadFinancieraId,
                        child: Text(value.nombre),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      perfilPreInversionCofinanciadorActividadFinancieraCubit
                          .changeActividadFinanciera(value);
                    },
                    hint: const Text('Actividad Financiera'));
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<DesembolsoCubit, DesembolsoState>(
            builder: (context, state) {
              if (state is DesembolsosLoaded) {
                return DropdownButtonFormField(
                    isExpanded: true,
                    items: state.desembolsos!.map<DropdownMenuItem<String>>(
                        (DesembolsoEntity value) {
                      return DropdownMenuItem<String>(
                        value: value.desembolsoId,
                        child: Text(value.nombre),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      perfilPreInversionCofinanciadorActividadFinancieraCubit
                          .changeActividadFinanciera(value);
                    },
                    hint: const Text('Desembolso'));
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: CustomInputDecoration.inputDecoration(
              hintText: 'Valor',
              labelText: 'Valor',
            ),
            onSaved: (String? newValue) {
              perfilPreInversionCofinanciadorActividadFinancieraCubit
                  .changeValor(newValue);
            },
          ),
          const SizedBox(height: 20),
          Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                  heroTag: 'actividadFinancieraBtn',
                  onPressed: () {
                    //TODO: GuardarPerfilPreInversionCofinanciadorActividadFinanciera
                    final perfilPreInversionCofinanciadorActividadFinanciera =
                        perfilPreInversionCofinanciadorActividadFinancieraCubit
                            .state
                            .perfilPreInversionCofinanciadorActividadFinanciera;
                  },
                  child: const Icon(Icons.add))),
          const PerfilPreInversionCofinanciadorActividadesFinancierasRows()
        ]),
      ),
    );
  }
}

class PerfilPreInversionCofinanciadorActividadesFinancierasRows
    extends StatelessWidget {
  const PerfilPreInversionCofinanciadorActividadesFinancierasRows({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
            PerfilPreInversionCofinanciadorActividadesFinancierasBloc,
            PerfilPreInversionCofinanciadorActividadesFinancierasState>(
        builder: (context, state) {
      if (state
          is PerfilPreInversionCofinanciadorActividadesFinancierasLoading) {
        return const CustomCircularProgress(alignment: Alignment.center);
      }
      if (state
          is PerfilPreInversionCofinanciadorActividadesFinancierasLoaded) {
        final perfilPreInversionCofinanciadorActividadesFinancieras =
            state.perfilPreInversionCofinanciadorActividadesFinancieras!;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: DataTable(
            columnSpacing: 30,
            headingRowColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary),
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text('Actividad Financiera',
                      style: Styles.subtitleStyle
                          .copyWith(color: Colors.white, fontSize: 15)),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Valor',
                      style: Styles.subtitleStyle
                          .copyWith(color: Colors.white, fontSize: 15)),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(''),
                ),
              ),
            ],
            rows: List.generate(
                perfilPreInversionCofinanciadorActividadesFinancieras.length,
                (index) {
              PerfilPreInversionCofinanciadorActividadFinancieraEntity
                  perfilPreInversionCofinanciadorActividadFinanciera =
                  perfilPreInversionCofinanciadorActividadesFinancieras[index];

              return DataRow(cells: <DataCell>[
                DataCell(Text(perfilPreInversionCofinanciadorActividadFinanciera
                    .actividadFinancieraId)),
                DataCell(Text(
                    perfilPreInversionCofinanciadorActividadFinanciera.valor)),
                DataCell(IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.keyboard_arrow_right,
                    ))),
              ]);
            }),
          ),
        );
      }
      return const SizedBox();
    });
  }
}
