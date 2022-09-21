import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/blocs/auth/auth_bloc.dart';
import 'package:paap/ui/home/widgets/expandable_menu.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/home_banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text('Inicio'),
          centerTitle: true,
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: const ExpandableMenu()));
  }
}

 /* Column(children: [
                 BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AuthHasData) {
                      return HomeBanner(
                        title: state.user!.email!,
                        subtitle: state.token,
                      );
                    } else if (state is AuthError) {
                      return const Center(
                        child: Text('Something went wrong!'),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(height: 20),
                Text('Módulos', style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 20),
                
              ]))), */
