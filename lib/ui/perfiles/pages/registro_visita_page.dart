import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../ui/blocs/auth/auth_bloc.dart';
import '../../../ui/cubits/agrupacion/agrupacion_cubit.dart';
import '../../../ui/cubits/evaluacion/evaluacion_cubit.dart';
import '../../../ui/cubits/evaluacion_respuesta/evaluacion_respuesta_cubit.dart';
import '../../../ui/cubits/v_perfil/v_perfil_cubit.dart';
import '../../../ui/cubits/visita/visita_cubit.dart';
import '../../../domain/entities/visita_entity.dart';
import '../../utils/custom_general_dialog.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/conceptos.dart';
import '../../utils/floating_buttons.dart';
import '../widgets/dates_form.dart';
import '../widgets/matriz_evaluacion.dart';
import '../widgets/perfil_card.dart';

class RegistroVisitaPage extends StatefulWidget {
  const RegistroVisitaPage({super.key});

  @override
  State<RegistroVisitaPage> createState() => _RegistroVisitaPageState();
}

class _RegistroVisitaPageState extends State<RegistroVisitaPage> {
  @override
  void initState() {
    super.initState();

    loadAccesories();
  }

  void loadAccesories() async {
    final vPerfilCubit = BlocProvider.of<VPerfilCubit>(context);
    final visitaCubit = BlocProvider.of<VisitaCubit>(context);
    final agrupacionCubit = BlocProvider.of<AgrupacionCubit>(context);

    await visitaCubit.getVisitaDB(vPerfilCubit.state.vPerfil!.perfilId, '1');

    await agrupacionCubit
        .getAgrupacionesDB(vPerfilCubit.state.vPerfil!.convocatoriaId);
  }

  @override
  void deactivate() {
    super.deactivate();
    BlocProvider.of<VisitaCubit>(context).initState();
    BlocProvider.of<EvaluacionCubit>(context).initState();
    BlocProvider.of<EvaluacionRespuestaCubit>(context).initState();
  }

  final formKeyDates = GlobalKey<FormState>();
  final formKeyRegistro = GlobalKey<FormState>();
  final fechaInicialCtrl = TextEditingController();
  final fechaFinalCtrl = TextEditingController();
  final dateFormat = DateFormat('yyyy-MM-dd');

  bool toggleConceptos = false;
  bool toggleEvaluacion = true;
  bool savedDates = false;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final vPerfilCubit = BlocProvider.of<VPerfilCubit>(context);
    final visitaCubit = BlocProvider.of<VisitaCubit>(context);
    final evaluacionCubit = BlocProvider.of<EvaluacionCubit>(context);
    final evaluacionRespuestaCubit =
        BlocProvider.of<EvaluacionRespuestaCubit>(context);

    final vPerfil = vPerfilCubit.state.vPerfil!;

    return MultiBlocListener(
      listeners: [
        BlocListener<VisitaCubit, VisitaState>(
          listener: (context, state) {
            if (state is VisitaSaved) {
              CustomSnackBar.showSnackBar(
                  context, 'Transacción realizada correctamente', Colors.green);
            } else if (state is VisitaError) {
              CustomSnackBar.showSnackBar(
                  context, 'Excepción no controlada', Colors.red);
            }
          },
        ),
        BlocListener<EvaluacionRespuestaCubit, EvaluacionRespuestaState>(
          listener: (context, state) {
            if (state is EvaluacionRespuestaSaved) {
              CustomSnackBar.showSnackBar(
                  context, 'Transacción realizada correctamente', Colors.green);
            } else if (state is EvaluacionRespuestaError) {
              CustomSnackBar.showSnackBar(
                  context, 'Excepción no controlada', Colors.red);
            }
          },
        ),
        BlocListener<EvaluacionCubit, EvaluacionState>(
          listener: (context, state) {
            if (state is EvaluacionSaved) {
              CustomSnackBar.showSnackBar(
                  context, 'Transacción realizada correctamente', Colors.green);
            } else if (state is EvaluacionError) {
              CustomSnackBar.showSnackBar(
                  context, 'Excepción no controlada', Colors.red);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Registro primera visita'),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: NetworkIcon(),
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 30),
              const PerfilCard(),
              const SizedBox(height: 30),
              const Text('Evaluación del Perfil', style: Styles.titleStyle),
              const SizedBox(height: 10),
              const Text('Crear', style: Styles.subtitleStyle),
              const SizedBox(height: 10),
              BlocBuilder<VisitaCubit, VisitaState>(
                builder: (context, state) {
                  if (state is VisitaInitial) {
                    return Column(
                      children: [
                        DatesForm(
                            formKeyDates: formKeyDates,
                            savedDates: savedDates,
                            fechaInicialCtrl: fechaInicialCtrl,
                            fechaFinalCtrl: fechaFinalCtrl,
                            dateFormat: dateFormat),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            heroTag: 'btn-save-dates',
                            onPressed: () async {
                              if (!formKeyDates.currentState!.validate()) {
                                return;
                              }

                              VisitaEntity newVisita = VisitaEntity(
                                  perfilId: vPerfil.perfilId,
                                  tipoVisitaId: '1',
                                  fechaInicial: fechaInicialCtrl.text,
                                  fechaFinal: fechaFinalCtrl.text,
                                  estadoVisitaId: '1',
                                  observacion: '',
                                  usuarioId: authBloc.state.usuario!.usuarioId,
                                  fechaRegistro:
                                      DateTime.now().toIso8601String(),
                                  recordStatus: 'N');

                              await visitaCubit
                                  .saveVisitaEvaluacionDB(newVisita);

                              await evaluacionCubit
                                  .getEvaluacionDB(vPerfil.perfilId);
                            },
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: const Icon(Icons.save),
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is VisitaLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is VisitaLoaded) {
                    evaluacionCubit.getEvaluacionDB(vPerfil.perfilId);
                    savedDates = true;
                    fechaInicialCtrl.text = dateFormat.format(
                        DateTime.parse(state.visitaLoaded.fechaInicial));
                    fechaFinalCtrl.text = dateFormat
                        .format(DateTime.parse(state.visitaLoaded.fechaFinal));
                    return Column(
                      children: [
                        DatesForm(
                            formKeyDates: formKeyDates,
                            savedDates: savedDates,
                            fechaInicialCtrl: fechaInicialCtrl,
                            fechaFinalCtrl: fechaFinalCtrl,
                            dateFormat: dateFormat),
                        const SizedBox(height: 20),
                        const SizedBox(height: 20),
                        Form(
                          key: formKeyRegistro,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      toggleEvaluacion = !toggleEvaluacion;
                                      toggleConceptos = !toggleConceptos;
                                    });
                                  },
                                  icon: const Icon(Icons.compare_arrows),
                                  label: Text(toggleConceptos
                                      ? 'IR A MATRIZ DE EVALUACIÓN'
                                      : 'IR A CONCEPTOS'),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.blue[900])),
                                ),
                              ),
                              if (toggleEvaluacion) const MatrizEvaluacion(),
                              if (toggleConceptos) const Conceptos(),
                              const SizedBox(height: 20),
                              BlocBuilder<EvaluacionCubit, EvaluacionState>(
                                builder: (context, state) {
                                  final evaluacion = state.evaluacion;
                                  return SaveFinishCancelButtons(
                                      finalizado: evaluacion.finalizado,
                                      onFinished: evaluacion.finalizado ==
                                              'true'
                                          ? null
                                          : () => showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CustomGeneralDialog(
                                                      title: 'Finalizar',
                                                      subtitle:
                                                          '¿Esta seguro que desea finalizar?',
                                                      confirmText: 'Aceptar',
                                                      cancelText: 'Cancelar',
                                                      onTapConfirm: () {
                                                        if (!formKeyRegistro
                                                            .currentState!
                                                            .validate()) {
                                                          return;
                                                        }
                                                        formKeyRegistro
                                                            .currentState!
                                                            .save();

                                                        evaluacionCubit
                                                            .changeFinalizado(
                                                                'true');

                                                        evaluacionCubit
                                                            .saveEvaluacionDB(
                                                                evaluacionCubit
                                                                    .state
                                                                    .evaluacion);

                                                        Navigator.popUntil(
                                                            context,
                                                            (route) =>
                                                                route.isFirst);
                                                      },
                                                      onTapCancel: () {
                                                        Navigator.pop(context);
                                                      })),
                                      onSaved: evaluacion.finalizado == 'true'
                                          ? null
                                          : () {
                                              if (!formKeyRegistro.currentState!
                                                  .validate()) {
                                                return;
                                              }
                                              formKeyRegistro.currentState!
                                                  .save();

                                              evaluacionRespuestaCubit
                                                  .saveEvaluacionRespuestaDB(
                                                      evaluacionRespuestaCubit
                                                          .state
                                                          .evaluacionRespuesta,
                                                      vPerfil.perfilId);
                                            });
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
