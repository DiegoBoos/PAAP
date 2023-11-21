import 'package:flutter/material.dart';
import 'package:paap/app.dart';
import 'package:paap/app_config.dart';

void main() async {
  final prodAppConfig = AppConfig(
      appName: 'MA-BAKU',
      flavor: 'prod',
      // url:
      //     'http://10.10-11-31:8080/PAAP/ServiciosDesarrollo/PAAPServicioWeb.asmx');
      url:
          'http://161.97.105.205/PAAP/ServiciosDesarrollo/PAAPServicioWeb.asmx');
  Widget app = await initializeApp(prodAppConfig);
  runApp(app);
}
