class AppConfig {
  final String appName;
  final String flavor;
  final String url;

  AppConfig({required this.appName, required this.flavor, required this.url});

  Map<String, dynamic> toMap() {
    return {
      'appName': appName,
      'flavor': flavor,
      'url': url,
    };
  }

  static final devAppConfig = AppConfig(
      appName: 'MA-TALLIN',
      flavor: 'QA',
      url:
          'http://161.97.105.205/PAAP/ServiciosDesarrollo/PAAPServicioWeb.asmx');

  static final prodAppConfig = AppConfig(
      appName: 'MA-BAKU',
      flavor: 'prod',
      // url:
      //     'http://10.10-11-31:8080/PAAP/ServiciosDesarrollo/PAAPServicioWeb.asmx');
      url:
          'http://161.97.105.205/PAAP/ServiciosDesarrollo/PAAPServicioWeb.asmx');
}
