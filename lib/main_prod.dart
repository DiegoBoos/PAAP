import 'package:flutter/material.dart';
import 'package:paap/app.dart';
import 'package:paap/app_config.dart';

void main() async {
  final prodAppConfig = AppConfig.prodAppConfig;
  Widget app = await initializeApp(prodAppConfig);
  runApp(app);
}
