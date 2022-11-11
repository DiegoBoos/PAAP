import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paap/domain/cubits/agrupacion/agrupacion_cubit.dart';

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
    agrupacionCubit.getAgrupacionesDB(perfil.convocatoriaId);
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
            DatesForm(
                formKeyDates: formKeyDates,
                savedDates: savedDates,
                fechaInicialCtrl: fechaInicialCtrl,
                fechaFinalCtrl: fechaFinalCtrl,
                dateFormat: dateFormat),
            const SizedBox(height: 20),
            if (!savedDates)
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  heroTag: 'btn-save-dates',
                  onPressed: () {
                    if (!formKeyDates.currentState!.validate()) return;
                    setState(() => savedDates = true);
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.save),
                ),
              ),
            const SizedBox(height: 20),
            if (savedDates)
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
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue[900])),
                      ),
                    ),
                    if (toggleEvaluacion)
                      MatrizEvaluacion(formKeyRegistro: formKeyRegistro),
                    if (toggleConceptos)
                      Conceptos(formKeyRegistro: formKeyRegistro),
                    SaveFinishCancelButtons(
                        onCanceled: null,
                        onFinished: null,
                        onSaved: () {
                          if (!formKeyRegistro.currentState!.validate()) return;
                        })
                  ],
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
