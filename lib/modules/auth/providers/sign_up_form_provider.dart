import 'package:flutter/material.dart';

class SignUpFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _eyeToggle = true;
  bool get eyeToggle => _eyeToggle;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set eyeToggle(bool value) {
    _eyeToggle = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
