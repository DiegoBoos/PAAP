import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/alianzas/alianzas_bloc.dart';
import '../../utils/input_decoration.dart';

class SearchCard extends StatelessWidget {
  SearchCard({
    Key? key,
    required this.enableId,
    required this.enableName,
  }) : super(key: key);

  final bool enableId;
  final bool enableName;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController idCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Filtros de búsqueda'),
              if (enableId)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: idCtrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          labelText: 'Buscar por ID del alianza',
                          hintText: 'Buscar por ID'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo requerido';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              if (enableName)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nameCtrl,
                      decoration: CustomInputDecoration.inputDecoration(
                          labelText: 'Buscar por nombre del alianza',
                          hintText: 'Buscar Alianza'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo requerido';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).buttonTheme.colorScheme!.primary,
                    ),
                    child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final alianzasBloc =
                                BlocProvider.of<AlianzasBloc>(context);

                            alianzasBloc.add(GetAlianzasFiltros(
                                id: idCtrl.text, nombre: nameCtrl.text));
                          }
                        },
                        icon: const Icon(Icons.search)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
