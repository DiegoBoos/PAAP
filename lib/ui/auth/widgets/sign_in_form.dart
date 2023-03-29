import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/input_decoration.dart';
import '../../utils/validators/form_validators.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
    required this.usuarioIdCtrl,
    required this.contrasenaCtrl,
  });

  final TextEditingController usuarioIdCtrl;
  final TextEditingController contrasenaCtrl;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool eyeToggle = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        TextFormField(
          controller: widget.usuarioIdCtrl,
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
          controller: widget.contrasenaCtrl,
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
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              if (value.length < 6) {
                return '*La contraseña debe ser mínimo 6 caracteres.';
              }
              return null;
            }

            return '*Requerido.';
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
