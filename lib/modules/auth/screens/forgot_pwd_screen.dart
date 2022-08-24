import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:paap/modules/auth/auth_exports.dart';
import 'package:paap/utils/custom_input.dart';
import 'package:paap/utils/notifications.service.dart';

class ForgotPwdScreen extends StatelessWidget {
  const ForgotPwdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forgotPwdForm = Provider.of<ForgotPwdFormProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Restaurar Contraseña'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 200),
              Form(
                key: forgotPwdForm.formKey,
                child: CardContainer(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Restaurar contraseña',
                        style: Theme.of(context).textTheme.headline6),
                    const SizedBox(height: 20),
                    const Text(
                        'Ingresa tu email y sigue las instrucciones para restaurar tu contraseña'),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: CustomInput.inputDecoration(
                          hintText: 'Correo electrónico',
                          labelText: 'Correo electrónico',
                          prefixIcon: Icons.alternate_email_sharp),
                      onChanged: (value) => forgotPwdForm.email = value,
                      validator: (value) => FormValidators.validateEmail(value),
                    ),
                    const SizedBox(height: 30.0),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: forgotPwdForm.isLoading
                            ? null
                            : () async {
                                final navigator = Navigator.of(context);
                                FocusScope.of(context).unfocus();

                                final authService = Provider.of<AuthService>(
                                    context,
                                    listen: false);

                                if (!forgotPwdForm.isValidForm()) return;
                                forgotPwdForm.isLoading = true;

                                final resp = await authService
                                    .forgotPwd(forgotPwdForm.email);

                                if (resp.containsKey('errorMsg')) {
                                  NotificationService.showSnackBar(
                                      resp['errorMsg']);
                                } else {
                                  NotificationService.showSnackBar(
                                      'El link de activación se ha enviado correctamente, revisa tu correo electrónico para restaurar tu contraseña');
                                  navigator.pushReplacementNamed('sign-in');
                                }
                                forgotPwdForm.isLoading = false;
                              },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(
                            forgotPwdForm.isLoading ? 'Espere...' : 'Enviar',
                            style: const TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                )),
              ),
            ],
          ),
        ));
  }
}
