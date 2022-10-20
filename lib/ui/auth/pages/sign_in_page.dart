import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paap/ui/utils/input_decoration.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/cubits/internet/internet_cubit.dart';
import '../../utils/validators/form_validators.dart';
import '../widgets/auth_background.dart';
import '../widgets/card_container.dart';

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
              BlocConsumer<InternetCubit, InternetState>(
                listener: (context, state) {
                  if (state is InternetConnected) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Conectado a internet'),
                        backgroundColor: Colors.green));
                  }
                  if (state is InternetDisconnected) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('No hay conexión a internet'),
                        backgroundColor: Colors.red));
                  }
                },
                builder: (context, state) {
                  if (state is InternetLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                if (state is AuthLoaded) {
                  Navigator.of(context).pushReplacementNamed('tabs');
                }
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red));
                }
              }, builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const SizedBox();
                }
              }),
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
          const SizedBox(height: 20.0),
          TextFormField(
            controller: usuarioIdCtrl,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: CustomInputDecoration.inputDecoration(
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
            decoration: CustomInputDecoration.inputDecoration(
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
