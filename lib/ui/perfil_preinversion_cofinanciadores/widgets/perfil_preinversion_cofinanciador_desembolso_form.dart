import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paap/ui/utils/loading_page.dart';

import '../../../domain/blocs/perfil_preinversion_cofinanciador_desembolsos/perfil_preinversion_cofinanciador_desembolsos_bloc.dart';
import '../../../domain/cubits/desembolso/desembolso_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import '../../../domain/entities/desembolso_entity.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/styles.dart';

class PerfilPreInversionCofinanciadorDesembolsoForm extends StatefulWidget {
  const PerfilPreInversionCofinanciadorDesembolsoForm({super.key});

  @override
  State<PerfilPreInversionCofinanciadorDesembolsoForm> createState() =>
      _PerfilPreInversionCofinanciadorDesembolsoFormState();
}

class _PerfilPreInversionCofinanciadorDesembolsoFormState
    extends State<PerfilPreInversionCofinanciadorDesembolsoForm> {
  var fechaCtrl = TextEditingController();
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    final perfilPreInversionCofinanciadorDesembolsosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsosBloc>(
            context);

    perfilPreInversionCofinanciadorDesembolsosBloc
        .add(GetPerfilPreInversionCofinanciadorDesembolsos());
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionCofinanciadorDesembolsoCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
            context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(children: [
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
                      perfilPreInversionCofinanciadorDesembolsoCubit
                          .changeDesembolso(value);
                    },
                    hint: const Text('Desembolso'));
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: fechaCtrl,
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Fecha',
                labelText: 'Fecha',
                suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: fechaCtrl.text != ''
                              ? DateTime.parse(fechaCtrl.text)
                              : DateTime.now(),
                          firstDate: DateTime(1000),
                          lastDate: DateTime(3000));

                      if (newDate == null) return;

                      fechaCtrl.text = dateFormat.format(newDate);

                      perfilPreInversionCofinanciadorDesembolsoCubit
                          .changeFecha(fechaCtrl.text);
                    },
                    icon: const Icon(Icons.calendar_today))),
          ),
          const SizedBox(height: 20),
          Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                  heroTag: 'desembolsoBtn',
                  onPressed: () {},
                  child: const Icon(Icons.add))),
          const PerfilPreInversionCofinanciadorDesembolsosRows()
        ]),
      ),
    );
  }
}

class PerfilPreInversionCofinanciadorDesembolsosRows extends StatelessWidget {
  const PerfilPreInversionCofinanciadorDesembolsosRows({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerfilPreInversionCofinanciadorDesembolsosBloc,
            PerfilPreInversionCofinanciadorDesembolsosState>(
        builder: (context, state) {
      if (state is PerfilPreInversionCofinanciadorDesembolsosLoading) {
        return const CustomCircularProgress(alignment: Alignment.center);
      }
      if (state is PerfilPreInversionCofinanciadorDesembolsosLoaded) {
        final perfilPreInversionCofinanciadorDesembolsos =
            state.perfilPreInversionCofinanciadorDesembolsosLoaded!;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.secondary),
            dividerThickness: 1,
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
            rows: List.generate(
                perfilPreInversionCofinanciadorDesembolsos.length, (index) {
              PerfilPreInversionCofinanciadorDesembolsoEntity
                  perfilPreInversionCofinanciadorDesembolso =
                  perfilPreInversionCofinanciadorDesembolsos[index];

              return DataRow(cells: <DataCell>[
                DataCell(Text(
                    perfilPreInversionCofinanciadorDesembolso.desembolsoId)),
                const DataCell(IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.cancel,
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
