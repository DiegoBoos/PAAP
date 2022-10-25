import 'package:flutter/material.dart';

import 'package:paap/ui/utils/styles.dart';

import '../../utils/network_icon.dart';
import '../widgets/perfil_form.dart';

class PerfilDetailPage extends StatelessWidget {
  const PerfilDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final perfilId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
        appBar: AppBar(title: const Text('Detalle Perfil'), actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: NetworkIcon(),
          )
        ]),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('PERFIL', style: Styles.titleStyle),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text('Información Básica', style: Styles.subtitleStyle),
            ),
            PerfilForm(perfilId)
          ]),
        ));
  }
}
