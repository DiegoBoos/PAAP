import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../ui/blocs/perfil_preinversion_cofinanciador_desembolsos/perfil_preinversion_cofinanciador_desembolsos_bloc.dart';
import '../../../ui/cubits/desembolso/desembolso_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_cubit.dart';
import '../../../domain/entities/desembolso_entity.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/input_decoration.dart';
import '../../utils/sync_pages.dart';
import '../../utils/styles.dart';

class PerfilPreInversionCofinanciadorDesembolsoForm extends StatefulWidget {
  const PerfilPreInversionCofinanciadorDesembolsoForm(
      this.perfilPreInversionCofinanciadorDesembolso,
      {super.key});
  final PerfilPreInversionCofinanciadorDesembolsoEntity?
      perfilPreInversionCofinanciadorDesembolso;

  @override
  State<PerfilPreInversionCofinanciadorDesembolsoForm> createState() =>
      _PerfilPreInversionCofinanciadorDesembolsoFormState();
}

final dateFormat = DateFormat('yyyy-MM-dd');

class _PerfilPreInversionCofinanciadorDesembolsoFormState
    extends State<PerfilPreInversionCofinanciadorDesembolsoForm> {
  final formKeyDesembolso = GlobalKey<FormState>();
  final fechaCtrl = TextEditingController();
  String? desembolsoId;

  @override
  void initState() {
    super.initState();

    setState(() {
      desembolsoId =
          widget.perfilPreInversionCofinanciadorDesembolso?.desembolsoId;
      if (widget.perfilPreInversionCofinanciadorDesembolso?.fecha != null &&
          widget.perfilPreInversionCofinanciadorDesembolso?.fecha != '') {
        fechaCtrl.text = dateFormat.format(DateTime.parse(
            widget.perfilPreInversionCofinanciadorDesembolso!.fecha!));
      } else {
        fechaCtrl.text = dateFormat.format(DateTime.now());
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
      context,
    ).initState();
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionCofinanciadorDesembolsoCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
            context);

    final perfilPreInversionCofinanciadorDesembolsosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsosBloc>(context,
            listen: true);

    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(context);

    final perfilPreInversionCofinanciadorRubroCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(context);

    return BlocListener<PerfilPreInversionCofinanciadorDesembolsoCubit,
            PerfilPreInversionCofinanciadorDesembolsoState>(
        listener: (context, state) {
          if (state is PerfilPreInversionCofinanciadorDesembolsoSaved) {
            CustomSnackBar.showSnackBar(
                context, 'Datos guardados satisfactoriamente', Colors.green);

            final perfilPreInversionId = state
                .perfilPreInversionCofinanciadorDesembolso
                .perfilPreInversionId!;

            final cofinanciadorId = state
                .perfilPreInversionCofinanciadorDesembolso.cofinanciadorId!;

            perfilPreInversionCofinanciadorDesembolsosBloc.add(
                GetPerfilPreInversionCofinanciadorDesembolsosByCofinanciador(
              perfilPreInversionId: perfilPreInversionId,
              cofinanciadorId: cofinanciadorId,
            ));
          }
        },
        child: Form(
            key: formKeyDesembolso,
            child: Card(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(children: [
                    BlocBuilder<DesembolsoCubit, DesembolsoState>(
                      builder: (context, state) {
                        if (state is DesembolsosLoaded) {
                          return DropdownButtonFormField(
                            decoration: CustomInputDecoration.inputDecoration(
                                hintText: 'Desembolso',
                                labelText: 'Desembolso'),
                            isExpanded: true,
                            value: desembolsoId,
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
                              perfilPreInversionCofinanciadorActividadFinancieraCubit
                                  .changeDesembolso(value);
                              perfilPreInversionCofinanciadorRubroCubit
                                  .changeDesembolso(value);
                            },
                          );
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
                            onPressed: () {
                              if (!formKeyDesembolso.currentState!.validate()) {
                                return;
                              }
                              formKeyDesembolso.currentState!.save();

                              perfilPreInversionCofinanciadorDesembolsoCubit
                                  .savePerfilPreInversionCofinanciadorDesembolsoDB(
                                      perfilPreInversionCofinanciadorDesembolsoCubit
                                          .state
                                          .perfilPreInversionCofinanciadorDesembolso);
                            },
                            child: const Icon(Icons.add))),
                    const PerfilPreInversionCofinanciadorDesembolsosRows()
                  ])),
            )));
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
              ],
              rows: List.generate(
                  perfilPreInversionCofinanciadorDesembolsos.length, (index) {
                PerfilPreInversionCofinanciadorDesembolsoEntity
                    perfilPreInversionCofinanciadorDesembolso =
                    perfilPreInversionCofinanciadorDesembolsos[index];

                final fecha = perfilPreInversionCofinanciadorDesembolso.fecha !=
                            null &&
                        perfilPreInversionCofinanciadorDesembolso.fecha != ''
                    ? dateFormat.format(DateTime.parse(
                        perfilPreInversionCofinanciadorDesembolso.fecha!))
                    : '';

                return DataRow(cells: <DataCell>[
                  DataCell(Text(
                      perfilPreInversionCofinanciadorDesembolso.desembolso ??
                          '')),
                  DataCell(Text(fecha))
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
