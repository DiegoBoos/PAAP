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

abstract class PerfilPreinversionRemoteDataSource {
  Future<List<PerfilPreinversionModel>> getPerfilesPreinversion(
      UsuarioEntity usuario);
}

class PerfilesPreinversionRemoteDataSourceImpl
    implements PerfilPreinversionRemoteDataSource {
  final http.Client client;

  PerfilesPreinversionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreinversionModel>> getPerfilesPreinversion(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilesPreinversionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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

    final perfilesPreinversionResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilesPreinversionSOAP);

    if (perfilesPreinversionResp.statusCode == 200) {
      final perfilesPreinversionDoc =
          xml.XmlDocument.parse(perfilesPreinversionResp.body);

      final respuesta = perfilesPreinversionDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = perfilesPreinversionDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        final xmlString = perfilesPreinversionDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilesPreinversionRaw =
            decodedResp.entries.first.value['Table'];

        final perfilesPreinversion = List.from(perfilesPreinversionRaw)
            .map((e) => PerfilesPreinversionModel.fromJson(e))
            .toList();

        List<PerfilPreinversionModel> listPerfilesPreinversion = [];
        for (var perfilPreinversion in perfilesPreinversion) {
          final dsPerfilPreinversion =
              await getPerfilPreinversionTable(usuario, perfilPreinversion.id);
          listPerfilesPreinversion.add(dsPerfilPreinversion);
        }
        return listPerfilesPreinversion;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  Future<PerfilPreinversionModel> getPerfilPreinversionTable(
      UsuarioEntity usuario, String perfilPreinversionId) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilesPreinversionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <PerfilPreInversionId>$perfilPreinversionId</PerfilPreInversionId>
          </objeto>
        </ConsultarPerfilPreInversion>
      </soap:Body>
    </soap:Envelope>''';

    final perfilRespPreinversion = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ConsultarPerfilPreInversion"
        },
        body: perfilesPreinversionSOAP);

    if (perfilRespPreinversion.statusCode == 200) {
      final perfilPreinversionDoc =
          xml.XmlDocument.parse(perfilRespPreinversion.body);

      final respuesta = perfilPreinversionDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = perfilPreinversionDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        final xmlString = perfilPreinversionDoc
            .findAllElements('objeto')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final decodedResp = json.decode(res);

        final perfilPreinversion =
            PerfilPreinversionModel.fromJson(decodedResp['objeto']);

        return perfilPreinversion;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
