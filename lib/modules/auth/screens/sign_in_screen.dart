import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:paap/modules/auth/auth_exports.dart';
import 'package:paap/utils/custom_input.dart';
import 'package:paap/utils/notifications.service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                  const SizedBox(height: 30.0),
                  ChangeNotifierProvider(
                      create: (_) => SignInFormProvider(),
                      child: _SignInForm()),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signInForm = Provider.of<SignInFormProvider>(context);
    return Form(
      key: signInForm.formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: CustomInput.inputDecoration(
                hintText: 'Correo electrónico',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_sharp),
            onChanged: (value) => signInForm.email = value,
            validator: (value) => FormValidators.validateEmail(value),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            obscureText: signInForm.eyeToggle,
            decoration: CustomInput.inputDecoration(
              hintText: '******',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_outlined,
              suffixIcon: IconButton(
                  onPressed: () => signInForm.eyeToggle = !signInForm.eyeToggle,
                  icon: signInForm.eyeToggle
                      ? const Icon(
                          Icons.remove_red_eye,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.solidEyeSlash,
                          size: 18,
                        )),
            ),
            onChanged: (value) => signInForm.password = value,
            validator: (value) => FormValidators.validatePassword(value),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                child: const Text(
                  '¿Olvidó su contraseña?',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                            create: (_) => ForgotPwdFormProvider(),
                            child: const ForgotPwdScreen())))),
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Theme.of(context).colorScheme.secondary,
              onPressed: signInForm.isLoading
                  ? null
                  : () async {
                      final navigator = Navigator.of(context);
                      FocusScope.of(context).unfocus();

                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!signInForm.isValidForm()) return;
                      signInForm.isLoading = true;

                      final resp = await authService.signIn(
                          signInForm.email, signInForm.password);

                      if (resp.containsKey('errorMessage')) {
                        NotificationService.showSnackBar(
                            resp['errorMessage'], Colors.red);
                      } else {
                        navigator.pushReplacementNamed('home');
                      }
                      signInForm.isLoading = false;
                    },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  signInForm.isLoading ? 'Espere...' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No tienes una cuenta?',
              ),
              TextButton(
                child: const Text('Regístrate'),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'sign-up'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
