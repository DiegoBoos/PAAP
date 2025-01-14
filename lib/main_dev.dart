import 'package:flutter/material.dart';
import 'package:paap/app.dart';
import 'package:paap/app_config.dart';

void main() async {
  final devAppConfig = AppConfig.devAppConfig;
  Widget app = await initializeApp(devAppConfig);
  runApp(app);
}
