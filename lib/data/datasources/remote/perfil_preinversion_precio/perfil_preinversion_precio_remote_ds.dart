import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/perfil_preinversion_precio_model.dart';
import '../../../utils.dart';

abstract class PerfilPreInversionPrecioRemoteDataSource {
  Future<List<PerfilPreInversionPrecioModel>> getPerfilPreInversionPrecios(
      UsuarioEntity usuario);
}

class PerfilPreInversionPrecioRemoteDataSourceImpl
    implements PerfilPreInversionPrecioRemoteDataSource {
  final http.Client client;

  PerfilPreInversionPrecioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreInversionPrecioModel>> getPerfilPreInversionPrecios(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilPreInversionPreciosSOAP =
        '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
          </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaPerfilesPreInversionesPrecios</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final perfilPreInversionPrecioResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilPreInversionPreciosSOAP);

    if (perfilPreInversionPrecioResp.statusCode == 200) {
      final perfilPreInversionPrecioDoc =
          xml.XmlDocument.parse(perfilPreInversionPrecioResp.body);

      final respuesta = perfilPreInversionPrecioDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          perfilPreInversionPrecioDoc
              .findAllElements('NewDataSet')
              .isNotEmpty) {
        final xmlString = perfilPreInversionPrecioDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilPreInversionPreciosRaw =
            decodedResp.entries.first.value['Table'];

        if (perfilPreInversionPreciosRaw is List) {
          return List.from(perfilPreInversionPreciosRaw)
              .map((e) => PerfilPreInversionPrecioModel.fromJson(e))
              .toList();
        } else {
          return [
            PerfilPreInversionPrecioModel.fromJson(perfilPreInversionPreciosRaw)
          ];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
