import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/tipo_identificacion_model.dart';
import '../../../utils.dart';

abstract class TipoIdentificacionRemoteDataSource {
  Future<List<TipoIdentificacionModel>> getTiposIdentificaciones(
      UsuarioEntity usuario);
}

class TipoIdentificacionRemoteDataSourceImpl
    implements TipoIdentificacionRemoteDataSource {
  final http.Client client;

  TipoIdentificacionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoIdentificacionModel>> getTiposIdentificaciones(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final tipoIdentificacionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposIdentificaciones</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final tipoIdentificacionResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: tipoIdentificacionSOAP);

    if (tipoIdentificacionResp.statusCode == 200) {
      final tipoIdentificacionDoc =
          xml.XmlDocument.parse(tipoIdentificacionResp.body);

      final respuesta = tipoIdentificacionDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          tipoIdentificacionDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = tipoIdentificacionDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tiposIdentificacionesRaw =
            decodedResp.entries.first.value['Table'];

        if (tiposIdentificacionesRaw is List) {
          return List.from(tiposIdentificacionesRaw)
              .map((e) => TipoIdentificacionModel.fromJson(e))
              .toList();
        } else {
          return [TipoIdentificacionModel.fromJson(tiposIdentificacionesRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
