import 'package:xml2json/xml2json.dart';

class Utils {
  static String convertXmlToJson(String xmlString) {
    final converter = Xml2Json();
    converter.parse(xmlString);
    var res = converter.toParker();
    return res;
  }
}
