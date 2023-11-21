import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/perfil_preinversion_cofinanciador_desembolsos/perfil_preinversion_cofinanciador_desembolsos_bloc.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../ui/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../../domain/usecases/actividad_financiera/actividad_financiera_exports.dart';
import '../../../domain/usecases/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_exports.dart';
import '../../../domain/usecases/rubro/rubro_exports.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/input_decoration.dart';
import '../../utils/sync_pages.dart';
import '../../utils/styles.dart';

class PerfilPreInversionCofinanciadorRubroForm extends StatefulWidget {
  const PerfilPreInversionCofinanciadorRubroForm(
      {super.key, required this.perfilPreInversionCofinanciadorRubro});

  final PerfilPreInversionCofinanciadorRubroEntity?
      perfilPreInversionCofinanciadorRubro;

  @override
  State<PerfilPreInversionCofinanciadorRubroForm> createState() =>
      _PerfilPreInversionCofinanciadorRubroFormState();
}

class _PerfilPreInversionCofinanciadorRubroFormState
    extends State<PerfilPreInversionCofinanciadorRubroForm> {
  final formKeyRubro = GlobalKey<FormState>();

  List<RubroEntity> rubrosFiltered = [];

  String? actividadFinancieraId;
  String? desembolsoId;
  String? rubroId;

  final valorCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final rubroCubit = BlocProvider.of<RubroCubit>(context);

    setState(() {
      actividadFinancieraId =
          widget.perfilPreInversionCofinanciadorRubro?.actividadFinancieraId;
      desembolsoId = widget.perfilPreInversionCofinanciadorRubro?.desembolsoId;
      rubroId = widget.perfilPreInversionCofinanciadorRubro?.rubroId;
      valorCtrl.text = widget.perfilPreInversionCofinanciadorRubro?.valor ?? '';

      if (rubroCubit.state is RubrosLoaded) {
        rubrosFiltered = rubroCubit.state.rubros!
            .where(((rubro) =>
                rubro.actividadFinancieraId == actividadFinancieraId))
            .toList();
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(
      context,
    ).initState();
  }

  @override
  Widget build(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final rubroCubit = BlocProvider.of<RubroCubit>(context);

    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(context);

    final perfilPreInversionCofinanciadorRubroCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(context,
            listen: true);

    final perfilPreInversionCofinanciadorRubrosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubrosBloc>(context,
            listen: true);

    final perfilPreInversionCofinanciadorDesembolsosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsosBloc>(context,
            listen: true);

    final valorActividad =
        perfilPreInversionCofinanciadorActividadFinancieraCubit
            .state.perfilPreInversionCofinanciadorActividadFinanciera.valor;

    return BlocListener<PerfilPreInversionCofinanciadorRubroCubit,
        PerfilPreInversionCofinanciadorRubroState>(
      listener: (context, state) {
        if (state is PerfilPreInversionCofinanciadorRubroSaved) {
          CustomSnackBar.showSnackBar(
              context, 'Datos guardados satisfactoriamente', Colors.green);

          perfilPreInversionCofinanciadorRubrosBloc.add(
              GetPerfilPreInversionCofinanciadorRubrosByCofinanciador(
                  perfilPreInversionId: vPerfilPreInversionCubit
                      .state.vPerfilPreInversion!.perfilPreInversionId,
                  cofinanciadorId: state
                      .perfilPreInversionCofinanciadorRubro.cofinanciadorId));
        }
      },
      child: Form(
        key: formKeyRubro,
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
                        perfilPreInversionCofinanciadorRubroCubit
                            .changeActividadFinanciera(value);

                        setState(() {
                          rubrosFiltered = rubroCubit.state.rubros!
                              .where(((rubro) =>
                                  rubro.actividadFinancieraId == value))
                              .toList();

                          rubroId = null;
                        });
                      },
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                decoration: CustomInputDecoration.inputDecoration(
                    hintText: 'Rubro', labelText: 'Rubro'),
                isExpanded: true,
                value: rubroId,
                items: rubrosFiltered
                    .map<DropdownMenuItem<String>>((RubroEntity value) {
                  return DropdownMenuItem<String>(
                    value: value.rubroId,
                    child: Text(value.nombre),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Debe seleccionar un rubro';
                  }
                  return null;
                },
                onChanged: (String? value) {
                  perfilPreInversionCofinanciadorRubroCubit.changeRubro(value);
                  setState(() {
                    rubroId = value;
                  });
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
                      items: perfilPreInversionCofinanciadorDesembolsosBloc
                          .state.perfilPreInversionCofinanciadorDesembolsos!
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

                  if (double.parse(value) > double.parse(valorActividad)) {
                    return 'El valor no puede ser mayor al de la actividad';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  perfilPreInversionCofinanciadorRubroCubit
                      .changeValor(newValue);
                },
              ),
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                      heroTag: 'rubroBtn',
                      onPressed: () {
                        if (!formKeyRubro.currentState!.validate()) {
                          return;
                        }

                        formKeyRubro.currentState!.save();

                        final vPerfilPreInversionId = vPerfilPreInversionCubit
                            .state.vPerfilPreInversion!.perfilPreInversionId;

                        final cofinanciadorId =
                            perfilPreInversionCofinanciadorCubit
                                .state
                                .perfilPreInversionCofinanciador
                                .cofinanciadorId!;

                        perfilPreInversionCofinanciadorRubroCubit
                            .changePerfilPreInversionId(vPerfilPreInversionId);

                        perfilPreInversionCofinanciadorRubroCubit
                            .changeCofinanciador(cofinanciadorId);

                        perfilPreInversionCofinanciadorRubroCubit
                            .savePerfilPreInversionCofinanciadorRubroDB(
                                perfilPreInversionCofinanciadorRubroCubit.state
                                    .perfilPreInversionCofinanciadorRubro);
                      },
                      child: const Icon(Icons.add))),
              const PerfilPreInversionCofinanciadorRubrosRows()
            ]),
          ),
        ),
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
        final perfilPreInversionCofinanciadorRubrosLoaded =
            state.perfilPreInversionCofinanciadorRubrosLoaded!;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary),
              columnSpacing: 30,
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
                    child: Text('Rubro',
                        style:
                            Styles.subtitleStyle.copyWith(color: Colors.white)),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Desembolso',
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
              ],
              rows: List.generate(
                  perfilPreInversionCofinanciadorRubrosLoaded.length, (index) {
                PerfilPreInversionCofinanciadorRubroEntity
                    perfilPreInversionCofinanciadorRubro =
                    perfilPreInversionCofinanciadorRubrosLoaded[index];

                return DataRow(cells: <DataCell>[
                  DataCell(Text(perfilPreInversionCofinanciadorRubro
                      .actividadFinanciera!)),
                  DataCell(Text(perfilPreInversionCofinanciadorRubro.rubro!)),
                  DataCell(
                      Text(perfilPreInversionCofinanciadorRubro.desembolso!)),
                  DataCell(Text(perfilPreInversionCofinanciadorRubro.valor)),
                ]);
              }),
            ),
          ),
        );
      }
      return Container();
    });
  }
}
