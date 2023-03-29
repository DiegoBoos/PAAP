import 'package:flutter/material.dart';
import 'package:paap/app.dart';
import 'package:paap/app_config.dart';

void main() async {
  final devAppConfig = AppConfig(
      appName: 'MA-TALLIN',
      flavor: 'QA',
      url: 'http://172.20.50.193/PAAPServicioWeb.asmx');
  Widget app = await initializeApp(devAppConfig);
  runApp(app);
}
