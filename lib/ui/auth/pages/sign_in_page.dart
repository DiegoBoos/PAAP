import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/entities/usuario.dart';
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
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool eyeToggle = false;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailCtrl,
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
            controller: passwordCtrl,
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
          const Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: null,
              child: Text(
                '¿Olvidó su contraseña?',
                style: TextStyle(color: Colors.black),
              ),
              /*  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                            create: (_) => ForgotPwdFormProvider(),
                            child: const ForgotPwdPage()))) */
            ),
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () async {
                FocusScope.of(context).unfocus();

                if (!formKey.currentState!.validate()) return;

                /* authBloc.add(LogIn(newUser, 'myToken12345')); */
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
          const Text(
            'No tienes una cuenta?',
          ),
          TextButton(
            child: const Text('Regístrate'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'sign-up'),
          ),
        ],
      ),
    );
  }
}
