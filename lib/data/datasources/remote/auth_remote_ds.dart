import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../models/usuario_model.dart';
import '../../utils.dart';

abstract class AuthRemoteDataSource {
  Future<UsuarioModel> verificacion(UsuarioEntity usuario);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UsuarioModel> verificacion(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final verificacionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <Verificacion xmlns="${Constants.urlSOAP}/">
          <objeto>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
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

      if (verificacionResp.statusCode != 200) {
        throw const ServerFailure(['Error de autenticación']);
      }

      final verificacionDoc = xml.XmlDocument.parse(verificacionResp.body);

      final respuesta =
          verificacionDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          verificacionDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        return await consultarUsuario(uri, usuario);
      } else {
        throw ServerFailure([mensaje]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<UsuarioModel> consultarUsuario(Uri uri, UsuarioEntity usuario) async {
    try {
      final consultarUsuarioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarUsuario xmlns="${Constants.urlSOAP}/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
          </usuario>
          <objeto>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
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

      if (consultarUsuarioResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener el usuario']);
      }

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
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
