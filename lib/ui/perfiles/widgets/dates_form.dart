import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/input_decoration.dart';

class DatesForm extends StatelessWidget {
  DatesForm({
    Key? key,
    required this.formKeyDates,
    required this.savedDates,
    required this.dateFormat,
  }) : super(key: key);

  final GlobalKey<FormState> formKeyDates;
  final bool savedDates;
  final DateFormat dateFormat;

  final fechaInicialCtrl = TextEditingController();
  final fechaFinalCtrl = TextEditingController();

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
              if (value!.isEmpty) {
                return 'Campo Requerido';
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
              if (value!.isEmpty) {
                return 'Campo Requerido';
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
