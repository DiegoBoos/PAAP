import 'package:flutter/material.dart';

import '../../utils/input_decoration.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/conceptos.dart';
import '../widgets/floating_buttons.dart';
import '../widgets/matriz_evaluacion.dart';
import '../widgets/perfil_card.dart';

class RegistroVisitaPage extends StatefulWidget {
  const RegistroVisitaPage({super.key});

  @override
  State<RegistroVisitaPage> createState() => _RegistroVisitaPageState();
}

class _RegistroVisitaPageState extends State<RegistroVisitaPage> {
  final formKey = GlobalKey<FormState>();
  bool toggleConceptos = false;
  bool toggleEvaluacion = true;
  bool savedDates = false;

  @override
  Widget build(BuildContext context) {
    final perfilId = ModalRoute.of(context)?.settings.arguments as String;
    DateTime date = DateTime.now();
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
            PerfilCard(perfilId),
            const SizedBox(height: 30),
            const Text('Evaluación del Perfil', style: Styles.titleStyle),
            const SizedBox(height: 10),
            const Text('Creación', style: Styles.subtitleStyle),
            const SizedBox(height: 10),
            TextFormField(
              enabled: savedDates ? false : true,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Fecha Inicial',
                  labelText: 'Fecha Inicial',
                  suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050));

                        if (newDate == null) return;

                        setState(() => date = newDate);
                      },
                      icon: const Icon(Icons.calendar_today))),
            ),
            const SizedBox(height: 20),
            TextFormField(
              enabled: savedDates ? false : true,
              decoration: CustomInputDecoration.inputDecoration(
                  hintText: 'Fecha Final',
                  labelText: 'Fecha Final',
                  suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050));

                        if (newDate == null) return;

                        setState(() => date = newDate);
                      },
                      icon: const Icon(Icons.calendar_today))),
            ),
            const SizedBox(height: 20),
            if (!savedDates)
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  heroTag: 'btn-save-dates',
                  onPressed: () {
                    setState(() => savedDates = true);
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.save),
                ),
              ),
            const SizedBox(height: 20),
            if (savedDates)
              Column(
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
                  if (toggleEvaluacion) const MatrizEvaluacion(),
                  if (toggleConceptos) const Conceptos(),
                  const FloatingButtons()
                ],
              ),
          ]),
        ),
      ),
    );
  }
}
