import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/blocs/download_sync/download_sync_bloc.dart';
import '../../../domain/cubits/internet/internet_cubit.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../utils/all_platform.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../widgets/auth_background.dart';
import '../widgets/custom_linear_progress.dart';
import '../widgets/sign_in_form.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final configFormKey = GlobalKey<FormState>();
  final localCaptchaController = LocalCaptchaController();
  final configFormData = ConfigFormData();

  var inputCode = '';

  @override
  void dispose() {
    localCaptchaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final internetCubit = BlocProvider.of<InternetCubit>(context);

    TextEditingController usuarioIdCtrl =
        TextEditingController(text: 'adamariatorrenegra@hotmail.com');
    TextEditingController contrasenaCtrl =
        TextEditingController(text: 'UHJvZGVzYXJyb2xsbzIxKg==');

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoaded) {
          if (internetCubit.state is InternetConnected) {
            final usuario = state.usuarioAutenticado!;
            authBloc.add(SaveUsuario(usuario: usuario));

            BlocProvider.of<DownloadSyncBloc>(context)
                .add(DownloadStarted(usuario));
          } else if (internetCubit.state is InternetDisconnected) {
            //TODO: Do login offline
          }
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message), backgroundColor: Colors.red));
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const LoadingPage(
            title: 'Progress...',
          );
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: AuthBackground(
              child: Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Text('Ingresar',
                              style: Theme.of(context).textTheme.headline4),
                          const Expanded(child: NetworkIcon())
                        ],
                      ),
                      const SizedBox(height: 10),
                      SignInForm(
                          formKey: formKey,
                          internetCubit: internetCubit,
                          authBloc: authBloc,
                          usuarioIdCtrl: usuarioIdCtrl,
                          contrasenaCtrl: contrasenaCtrl),
                      const SizedBox(height: 10),
                      LocalCaptcha(
                        key: ValueKey(configFormData.toString()),
                        controller: localCaptchaController,
                        height: 100,
                        width: 500,
                        backgroundColor: Colors.grey[100]!,
                        chars: configFormData.chars,
                        length: configFormData.length,
                        fontSize: configFormData.fontSize > 0
                            ? configFormData.fontSize
                            : null,
                        caseSensitive: configFormData.caseSensitive,
                        codeExpireAfter: configFormData.codeExpireAfter,
                      ),
                      const SizedBox(height: 10),
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
                              return '* El código debe ser máximo de ${configFormData.length} caracteres.';
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
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: MaterialButton(
                                disabledColor: Colors.grey,
                                elevation: 0,
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: () {
                                  if (!formKey.currentState!.validate()) return;

                                  final usuario = UsuarioEntity(
                                    usuarioId: usuarioIdCtrl.text,
                                    contrasena: contrasenaCtrl.text,
                                  );

                                  if (internetCubit.state
                                      is InternetConnected) {
                                    authBloc.add(LogIn(usuario: usuario));
                                  } else if (internetCubit.state
                                      is InternetDisconnected) {
                                    authBloc.add(LogIn(
                                        usuario: usuario, isOffline: true));
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
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => localCaptchaController.refresh(),
                              icon: const Icon(Icons.sync),
                              label: const Text('RECAPTCHA'),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.blue[900])),
                            ),
                          ),
                        ],
                      ),
                      BlocConsumer<DownloadSyncBloc, DownloadSyncState>(
                          listener: (context, state) {
                        if (state is DownloadSyncSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Descarga finalizada con éxito'),
                                  backgroundColor: Colors.green));

                          Navigator.of(context).pushReplacementNamed('tabs');
                        } else if (state is DownloadSyncFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red));
                        }
                      }, builder: (context, state) {
                        if (state is DownloadSyncInProgress) {
                          return CustomLinearProgress(
                              progress: state.progress, title: state.title);
                        }

                        return const SizedBox();
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ConfigFormData {
  String chars = 'abdefghnryABDEFGHNQRY3468';
  int length = 5;
  double fontSize = 0;
  bool caseSensitive = true;
  Duration codeExpireAfter = const Duration(minutes: 3);

  @override
  String toString() {
    return '$chars$length$caseSensitive${codeExpireAfter.inMinutes}';
  }
}
