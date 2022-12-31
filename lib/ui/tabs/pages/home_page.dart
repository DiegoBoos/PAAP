import 'package:flutter/material.dart';
import '../../utils/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Bienvenidos a la Plataforma PAAP',
            style: Styles.titleStyle),
        const Text(
          'Proyecto Apoyo a Alianzas Productivas',
          style: Styles.subtitleStyle,
        ),
        Expanded(child: Container()),
        Center(child: Image.asset('assets/images/home.png')),
        const SizedBox(height: 20),
        const Text(
            'El Proyecto Apoyo a Alianzas Productivas – PAAP es un instrumento del Ministerio de Agricultura y Desarrollo Rural'),
        Expanded(child: Container())
      ]),
    ));
  }
}
