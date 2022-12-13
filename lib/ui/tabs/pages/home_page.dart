import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../utils/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final usuario = authBloc.state.usuario!;
    return Scaffold(
        appBar: AppBar(
          title: ListTile(
              leading: const Icon(Icons.person_pin),
              title: Text('${usuario.nombre} ${usuario.apellido}',
                  style: const TextStyle(color: Colors.white))),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 60.0),
              child: IconButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'sign-in'),
                  icon: const Icon(Icons.logout)),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
