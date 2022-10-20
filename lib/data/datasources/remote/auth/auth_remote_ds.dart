import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';
import 'package:paap/domain/core/error/failure.dart';
import '../../../utils.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> verificacion(
      String usuarioId, String contrasena);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> verificacion(
      String usuarioId, String contrasena) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final verificacionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <Verificacion xmlns="${Constants.urlSOAP}/">
          <objeto>
            <UsuarioId>$usuarioId</UsuarioId>
            <Contrasena>$contrasena</Contrasena>
          </objeto>
        </Verificacion>
      </soap:Body>
    </soap:Envelope>''';

    final verificacionResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/Verificacion"
        },
        body: verificacionSOAP);

    if (verificacionResp.statusCode == 200) {
      final verificacionDoc = xml.XmlDocument.parse(verificacionResp.body);

      final respuesta =
          verificacionDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          verificacionDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        return await consultarUsuario(uri, usuarioId, contrasena);
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  Future<Map<String, dynamic>> consultarUsuario(
      Uri uri, String usuarioId, String contrasena) async {
    final consultarUsuarioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarUsuario xmlns="${Constants.urlSOAP}/">
        <usuario>
            <UsuarioId>$usuarioId</UsuarioId>
            <Contrasena>$contrasena</Contrasena>
        </usuario>
          <objeto>
            <UsuarioId>$usuarioId</UsuarioId>
            <Contrasena>$contrasena</Contrasena>
          </objeto>
        </ConsultarUsuario>
      </soap:Body>
    </soap:Envelope>''';

    final consultarUsuarioResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ConsultarUsuario"
        },
        body: consultarUsuarioSOAP);

    if (consultarUsuarioResp.statusCode == 200) {
      final consultarUsuarioDoc =
          xml.XmlDocument.parse(consultarUsuarioResp.body);

      final respuesta = consultarUsuarioDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = consultarUsuarioDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        final xmlString = consultarUsuarioDoc
            .findAllElements('objeto')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final decodedResp = json.decode(res);

        return decodedResp;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
