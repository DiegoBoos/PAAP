import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../../domain/blocs/sync/sync_bloc.dart';
import '../../../domain/cubits/internet/internet_cubit.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../utils/all_platform.dart';

import '../../utils/custom_general_dialog.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/sync_pages.dart';
import '../../utils/network_icon.dart';
import '../widgets/auth_background.dart';

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
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: true);
    final internetCubit = BlocProvider.of<InternetCubit>(context);
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    final syncBloc = BlocProvider.of<SyncBloc>(context);

    TextEditingController usuarioIdCtrl =
        TextEditingController(text: 'hugo.suarez@minagricultura.gov.co');
    TextEditingController contrasenaCtrl =
        TextEditingController(text: 'MigracionPAAP*');

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthLoaded) {
            if (internetCubit.state is InternetConnected) {
              final usuario = state.usuarioAutenticado!;
              authBloc.add(SaveUsuario(usuario: usuario));

              showDialog(
                  context: context,
                  builder: (_) => CustomGeneralDialog(
                      title: '¿Desea Sincronizar?',
                      subtitle: '',
                      confirmText: 'Sincronizar',
                      cancelText: 'Continuar Offline',
                      onTapConfirm: () {
                        Navigator.pop(context);
                        syncBloc.add(SyncStarted(usuario, 'A'));
                      },
                      onTapCancel: () {
                        menuCubit.verificacionDatosLocalesDB().then((value) {
                          if (value != '') {
                            Navigator.pop(context);
                            CustomSnackBar.showSnackBar(
                                context, value, Colors.red);
                          } else {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, 'tabs');
                          }
                        });
                      }));
            } else if (internetCubit.state is InternetDisconnected) {
              Navigator.pushReplacementNamed(context, 'tabs');
            }
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message), backgroundColor: Colors.red));
          }
        }),
        BlocListener<SyncBloc, SyncState>(listener: (context, state) {
          if (state is SyncFailure) {
            CustomSnackBar.showSnackBar(context, state.message, Colors.red);
            Navigator.pushReplacementNamed(context, 'sign-in');
            return;
          }
          if (state is SyncSuccess) {
            CustomSnackBar.showSnackBar(
                context, 'Descarga exitosa', Colors.green);

            Navigator.pushReplacementNamed(context, 'tabs');
          }
        }),
      ],
      child: BlocBuilder<SyncBloc, SyncState>(
        builder: (context, state) {
          if (state is SyncInProgress) {
            return LoadingPage(
                title: 'Sincronizando...',
                percent: state.progress.percent,
                text:
                    '${state.progress.title} ${state.progress.counter}/${state.progress.total}');
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: AuthBackground(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
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
                                  onPressed: authBloc.state is AuthLoading
                                      ? null
                                      : () {
                                          if (!formKey.currentState!
                                              .validate()) {
                                            return;
                                          }

                                          Codec<String, String> stringToBase64 =
                                              utf8.fuse(base64);
                                          String contrasenaEncoded =
                                              stringToBase64
                                                  .encode(contrasenaCtrl.text);

                                          final usuario = UsuarioEntity(
                                            usuarioId: usuarioIdCtrl.text,
                                            contrasena: contrasenaEncoded,
                                            activo: '',
                                            apellido: '',
                                            correo: '',
                                            direccion: '',
                                            fechaActivacion: '',
                                            fechaCambio: '',
                                            fechaDesactivacion: '',
                                            nombre: '',
                                            telefonoFijo: '',
                                            telefonoMovil: '',
                                          );

                                          if (internetCubit.state
                                              is InternetConnected) {
                                            authBloc
                                                .add(LogIn(usuario: usuario));
                                          } else if (internetCubit.state
                                              is InternetDisconnected) {
                                            authBloc.add(LogIn(
                                                usuario: usuario,
                                                isOffline: true));
                                          }
                                        },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    child: authBloc.state is AuthLoading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Text(
                                            'Ingresar',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  )),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    localCaptchaController.refresh(),
                                icon: const Icon(Icons.sync),
                                label: const Text('RECAPTCHA'),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.blue[900])),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
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
