import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/cofinanciador_model.dart';
import '../../../utils.dart';

abstract class CofinanciadorRemoteDataSource {
  Future<List<CofinanciadorModel>> getCofinanciadores(UsuarioEntity usuario);
}

class CofinanciadorRemoteDataSourceImpl
    implements CofinanciadorRemoteDataSource {
  final http.Client client;

  CofinanciadorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CofinanciadorModel>> getCofinanciadores(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final cofinanciadorSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaCofinanciadores</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final cofinanciadorResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: cofinanciadorSOAP);

    if (cofinanciadorResp.statusCode == 200) {
      final cofinanciadorDoc = xml.XmlDocument.parse(cofinanciadorResp.body);

      final respuesta = cofinanciadorDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje =
          cofinanciadorDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = cofinanciadorDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final cofinanciadoresRaw = decodedResp.entries.first.value['Table'];
        final cofinanciadores = List.from(cofinanciadoresRaw)
            .map((e) => CofinanciadorModel.fromJson(e))
            .toList();

        return cofinanciadores;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
