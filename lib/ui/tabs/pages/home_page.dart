import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(authBloc.state.usuario!.usuarioId),
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'sign-in'))
          ],
        ),
        body: const Center(child: Text('Mostrar Inicio')));
  }
}
