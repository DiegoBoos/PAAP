import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:paap/modules/auth/auth_exports.dart';
import 'package:paap/utils/custom_input.dart';
import 'package:paap/utils/notifications.service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  Text('Registrarse',
                      style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: 30.0),
                  ChangeNotifierProvider(
                      create: (_) => SignUpFormProvider(),
                      child: _SignUpForm()),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signUpForm = Provider.of<SignUpFormProvider>(context);
    return Form(
      key: signUpForm.formKey,
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
            onChanged: (value) => signUpForm.email = value,
            validator: (value) => FormValidators.validateEmail(value),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            obscureText: signUpForm.eyeToggle,
            decoration: CustomInput.inputDecoration(
                hintText: '******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outlined,
                suffixIcon: IconButton(
                    onPressed: () =>
                        signUpForm.eyeToggle = !signUpForm.eyeToggle,
                    icon: signUpForm.eyeToggle
                        ? const Icon(
                            Icons.remove_red_eye,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.solidEyeSlash,
                            size: 18,
                          ))),
            onChanged: (value) => signUpForm.password = value,
            validator: (value) => FormValidators.validatePassword(value),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            obscureText: signUpForm.eyeToggle,
            decoration: CustomInput.inputDecoration(
                hintText: '******',
                labelText: 'Confirmar Contraseña',
                prefixIcon: Icons.lock_outlined,
                suffixIcon: IconButton(
                    onPressed: () =>
                        signUpForm.eyeToggle = !signUpForm.eyeToggle,
                    icon: signUpForm.eyeToggle
                        ? const Icon(
                            Icons.remove_red_eye,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.solidEyeSlash,
                            size: 18,
                          ))),
            onChanged: (value) => signUpForm.confirmPassword = value,
            validator: (value) => FormValidators.validateConfirmPassword(
                value, signUpForm.password),
          ),
          const SizedBox(height: 30.0),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Theme.of(context).colorScheme.secondary,
              onPressed: signUpForm.isLoading
                  ? null
                  : () async {
                      final navigator = Navigator.of(context);
                      FocusScope.of(context).unfocus();

                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!signUpForm.isValidForm()) return;
                      signUpForm.isLoading = true;

                      final resp = await authService.signUp(
                          signUpForm.email, signUpForm.password);

                      if (resp.containsKey('errorMessage')) {
                        NotificationService.showSnackBar(
                            resp['errorMessage'], Colors.red);
                      } else {
                        navigator.pushReplacementNamed('sign-in');
                      }
                      signUpForm.isLoading = false;
                    },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  signUpForm.isLoading ? 'Espere...' : 'Registrarse',
                  style: const TextStyle(color: Colors.white),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ya tienes una cuenta?',
              ),
              TextButton(
                child: const Text('Inicia sesión'),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'sign-in'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
