import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paap/domain/cubits/agrupacion/agrupacion_cubit.dart';
import 'package:paap/domain/cubits/criterio/criterio_cubit.dart';
import 'package:paap/domain/cubits/evaluacion/evaluacion_cubit.dart';
import 'package:paap/domain/cubits/opcion/opcion_cubit.dart';
import 'package:paap/domain/usecases/evaluacion/evaluacion_exports.dart';
import 'package:paap/domain/usecases/evaluacion_respuesta/evaluacion_respuesta_exports.dart';
import 'package:paap/domain/usecases/visita/visita_exports.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/cubits/evaluacion_respuesta/evaluacion_respuesta_cubit.dart';
import '../../../domain/entities/v_perfil_entity.dart';
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
    BlocProvider.of<AgrupacionCubit>(context).resetState();
    BlocProvider.of<CriterioCubit>(context).resetState();
    BlocProvider.of<OpcionCubit>(context).resetState();
    BlocProvider.of<VisitaCubit>(context).resetState();
    BlocProvider.of<EvaluacionCubit>(context).resetState();
    BlocProvider.of<EvaluacionRespuestaCubit>(context).resetState();
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
    final perfil = ModalRoute.of(context)?.settings.arguments as VPerfilEntity;
    final agrupacionCubit = BlocProvider.of<AgrupacionCubit>(context);
    final visitaCubit = BlocProvider.of<VisitaCubit>(context);
    final evaluacionCubit = BlocProvider.of<EvaluacionCubit>(context);
    final evaluacionRespuestaCubit =
        BlocProvider.of<EvaluacionRespuestaCubit>(context);

    agrupacionCubit.getAgrupacionesDB(perfil.convocatoriaId);
    evaluacionCubit.getEvaluacionDB(perfil.perfilId);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Primera visita del perfil'),
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
            PerfilCard(perfil: perfil),
            const SizedBox(height: 30),
            const Text('Evaluación del Perfil', style: Styles.titleStyle),
            const SizedBox(height: 10),
            const Text('Creación', style: Styles.subtitleStyle),
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
                          onPressed: () {
                            if (!formKeyDates.currentState!.validate()) {
                              return;
                            }
                            final authBloc = BlocProvider.of<AuthBloc>(context);
                            VisitaEntity newVisita = VisitaEntity(
                                perfilId: perfil.perfilId,
                                tipoVisitaId: '1',
                                fechaInicial: fechaInicialCtrl.text,
                                fechaFinal: fechaFinalCtrl.text,
                                estadoVisitaId: '1',
                                observacion: '',
                                usuarioId: authBloc.state.usuario!.usuarioId,
                                fechaRegistro: DateTime.now().toString());

                            visitaCubit.getVisitaDB(newVisita);
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
                  savedDates = true;
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
                            SaveFinishCancelButtons(
                                onCanceled: null,
                                onFinished: null,
                                onSaved: () {
                                  if (!formKeyRegistro.currentState!
                                      .validate()) {
                                    return;
                                  }
                                  formKeyRegistro.currentState!.save();

                                  final evaluacionRespuestaCubit =
                                      BlocProvider.of<EvaluacionRespuestaCubit>(
                                          context);

                                  final evaluacionRespuesta =
                                      evaluacionRespuestaCubit
                                          .state.evaluacionRespuesta!;

                                  evaluacionRespuestaCubit
                                      .saveEvaluacionRespuestaDB(
                                          evaluacionRespuesta, perfil.perfilId);
                                })
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
