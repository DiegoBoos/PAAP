import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/perfil_preinversion_model.dart';
import '../../../models/perfiles_preinversion_model.dart';
import '../../../utils.dart';

abstract class PerfilPreInversionRemoteDataSource {
  Future<List<PerfilPreInversionModel>> getPerfilesPreInversion(
      UsuarioEntity usuario);
}

class PerfilesPreInversionRemoteDataSourceImpl
    implements PerfilPreInversionRemoteDataSource {
  final http.Client client;

  PerfilesPreInversionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreInversionModel>> getPerfilesPreInversion(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilesPreInversionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
          </usuario>
          <rol>
            <RolId>400</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaPerfilesPreInversiones</string> 
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final perfilesPreInversionResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilesPreInversionSOAP);

    if (perfilesPreInversionResp.statusCode == 200) {
      final perfilesPreInversionDoc =
          xml.XmlDocument.parse(perfilesPreInversionResp.body);

      final respuesta = perfilesPreInversionDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = perfilesPreInversionDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        final xmlString = perfilesPreInversionDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilesPreInversionRaw =
            decodedResp.entries.first.value['Table'];

        final perfilesPreInversion = List.from(perfilesPreInversionRaw)
            .map((e) => PerfilesPreInversionModel.fromJson(e))
            .toList();

        List<PerfilPreInversionModel> listPerfilesPreInversion = [];
        for (var perfilPreInversion in perfilesPreInversion) {
          final dsPerfilPreInversion =
              await getPerfilPreInversionTable(usuario, perfilPreInversion.id);
          listPerfilesPreInversion.add(dsPerfilPreInversion);
        }
        return listPerfilesPreInversion;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  Future<PerfilPreInversionModel> getPerfilPreInversionTable(
      UsuarioEntity usuario, String perfilPreInversionId) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilesPreInversionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarPerfilPreInversion xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
            </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <PerfilPreInversionId>$perfilPreInversionId</PerfilPreInversionId>
          </objeto>
        </ConsultarPerfilPreInversion>
      </soap:Body>
    </soap:Envelope>''';

    final perfilRespPreInversion = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ConsultarPerfilPreInversion"
        },
        body: perfilesPreInversionSOAP);

    if (perfilRespPreInversion.statusCode == 200) {
      final perfilPreInversionDoc =
          xml.XmlDocument.parse(perfilRespPreInversion.body);

      final respuesta = perfilPreInversionDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = perfilPreInversionDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        final xmlString = perfilPreInversionDoc
            .findAllElements('objeto')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final decodedResp = json.decode(res);

        final perfilPreInversion =
            PerfilPreInversionModel.fromJson(decodedResp['objeto']);

        return perfilPreInversion;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
