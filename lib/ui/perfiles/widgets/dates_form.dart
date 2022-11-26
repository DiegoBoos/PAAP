import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/input_decoration.dart';

class DatesForm extends StatelessWidget {
  const DatesForm({
    Key? key,
    required this.formKeyDates,
    required this.savedDates,
    required this.dateFormat,
    required this.fechaInicialCtrl,
    required this.fechaFinalCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> formKeyDates;
  final bool savedDates;
  final DateFormat dateFormat;
  final TextEditingController fechaInicialCtrl;
  final TextEditingController fechaFinalCtrl;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyDates,
      child: Column(
        children: [
          TextFormField(
            enabled: savedDates ? false : true,
            controller: fechaInicialCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo Requerido';
              }
              if (DateTime.tryParse(value) == null) {
                return 'No es una fecha válida';
              }
              return null;
            },
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Fecha Inicial',
                labelText: 'Fecha Inicial',
                suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050));

                      if (newDate == null) return;

                      fechaInicialCtrl.text = dateFormat.format(newDate);
                    },
                    icon: const Icon(Icons.calendar_today))),
          ),
          const SizedBox(height: 20),
          TextFormField(
            enabled: savedDates ? false : true,
            controller: fechaFinalCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo Requerido';
              }
              if (DateTime.tryParse(value) == null) {
                return 'No es una fecha válida';
              }
              return null;
            },
            decoration: CustomInputDecoration.inputDecoration(
                hintText: 'Fecha Final',
                labelText: 'Fecha Final',
                suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100));

                      if (newDate == null) return;

                      fechaFinalCtrl.text = dateFormat.format(newDate);
                    },
                    icon: const Icon(Icons.calendar_today))),
          ),
        ],
      ),
    );
  }
}
