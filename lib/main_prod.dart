import 'package:flutter/material.dart';
import 'package:paap/app.dart';
import 'package:paap/app_config.dart';

void main() async {
  final prodAppConfig = AppConfig(
      appName: 'MA-BAKU',
      flavor: 'prod',
      url: 'http://10.10-11-31:8080/PAAPServicioWeb.asmx');
  Widget app = await initializeApp(prodAppConfig);
  runApp(app);
}
