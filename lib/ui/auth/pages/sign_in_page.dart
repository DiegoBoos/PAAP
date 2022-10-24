import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paap/ui/utils/input_decoration.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/blocs/menu/menu_bloc.dart';
import '../../../domain/cubits/internet/internet_cubit.dart';
import '../../utils/all_platform.dart';
import '../../utils/network_icon.dart';
import '../../utils/validators/form_validators.dart';
import '../widgets/auth_background.dart';
import '../widgets/card_container.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localCaptchaController = LocalCaptchaController();
    var inputCode = '';
    final configFormData = ConfigFormData();

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
                  LocalCaptcha(
                    key: ValueKey(configFormData.toString()),
                    controller: localCaptchaController,
                    height: 150,
                    width: 300,
                    backgroundColor: Colors.grey[100]!,
                    chars: configFormData.chars,
                    length: configFormData.length,
                    fontSize: configFormData.fontSize > 0
                        ? configFormData.fontSize
                        : null,
                    caseSensitive: configFormData.caseSensitive,
                    codeExpireAfter: configFormData.codeExpireAfter,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Escriba el texto',
                      hintText: 'Escriba el texto',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (value.length != configFormData.length) {
                          return '* Code must be length of ${configFormData.length}.';
                        }

                        final validation =
                            localCaptchaController.validate(value);

                        switch (validation) {
                          case LocalCaptchaValidation.invalidCode:
                            return '* Código incorrecto.';
                          case LocalCaptchaValidation.codeExpired:
                            return '* Código expirado.';
                          case LocalCaptchaValidation.valid:
                          default:
                            return null;
                        }
                      }

                      return '* Requerido.';
                    },
                    onSaved: (value) => inputCode = value ?? '',
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 40.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => localCaptchaController.refresh(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                      ),
                      child: const Text('RECAPTCHA'),
                    ),
                  ),
                  const SignInForm(),
                  const NetworkIcon(),
                ],
              )),
              const SizedBox(height: 20.0),
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
  TextEditingController usuarioIdCtrl =
      TextEditingController(text: 'adamariatorrenegra@hotmail.com');
  TextEditingController contrasenaCtrl =
      TextEditingController(text: 'UHJvZGVzYXJyb2xsbzIxKg==');
  bool eyeToggle = false;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: true);
    final internetCubit = BlocProvider.of<InternetCubit>(context);
    final menuBloc = BlocProvider.of<MenuBloc>(context);
    final formKey = GlobalKey<FormState>();
    final captchaFormKey = GlobalKey<FormState>();

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
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoaded) {
                if (internetCubit.state is InternetConnected) {
                  menuBloc.add(GetMenus(
                      usuarioId: state.usuarioAutenticado!.usuarioId,
                      contrasena: state.usuarioAutenticado!.contrasena));
                } else if (internetCubit.state is InternetDisconnected) {
                  menuBloc.add(GetMenus(
                      usuarioId: state.usuarioAutenticado!.usuarioId,
                      contrasena: state.usuarioAutenticado!.contrasena,
                      isOffline: true));
                }
              }
            },
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Theme.of(context).colorScheme.secondary,
                onPressed: authBloc.state is AuthLoading
                    ? null
                    : () {
                        if (captchaFormKey.currentState?.validate() ?? false) {
                          captchaFormKey.currentState!.save();
                        }
                        if (!formKey.currentState!.validate()) return;

                        if (internetCubit.state is InternetConnected) {
                          authBloc.add(LogIn(
                              usuarioId: usuarioIdCtrl.text,
                              contrasena: contrasenaCtrl.text));
                        } else if (internetCubit.state
                            is InternetDisconnected) {
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
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ConfigFormData {
  String chars = 'abdefghnryABDEFGHNQRY3468';
  int length = 5;
  double fontSize = 0;
  bool caseSensitive = false;
  Duration codeExpireAfter = const Duration(minutes: 10);

  @override
  String toString() {
    return '$chars$length$caseSensitive${codeExpireAfter.inMinutes}';
  }
}
