import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/blocs/perfil_preinversion_cofinanciador_desembolsos/perfil_preinversion_cofinanciador_desembolsos_bloc.dart';
import '../../../domain/cubits/desembolso/desembolso_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/desembolso_entity.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../utils/input_decoration.dart';
import '../../utils/loading_page.dart';
import '../../utils/styles.dart';

class PerfilPreInversionCofinanciadorDesembolsoForm extends StatefulWidget {
  const PerfilPreInversionCofinanciadorDesembolsoForm({super.key});
  @override
  State<PerfilPreInversionCofinanciadorDesembolsoForm> createState() =>
      _PerfilPreInversionCofinanciadorDesembolsoFormState();
}

class _PerfilPreInversionCofinanciadorDesembolsoFormState
    extends State<PerfilPreInversionCofinanciadorDesembolsoForm> {
  final formKeyDesembolso = GlobalKey<FormState>();

  String? desembolsoId;

  final dateFormat = DateFormat('yyyy-MM-dd');
  final fechaCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final perfilPreInversionCofinanciadorDesembolsoCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
            context);

    if (perfilPreInversionCofinanciadorDesembolsoCubit.state
        is PerfilPreInversionCofinanciadorDesembolsoLoaded) {
      final perfilPreInversionCofinanciadorDesembolsoLoaded =
          perfilPreInversionCofinanciadorDesembolsoCubit
              .state.perfilPreInversionCofinanciadorDesembolso;

      loadPerfilPreInversionCofinanciadorDesembolso(
          perfilPreInversionCofinanciadorDesembolsoLoaded);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
      context,
    ).initState();
  }

  void loadPerfilPreInversionCofinanciadorDesembolso(
      PerfilPreInversionCofinanciadorDesembolsoEntity
          perfilPreInversionCofinanciadorDesembolsoLoaded) {
    desembolsoId = perfilPreInversionCofinanciadorDesembolsoLoaded.desembolsoId;
    if (perfilPreInversionCofinanciadorDesembolsoLoaded.fecha != '') {
      fechaCtrl.text = dateFormat.format(DateTime.parse(
          perfilPreInversionCofinanciadorDesembolsoLoaded.fecha));
    } else {
      fechaCtrl.text = dateFormat.format(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionCofinanciadorDesembolsoCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
            context);

    final perfilPreInversionCofinanciadorDesembolsosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsosBloc>(context,
            listen: true);

    return BlocBuilder<PerfilPreInversionCofinanciadorDesembolsoCubit,
        PerfilPreInversionCofinanciadorDesembolsoState>(
      builder: (context, state) {
        return Form(
          key: formKeyDesembolso,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(children: [
                BlocBuilder<DesembolsoCubit, DesembolsoState>(
                  builder: (context, state) {
                    if (state is DesembolsosLoaded) {
                      return DropdownButtonFormField(
                          isExpanded: true,
                          value: desembolsoId != '' ? desembolsoId : null,
                          items: state.desembolsos!
                              .map<DropdownMenuItem<String>>(
                                  (DesembolsoEntity value) {
                            return DropdownMenuItem<String>(
                              value: value.desembolsoId,
                              child: Text(value.nombre),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Debe seleccionar un desembolso';
                            }
                            return null;
                          },
                          onChanged: (String? value) {
                            perfilPreInversionCofinanciadorDesembolsoCubit
                                .changeDesembolso(value);
                          },
                          hint: const Text('Desembolso'));
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: fechaCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debe seleccionar una fecha';
                    }
                    if (DateTime.tryParse(value) == null) {
                      return 'No es una fecha válida';
                    }
                    return null;
                  },
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Fecha',
                      labelText: 'Fecha',
                      suffixIcon: IconButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.parse(fechaCtrl.text),
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
                        onPressed: () {
                          if (!formKeyDesembolso.currentState!.validate()) {
                            return;
                          }
                          formKeyDesembolso.currentState!.save();

                          final vPerfilPreInversionId = vPerfilPreInversionCubit
                              .state.vPerfilPreInversion!.perfilPreInversionId;

                          final cofinanciadorId =
                              perfilPreInversionCofinanciadorCubit
                                  .state
                                  .perfilPreInversionCofinanciador
                                  .cofinanciadorId;

                          perfilPreInversionCofinanciadorDesembolsoCubit
                              .changePerfilPreInversion(vPerfilPreInversionId);

                          perfilPreInversionCofinanciadorDesembolsoCubit
                              .changeCofinanciador(cofinanciadorId);

                          perfilPreInversionCofinanciadorDesembolsoCubit
                              .savePerfilPreInversionCofinanciadorDesembolsoDB(
                                  perfilPreInversionCofinanciadorDesembolsoCubit
                                      .state
                                      .perfilPreInversionCofinanciadorDesembolso);

                          final desembolsoId =
                              perfilPreInversionCofinanciadorDesembolsoCubit
                                  .state
                                  .perfilPreInversionCofinanciadorDesembolso
                                  .desembolsoId;

                          perfilPreInversionCofinanciadorDesembolsosBloc.add(
                              GetPerfilPreInversionCofinanciadorDesembolsosByCofinanciador(
                                  perfilPreInversionId: vPerfilPreInversionId,
                                  cofinanciadorId: cofinanciadorId,
                                  desembolsoId: desembolsoId));

                          if (perfilPreInversionCofinanciadorDesembolsosBloc
                                  .state
                              is PerfilPreInversionCofinanciadorDesembolsosLoaded) {
                            perfilPreInversionCofinanciadorDesembolsoCubit
                                .canCreateActividadFinanciera();
                          }
                        },
                        child: const Icon(Icons.add))),
                const PerfilPreInversionCofinanciadorDesembolsosRows()
              ]),
            ),
          ),
        );
      },
    );
  }
}

class PerfilPreInversionCofinanciadorDesembolsosRows extends StatelessWidget {
  const PerfilPreInversionCofinanciadorDesembolsosRows({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<PerfilPreInversionCofinanciadorDesembolsosBloc,
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
                DataColumn(
                  label: Expanded(
                    child: Text('Fecha',
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
                  DataCell(Text(
                      perfilPreInversionCofinanciadorDesembolso.desembolso!)),
                  DataCell(
                      Text(perfilPreInversionCofinanciadorDesembolso.fecha)),
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
        return Container();
      }),
    );
  }
}
