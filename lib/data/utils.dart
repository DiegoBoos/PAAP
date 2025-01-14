import 'package:xml2json/xml2json.dart';

import '../app_config.dart';
import 'db/db_config.dart';

class Utils {
  static String convertXmlToJson(String xmlString) {
    final converter = Xml2Json();
    converter.parse(xmlString);
    var res = converter.toParker();
    return res;
  }

  static setAppConfig(AppConfig appConfig) async {
    final db = await DBConfig.database;

    await db.insert('AppConfig', appConfig.toMap());
  }
}
