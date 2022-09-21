import 'package:flutter/material.dart';
import 'package:paap/ui/utils/input_decoration.dart';
import 'package:paap/ui/utils/validators/form_validators.dart';

import '../../../domain/entities/perfil.dart';

class NewEditPerfilPage extends StatelessWidget {
  const NewEditPerfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    PerfilEntity perfil = PerfilEntity(
        projectName: '',
        asociationName: '',
        address: '',
        contactName: '',
        email: '');

    return Scaffold(
        appBar: AppBar(title: const Text('Perfiles'), centerTitle: true),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;

              /* DBPerfils.createPerfil(perfil); */
            },
            child: const Icon(Icons.save)),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(children: [
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  initialValue: perfil.projectName,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del proyecto',
                      labelText: 'Nombre del proyecto'),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  initialValue: perfil.asociationName,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre de la Asociación',
                      labelText: 'Nombre de la Asociación'),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  initialValue: perfil.address,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Dirección', labelText: 'Dirección'),
                ),
                TextFormField(
                  initialValue: perfil.contactName,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Nombre del contacto',
                      labelText: 'Nombre del contacto'),
                ),
                TextFormField(
                  initialValue: perfil.email,
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Email', labelText: 'Email'),
                  validator: FormValidators.validateEmail(perfil.email),
                ),
                TextFormField(
                  initialValue: '${perfil.phone}',
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Teléfono Fijo', labelText: 'Teléfono Fijo'),
                ),
                TextFormField(
                  initialValue: '${perfil.cellPhone}',
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Teléfono Móvil', labelText: 'Teléfono Móvil'),
                ),
                TextFormField(
                  initialValue: '${perfil.totalProjectValue}',
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Valor Total del Proyecto',
                      labelText: 'Valor Total del Proyecto'),
                ),
                TextFormField(
                  initialValue: '${perfil.modularIncentive}',
                  decoration: CustomInputDecoration.inputDecoration(
                      hintText: 'Incentivo Modular',
                      labelText: 'Incentivo Modular'),
                ),
              ]),
            ),
          ),
        ));
  }
}
