import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/aliado_model.dart';
import '../../../utils.dart';

abstract class AliadoRemoteDataSource {
  Future<List<AliadoModel>> getAliados(UsuarioEntity usuario);
}

class AliadoRemoteDataSourceImpl implements AliadoRemoteDataSource {
  final http.Client client;

  AliadoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AliadoModel>> getAliados(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final aliadoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaAliados</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final aliadoResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: aliadoSOAP);

    if (aliadoResp.statusCode == 200) {
      final aliadoDoc = xml.XmlDocument.parse(aliadoResp.body);

      final respuesta =
          aliadoDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          aliadoDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = aliadoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final aliadosRaw = decodedResp.entries.first.value['Table'];

        if (aliadosRaw is List) {
          return List.from(aliadosRaw)
              .map((e) => AliadoModel.fromJson(e))
              .toList();
        } else {
          return [AliadoModel.fromJson(aliadosRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
