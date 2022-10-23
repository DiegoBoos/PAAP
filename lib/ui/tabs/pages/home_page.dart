import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../utils/network_icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(authBloc.state.usuario!.usuarioId),
          actions: [
            const NetworkIcon(),
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'sign-in'))
          ],
        ),
        body: Container());
  }
}
