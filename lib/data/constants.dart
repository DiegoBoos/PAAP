import '../domain/db/db_config.dart';

class Constants {
  static const paapServicioWebSoapBaseUrl = 'http://161.97.105.205';
  static const urlSOAP = "http://alianzasproductivas.minagricultura.gov.co";

  static Future<String> getAppUrl() async {
    final db = await DBConfig.database;

    final List<Map<String, dynamic>> mapList = await db.query('AppConfig');
    String url = mapList[0]['url'];
    print(url);
    return url;
  }
}
