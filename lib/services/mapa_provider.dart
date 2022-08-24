import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class MapaProvider {
  final _uri = Uri.parse("http://192.168.0.106/wspr/ws.asmx/BuscarPuntos");

  final bookshelfXml = '''<?xml version="1.0"?>
    <bookshelf>
      <book>
        <title lang="en">Growing a Language</title>
        <price>29.99</price>
      </book>
      <book>
        <title lang="en">Learning XML</title>
        <price>39.95</price>
      </book>
      <price>132.00</price>
    </bookshelf>''';

  Future<List> getCoordenadas() async {
    final resp = await http.post(_uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://tempuri.rog/BuscarPuntos" //URL WEB SERVICE
        },
        body: bookshelfXml);

    if (resp.statusCode == 200) {
      final responseBody = resp.body;

      final parseXml = XmlDocument.parse(responseBody).innerText;

      final decodeJson = jsonDecode(parseXml) as List;

      //Map model
      //List data = decodeJson.map((e) => fromJson(e)).toList();

      return [];
    } else {
      print('Error');
      return [];
    }
  }
}
