import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/utils/loading_page.dart';

import '../../../domain/usecases/actividad_financiera/actividad_financiera_exports.dart';
import '../../../domain/usecases/desembolso/desembolso_exports.dart';
import '../../../domain/usecases/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_exports.dart';
import '../../../domain/usecases/rubro/rubro_exports.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class PerfilPreInversionCofinanciadorRubroForm extends StatefulWidget {
  const PerfilPreInversionCofinanciadorRubroForm({super.key});

  @override
  State<PerfilPreInversionCofinanciadorRubroForm> createState() =>
      _PerfilPreInversionCofinanciadorRubroFormState();
}

class _PerfilPreInversionCofinanciadorRubroFormState
    extends State<PerfilPreInversionCofinanciadorRubroForm> {
  @override
  void initState() {
    super.initState();
    final perfilPreInversionCofinanciadorDesembolsosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubrosBloc>(context);

    perfilPreInversionCofinanciadorDesembolsosBloc
        .add(GetPerfilPreInversionCofinanciadorRubros());
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionCofinanciadorRubroCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(children: [
          BlocBuilder<RubroCubit, RubroState>(
            builder: (context, state) {
              if (state is RubrosLoaded) {
                return DropdownButtonFormField(
                    isExpanded: true,
                    items: state.rubros!
                        .map<DropdownMenuItem<String>>((RubroEntity value) {
                      return DropdownMenuItem<String>(
                        value: value.rubroId,
                        child: Text(value.nombre),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      perfilPreInversionCofinanciadorRubroCubit
                          .changeRubro(value);
                    },
                    hint: const Text('Rubro'));
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 20),
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
                      perfilPreInversionCofinanciadorRubroCubit
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
                      perfilPreInversionCofinanciadorRubroCubit
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
              perfilPreInversionCofinanciadorRubroCubit.changeValor(newValue);
            },
          ),
          const SizedBox(height: 20),
          Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                  heroTag: 'rubroBtn',
                  onPressed: () {},
                  child: const Icon(Icons.add))),
          const PerfilPreInversionCofinanciadorRubrosRows()
        ]),
      ),
    );
  }
}

class PerfilPreInversionCofinanciadorRubrosRows extends StatelessWidget {
  const PerfilPreInversionCofinanciadorRubrosRows({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerfilPreInversionCofinanciadorRubrosBloc,
        PerfilPreInversionCofinanciadorRubrosState>(builder: (context, state) {
      if (state is PerfilPreInversionCofinanciadorRubrosLoading) {
        return const CustomCircularProgress(alignment: Alignment.center);
      }
      if (state is PerfilPreInversionCofinanciadorRubrosLoaded) {
        final perfilPreInversionCofinanciadorRubros =
            state.perfilPreInversionCofinanciadorRubros!;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary),
            dividerThickness: 1,
            columnSpacing: 10,
            dataRowHeight: 150,
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text('ID',
                      style:
                          Styles.subtitleStyle.copyWith(color: Colors.white)),
                ),
              ),
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
            rows: List.generate(perfilPreInversionCofinanciadorRubros.length,
                (index) {
              PerfilPreInversionCofinanciadorRubroEntity
                  perfilPreInversionCofinanciadorRubro =
                  perfilPreInversionCofinanciadorRubros[index];

              return DataRow(cells: <DataCell>[
                DataCell(
                    Text(perfilPreInversionCofinanciadorRubro.cofinanciadorId)),
                DataCell(Text(perfilPreInversionCofinanciadorRubro.valor)),
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
