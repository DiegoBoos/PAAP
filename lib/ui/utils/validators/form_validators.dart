abstract class FormValidators {
  static validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(value ?? '') ? null : 'Correo no válido';
  }

  static validatePassword(String? value) {
    return (value != null && value.length >= 6)
        ? null
        : 'La contraseña debe tener más de 6 caracteres';
  }

  static validateConfirmPassword(String? value, String? password) {
    if (value!.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener 6 caracteres o más';
    }
    if (password != value) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }
}
