import 'package:flutter/material.dart';
import 'package:paap/app.dart';
import 'package:paap/app_config.dart';

void main() async {
  final devAppConfig = AppConfig(
      appName: 'MA-TALLIN',
      flavor: 'QA',
      url:
          'http://161.97.105.205/PAAP/ServiciosDesarrollo/PAAPServicioWeb.asmx');
  Widget app = await initializeApp(devAppConfig);
  runApp(app);
}
