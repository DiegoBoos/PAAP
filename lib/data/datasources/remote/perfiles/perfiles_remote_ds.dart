import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';
import 'package:paap/domain/core/error/failure.dart';
import '../../../models/perfiles_model.dart';
import '../../../utils.dart';

abstract class PerfilesRemoteDataSource {
  Future<List<PerfilesModel>> getPerfiles(String usuarioId, String contrasena);
  Future<List<PerfilesModel>> getPerfilesFiltros(
      String usuarioId, String contrasena, String id, String nombre);
}

class PerfilesRemoteDataSourceImpl implements PerfilesRemoteDataSource {
  final http.Client client;

  PerfilesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilesModel>> getPerfiles(
      String usuarioId, String contrasena) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilSOAP = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
      <usuario>
         <UsuarioId>$usuarioId</UsuarioId>
        <Contrasena>$contrasena</Contrasena>
      </usuario>
      <rol>
        <RolId>400</RolId>
        <Nombre>string</Nombre>
      </rol>
      <parametros>
        <string>TablaPerfiles</string> 
      </parametros>
    </ObtenerDatos>
  </soap:Body>
</soap:Envelope>''';

    final perfilResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilSOAP);

    if (perfilResp.statusCode == 200) {
      final perfilDoc = xml.XmlDocument.parse(perfilResp.body);

      final respuesta =
          perfilDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          perfilDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = perfilDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilesRaw = decodedResp.entries.first.value['Table'];

        final perfiles = List.from(perfilesRaw)
            .map((e) => PerfilesModel.fromJson(e))
            .toList();

        return perfiles;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PerfilesModel>> getPerfilesFiltros(
      String usuarioId, String contrasena, String? id, String? nombre) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilSOAP = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
      <usuario>
         <UsuarioId>$usuarioId</UsuarioId>
        <Contrasena>$contrasena</Contrasena>
      </usuario>
      <rol>
        <RolId>400</RolId>
        <Nombre>string</Nombre>
      </rol>
      <parametros>
        <string>TablaPerfilFiltros</string>        
        <string>$id</string>        
        <string>$nombre</string>        
      </parametros>
    </ObtenerDatos>
  </soap:Body>
</soap:Envelope>''';

    final perfilResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilSOAP);

    if (perfilResp.statusCode == 200) {
      final perfilDoc = xml.XmlDocument.parse(perfilResp.body);

      final respuesta =
          perfilDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          perfilDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (perfilDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }
        final xmlString = perfilDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilesRaw = decodedResp.entries.first.value['Table'];

        final perfiles = List.from(perfilesRaw)
            .map((e) => PerfilesModel.fromJson(e))
            .toList();

        return perfiles;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
