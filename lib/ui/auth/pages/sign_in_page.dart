import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paap/domain/blocs/internet/internet_cubit.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../utils/validators/form_validators.dart';
import '../widgets/auth_background.dart';
import '../widgets/card_container.dart';
import '../widgets/custom_auth_input.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 250),
              CardContainer(
                  child: Column(
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  Text('Iniciar sesión',
                      style: Theme.of(context).textTheme.headline4),
                  const SignInForm()
                ],
              )),
              const SizedBox(height: 30.0),
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Conectado a internet'),
                          backgroundColor: Colors.green));
                    });
                    return const SizedBox();
                  } else if (state is InternetDisconnected) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('No hay conexión a internet'),
                          backgroundColor: Colors.red));
                    });
                    return const SizedBox();
                  }

                  return const CircularProgressIndicator();
                },
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AuthLoaded) {
                    return Text(state.usuarioAutenticado?.nombre ?? '');
                  } else if (state is AuthError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController usuarioIdCtrl = TextEditingController();
  TextEditingController contrasenaCtrl = TextEditingController();
  bool eyeToggle = false;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    final internetCubit = BlocProvider.of<InternetCubit>(context, listen: true);
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: usuarioIdCtrl,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: CustomAuthInput.inputDecoration(
                hintText: 'Correo electrónico',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_sharp),
            validator: (value) => FormValidators.validateEmail(value),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            controller: contrasenaCtrl,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            obscureText: eyeToggle,
            decoration: CustomAuthInput.inputDecoration(
              hintText: '******',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_outlined,
              suffixIcon: IconButton(
                  onPressed: () => setState(() => eyeToggle = !eyeToggle),
                  icon: eyeToggle
                      ? const Icon(
                          Icons.remove_red_eye,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.solidEyeSlash,
                          size: 18,
                        )),
            ),
            validator: (value) => FormValidators.validatePassword(value),
          ),
          const SizedBox(height: 30),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                if (!formKey.currentState!.validate()) return;

                if (internetCubit.state is InternetConnected) {
                  authBloc.add(LogIn(
                      usuarioId: usuarioIdCtrl.text,
                      contrasena: contrasenaCtrl.text));
                } else if (internetCubit.state is InternetDisconnected) {
                  authBloc.add(LogIn(
                      usuarioId: usuarioIdCtrl.text,
                      contrasena: contrasenaCtrl.text,
                      isOffline: true));
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: const Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              )),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
