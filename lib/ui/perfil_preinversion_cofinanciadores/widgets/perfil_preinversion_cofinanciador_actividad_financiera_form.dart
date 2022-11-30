import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_bloc.dart';
import '../../../domain/cubits/actividad_financiera/actividad_financiera_cubit.dart';
import '../../../domain/cubits/desembolso/desembolso_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
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
  final formKeyActividadFinanciera = GlobalKey<FormState>();

  String? actividadFinancieraId;
  String? desembolsoId;

  final valorCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(context);

    if (perfilPreInversionCofinanciadorActividadFinancieraCubit.state
        is PerfilPreInversionCofinanciadorActividadFinancieraLoaded) {
      final perfilPreInversionCofinanciadorActividadFinancieraLoaded =
          perfilPreInversionCofinanciadorActividadFinancieraCubit
              .state.perfilPreInversionCofinanciadorActividadFinanciera;

      loadPerfilPreInversionCofinanciadorActividadFinanciera(
          perfilPreInversionCofinanciadorActividadFinancieraLoaded);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(
      context,
    ).initState();
  }

  void loadPerfilPreInversionCofinanciadorActividadFinanciera(
      PerfilPreInversionCofinanciadorActividadFinancieraEntity
          perfilPreInversionCofinanciadorActividadFinancieraLoaded) {
    actividadFinancieraId =
        perfilPreInversionCofinanciadorActividadFinancieraLoaded
            .actividadFinancieraId;
    desembolsoId =
        perfilPreInversionCofinanciadorActividadFinancieraLoaded.desembolsoId;
    valorCtrl.text =
        perfilPreInversionCofinanciadorActividadFinancieraLoaded.valor;
  }

  @override
  Widget build(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(
      context,
    );

    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(context);

    final perfilPreInversionCofinanciadorDesembolsoCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
      context,
    );

    final perfilPreInversionCofinanciadorActividadesFinancierasBloc =
        BlocProvider.of<
                PerfilPreInversionCofinanciadorActividadesFinancierasBloc>(
            context,
            listen: true);

    final montoCofinanciador = perfilPreInversionCofinanciadorCubit
        .state.perfilPreInversionCofinanciador.monto;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(children: [
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
                      perfilPreInversionCofinanciadorActividadFinancieraCubit
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
                      perfilPreInversionCofinanciadorActividadFinancieraCubit
                          .changeDesembolso(value);
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
              if (int.parse(value) > int.parse(montoCofinanciador)) {
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
                    if (!formKeyActividadFinanciera.currentState!.validate()) {
                      return;
                    }

                    formKeyActividadFinanciera.currentState!.save();

                    final vPerfilPreInversionId = vPerfilPreInversionCubit
                        .state.vPerfilPreInversion!.perfilPreInversionId;

                    final cofinanciadorId = perfilPreInversionCofinanciadorCubit
                        .state.perfilPreInversionCofinanciador.cofinanciadorId;

                    final desembolsoId =
                        perfilPreInversionCofinanciadorDesembolsoCubit
                            .state
                            .perfilPreInversionCofinanciadorDesembolso
                            .desembolsoId;
                    final actividadFinancieraId =
                        perfilPreInversionCofinanciadorActividadFinancieraCubit
                            .state
                            .perfilPreInversionCofinanciadorActividadFinanciera
                            .actividadFinancieraId;

                    perfilPreInversionCofinanciadorActividadFinancieraCubit
                        .changePerfilPreInversion(vPerfilPreInversionId);
                    perfilPreInversionCofinanciadorActividadFinancieraCubit
                        .changeCofinanciador(cofinanciadorId);

                    perfilPreInversionCofinanciadorActividadFinancieraCubit
                        .perfilPreInversionCofinanciadorActividadFinancieraDB
                        .savePerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB(
                            perfilPreInversionCofinanciadorActividadFinancieraCubit
                                .state
                                .perfilPreInversionCofinanciadorActividadFinanciera);

                    perfilPreInversionCofinanciadorActividadesFinancierasBloc.add(
                        GetPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
                            perfilPreInversionId: vPerfilPreInversionId,
                            cofinanciadorId: cofinanciadorId,
                            actividadFinancieraId: actividadFinancieraId,
                            desembolsoId: desembolsoId));

                    if (perfilPreInversionCofinanciadorActividadesFinancierasBloc
                            .state
                        is PerfilPreInversionCofinanciadorActividadesFinancierasLoaded) {
                      perfilPreInversionCofinanciadorActividadFinancieraCubit
                          .canCreateRubro();
                    }
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
              ]);
            }),
          ),
        );
      }
      return Container();
    });
  }
}
