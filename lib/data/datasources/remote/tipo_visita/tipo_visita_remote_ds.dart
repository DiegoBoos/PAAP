import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/tipo_visita_model.dart';
import '../../../utils.dart';

abstract class TipoVisitaRemoteDataSource {
  Future<List<TipoVisitaModel>> getTiposVisitas(UsuarioEntity usuario);
}

class TipoVisitaRemoteDataSourceImpl implements TipoVisitaRemoteDataSource {
  final http.Client client;

  TipoVisitaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoVisitaModel>> getTiposVisitas(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final tipoVisitaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposVisitas</string>       
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final tipoVisitaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: tipoVisitaSOAP);

    if (tipoVisitaResp.statusCode == 200) {
      final tipoVisitaDoc = xml.XmlDocument.parse(tipoVisitaResp.body);

      final respuesta =
          tipoVisitaDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          tipoVisitaDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = tipoVisitaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tiposVisitasRaw = decodedResp.entries.first.value['Table'];

        if (tiposVisitasRaw is List) {
          return List.from(tiposVisitasRaw)
              .map((e) => TipoVisitaModel.fromJson(e))
              .toList();
        } else {
          return [TipoVisitaModel.fromJson(tiposVisitasRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
