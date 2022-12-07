import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/usecases/actividad_financiera/actividad_financiera_exports.dart';
import '../../../domain/usecases/desembolso/desembolso_exports.dart';
import '../../../domain/usecases/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_exports.dart';
import '../../../domain/usecases/rubro/rubro_exports.dart';
import '../../utils/input_decoration.dart';
import '../../utils/loading_page.dart';
import '../../utils/styles.dart';

class PerfilPreInversionCofinanciadorRubroForm extends StatefulWidget {
  const PerfilPreInversionCofinanciadorRubroForm({super.key});

  @override
  State<PerfilPreInversionCofinanciadorRubroForm> createState() =>
      _PerfilPreInversionCofinanciadorRubroFormState();
}

class _PerfilPreInversionCofinanciadorRubroFormState
    extends State<PerfilPreInversionCofinanciadorRubroForm> {
  final formKeyRubro = GlobalKey<FormState>();

  String? actividadFinancieraId;
  String? desembolsoId;
  String? rubroId;

  final valorCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final perfilPreInversionCofinanciadorRubroCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(context);

    if (perfilPreInversionCofinanciadorRubroCubit.state
        is PerfilPreInversionCofinanciadorRubroLoaded) {
      final perfilPreInversionCofinanciadorRubroLoaded =
          perfilPreInversionCofinanciadorRubroCubit
              .state.perfilPreInversionCofinanciadorRubro;

      loadPerfilPreInversionCofinanciadorRubro(
          perfilPreInversionCofinanciadorRubroLoaded);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(
      context,
    ).initState();
  }

  void loadPerfilPreInversionCofinanciadorRubro(
      PerfilPreInversionCofinanciadorRubroEntity
          perfilPreInversionCofinanciadorRubroLoaded) {
    actividadFinancieraId =
        perfilPreInversionCofinanciadorRubroLoaded.actividadFinancieraId;
    desembolsoId = perfilPreInversionCofinanciadorRubroLoaded.desembolsoId;
    rubroId = perfilPreInversionCofinanciadorRubroLoaded.rubroId;
    valorCtrl.text = perfilPreInversionCofinanciadorRubroLoaded.valor;
  }

  @override
  Widget build(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(context);

    final perfilPreInversionCofinanciadorRubroCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(context);

    final perfilPreInversionCofinanciadorRubrosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubrosBloc>(context,
            listen: true);

    final valorActividad =
        perfilPreInversionCofinanciadorActividadFinancieraCubit
            .state.perfilPreInversionCofinanciadorActividadFinanciera.valor;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(children: [
          BlocBuilder<RubroCubit, RubroState>(
            builder: (context, state) {
              if (state is RubrosLoaded) {
                return DropdownButtonFormField(
                    isExpanded: true,
                    value: rubroId != '' ? rubroId : null,
                    items: state.rubros!
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
                      perfilPreInversionCofinanciadorRubroCubit
                          .changeRubro(value);
                    },
                    hint: const Text('Rubro'));
              }
              return Container();
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<ActividadFinancieraCubit, ActividadFinancieraState>(
            builder: (context, state) {
              if (state is ActividadesFinancierasLoaded) {
                return DropdownButtonFormField(
                    isExpanded: true,
                    value: actividadFinancieraId != ''
                        ? actividadFinancieraId
                        : null,
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
                    },
                    hint: const Text('Actividad Financiera'));
              }
              return Container();
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<DesembolsoCubit, DesembolsoState>(
            builder: (context, state) {
              if (state is DesembolsosLoaded) {
                return DropdownButtonFormField(
                    isExpanded: true,
                    value: desembolsoId != '' ? desembolsoId : null,
                    items: state.desembolsos!.map<DropdownMenuItem<String>>(
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
                      perfilPreInversionCofinanciadorRubroCubit
                          .changeActividadFinanciera(value);
                    },
                    hint: const Text('Desembolso'));
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

              if (int.parse(value) > int.parse(valorActividad)) {
                return 'El valor no puede ser mayor al de la actividad';
              }
              return null;
            },
            onSaved: (String? newValue) {
              perfilPreInversionCofinanciadorRubroCubit.changeValor(newValue);
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

                    final cofinanciadorId = perfilPreInversionCofinanciadorCubit
                        .state.perfilPreInversionCofinanciador.cofinanciadorId;

                    perfilPreInversionCofinanciadorActividadFinancieraCubit
                        .changePerfilPreInversion(vPerfilPreInversionId);
                    perfilPreInversionCofinanciadorActividadFinancieraCubit
                        .changeCofinanciador(cofinanciadorId);

                    perfilPreInversionCofinanciadorRubroCubit
                        .perfilPreInversionCofinanciadorRubroDB
                        .savePerfilPreInversionCofinanciadorRubroUsecaseDB(
                            perfilPreInversionCofinanciadorRubroCubit
                                .state.perfilPreInversionCofinanciadorRubro);

                    /*  perfilPreInversionCofinanciadorRubrosBloc.add(
                        GetPerfilPreInversionCofinanciadorRubrosByCofinanciador(
                            perfilPreInversionId: vPerfilPreInversionId,
                            cofinanciadorId: cofinanciadorId,
                            actividadFinancieraId: actividadFinancieraId,
                            desembolsoId: desembolsoId,
                            rubroId: rubroId)); */
                  },
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
        final perfilPreInversionCofinanciadorRubrosLoaded =
            state.perfilPreInversionCofinanciadorRubrosLoaded!;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
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
