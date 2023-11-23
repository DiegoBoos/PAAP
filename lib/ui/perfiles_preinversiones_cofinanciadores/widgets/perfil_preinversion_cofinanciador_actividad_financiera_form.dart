import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../ui/blocs/perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_bloc.dart';
import '../../../ui/blocs/perfil_preinversion_cofinanciador_desembolsos/perfil_preinversion_cofinanciador_desembolsos_bloc.dart';
import '../../../ui/cubits/actividad_financiera/actividad_financiera_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_cubit.dart';
import '../../../domain/entities/actividad_financiera_entity.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/input_decoration.dart';
import '../../utils/sync_pages.dart';
import '../../utils/styles.dart';

class PerfilPreInversionCofinanciadorActividadFinancieraForm
    extends StatefulWidget {
  const PerfilPreInversionCofinanciadorActividadFinancieraForm(
      this.perfilPreInversionCofinanciadorActividadFinanciera,
      {super.key});

  final PerfilPreInversionCofinanciadorActividadFinancieraEntity?
      perfilPreInversionCofinanciadorActividadFinanciera;

  @override
  State<PerfilPreInversionCofinanciadorActividadFinancieraForm> createState() =>
      _PerfilPreInversionCofinanciadorActividadFinancieraFormState();
}

class _PerfilPreInversionCofinanciadorActividadFinancieraFormState
    extends State<PerfilPreInversionCofinanciadorActividadFinancieraForm> {
  final formKeyActividadFinanciera = GlobalKey<FormState>();

  String? actividadFinancieraId;
  String? desembolsoId;

  final valorCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      actividadFinancieraId = widget
          .perfilPreInversionCofinanciadorActividadFinanciera
          ?.actividadFinancieraId;
      desembolsoId = widget
          .perfilPreInversionCofinanciadorActividadFinanciera?.desembolsoId;
      valorCtrl.text =
          widget.perfilPreInversionCofinanciadorActividadFinanciera?.valor ??
              '';
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(
      context,
    ).initState();
  }

  @override
  Widget build(BuildContext context) {
    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context,
            listen: true);

    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(context,
            listen: true);

    final perfilPreInversionCofinanciadorActividadesFinancierasBloc =
        BlocProvider.of<
                PerfilPreInversionCofinanciadorActividadesFinancierasBloc>(
            context,
            listen: true);

    final perfilPreInversionCofinanciadorRubroCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(context);

    final monto = perfilPreInversionCofinanciadorCubit
        .state.perfilPreInversionCofinanciador.monto;

    return BlocListener<PerfilPreInversionCofinanciadorActividadFinancieraCubit,
        PerfilPreInversionCofinanciadorActividadFinancieraState>(
      listener: (context, state) {
        if (state is PerfilPreInversionCofinanciadorActividadFinancieraSaved) {
          CustomSnackBar.showSnackBar(
              context, 'Datos guardados satisfactoriamente', Colors.green);

          final perfilPreInversionId = state
              .perfilPreInversionCofinanciadorActividadFinanciera
              .perfilPreInversionId;

          final cofinanciadorId = state
              .perfilPreInversionCofinanciadorActividadFinanciera
              .cofinanciadorId!;

          perfilPreInversionCofinanciadorActividadesFinancierasBloc.add(
              GetPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
            perfilPreInversionId: perfilPreInversionId,
            cofinanciadorId: cofinanciadorId,
          ));
        }
      },
      child: Form(
        key: formKeyActividadFinanciera,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(children: [
              BlocBuilder<ActividadFinancieraCubit, ActividadFinancieraState>(
                builder: (context, state) {
                  if (state is ActividadesFinancierasLoaded) {
                    return DropdownButtonFormField(
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Actividad Financiera',
                          labelText: 'Actividad Financiera'),
                      isExpanded: true,
                      value: actividadFinancieraId,
                      items: state.actividadesFinancieras!
                          .map<DropdownMenuItem<String>>(
                              (ActividadFinancieraEntity value) {
                        return DropdownMenuItem<String>(
                          value: value.actividadFinancieraId,
                          child: Text(value.nombre),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Debe seleccionar una actividad financiera';
                        }
                        return null;
                      },
                      onChanged: (String? value) {
                        perfilPreInversionCofinanciadorActividadFinancieraCubit
                            .changeActividadFinanciera(value);
                        perfilPreInversionCofinanciadorRubroCubit
                            .changeActividadFinanciera(value);
                      },
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<PerfilPreInversionCofinanciadorDesembolsosBloc,
                  PerfilPreInversionCofinanciadorDesembolsosState>(
                builder: (context, state) {
                  if (state
                      is PerfilPreInversionCofinanciadorDesembolsosLoaded) {
                    return DropdownButtonFormField(
                      decoration: CustomInputDecoration.inputDecoration(
                          hintText: 'Desembolso', labelText: 'Desembolso'),
                      isExpanded: true,
                      value: desembolsoId,
                      items: state.perfilPreInversionCofinanciadorDesembolsos!
                          .map<DropdownMenuItem<String>>(
                              (PerfilPreInversionCofinanciadorDesembolsoEntity
                                  value) {
                        return DropdownMenuItem<String>(
                          value: value.desembolsoId,
                          child: Text(value.desembolso!),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Debe seleccionar un desembolso';
                        }
                        return null;
                      },
                      onChanged: (String? value) {
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
                controller: valorCtrl,
                decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Valor',
                  labelText: 'Valor',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Debe seleccionar un valor';
                  }

                  if (monto != '' &&
                      double.parse(value) > double.parse(monto)) {
                    return 'El valor no puede ser mayor al monto';
                  }
                  return null;
                },
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
                        if (!formKeyActividadFinanciera.currentState!
                            .validate()) {
                          return;
                        }

                        formKeyActividadFinanciera.currentState!.save();

                        perfilPreInversionCofinanciadorActividadFinancieraCubit
                            .savePerfilPreInversionCofinanciadorActividadFinancieraDB(
                                perfilPreInversionCofinanciadorActividadFinancieraCubit
                                    .state
                                    .perfilPreInversionCofinanciadorActividadFinanciera);
                      },
                      child: const Icon(Icons.add))),
              const PerfilPreInversionCofinanciadorActividadesFinancierasRows()
            ]),
          ),
        ),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<
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
                    child: Text('Valor',
                        style: Styles.subtitleStyle
                            .copyWith(color: Colors.white, fontSize: 15)),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Actividad Financiera',
                        style: Styles.subtitleStyle
                            .copyWith(color: Colors.white, fontSize: 15)),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Desembolso',
                        style: Styles.subtitleStyle
                            .copyWith(color: Colors.white, fontSize: 15)),
                  ),
                ),
              ],
              rows: List.generate(
                  perfilPreInversionCofinanciadorActividadesFinancieras.length,
                  (index) {
                PerfilPreInversionCofinanciadorActividadFinancieraEntity
                    perfilPreInversionCofinanciadorActividadFinanciera =
                    perfilPreInversionCofinanciadorActividadesFinancieras[
                        index];

                final valor = NumberFormat.currency(
                        locale: 'en_US', decimalDigits: 0, symbol: "\$")
                    .format(double.parse(
                        perfilPreInversionCofinanciadorActividadFinanciera
                            .valor));

                return DataRow(cells: <DataCell>[
                  DataCell(Text(valor)),
                  DataCell(Text(
                      perfilPreInversionCofinanciadorActividadFinanciera
                          .actividadFinanciera!)),
                  DataCell(Text(
                      perfilPreInversionCofinanciadorActividadFinanciera
                          .desembolso!)),
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
