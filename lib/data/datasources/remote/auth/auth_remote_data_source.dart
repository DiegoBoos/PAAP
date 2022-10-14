import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paap/data/models/menu_model.dart';
import 'package:paap/data/models/usuario_model.dart';
import 'package:paap/domain/core/error/failure.dart';
import 'package:xml/xml.dart' as xml;

import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';
import '../../../utils.dart';

abstract class AuthRemoteDataSource {
  Future<UsuarioModel> verificacion(String usuarioId, String contrasena);
  Future<List<MenuModel>> getMenu(String usuarioId, String contrasena);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UsuarioModel> verificacion(String usuarioId, String contrasena) async {
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

  Future<UsuarioModel> consultarUsuario(
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

        final usuario = UsuarioModel.fromJson(decodedResp['objeto']);

        return usuario;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MenuModel>> getMenu(String usuarioId, String contrasena) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final menuSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>$usuarioId</UsuarioId>
            <Contrasena>$contrasena</Contrasena>
          </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaMenus</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final menuResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: menuSOAP);

    if (menuResp.statusCode == 200) {
      final menuDoc = xml.XmlDocument.parse(menuResp.body);

      final respuesta =
          menuDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          menuDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = menuDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final menuList = decodedResp.entries.first.value['Table'];

        return List.from(menuList).map((e) => MenuModel.fromJson(e)).toList();
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
