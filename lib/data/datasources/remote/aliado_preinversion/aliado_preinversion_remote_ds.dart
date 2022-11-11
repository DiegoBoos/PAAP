import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/aliado_preinversion_model.dart';
import '../../../utils.dart';

abstract class AliadoPreinversionRemoteDataSource {
  Future<List<AliadoPreinversionModel>> getAliadosPreinversion(
      UsuarioEntity usuario);
}

class AliadoPreinversionRemoteDataSourceImpl
    implements AliadoPreinversionRemoteDataSource {
  final http.Client client;

  AliadoPreinversionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AliadoPreinversionModel>> getAliadosPreinversion(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final aliadosPreinversionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaPerfilesPreInversionesAliados</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final aliadoPreinversionResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: aliadosPreinversionSOAP);

    if (aliadoPreinversionResp.statusCode == 200) {
      final aliadoPreinversionDoc =
          xml.XmlDocument.parse(aliadoPreinversionResp.body);

      final respuesta = aliadoPreinversionDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = aliadoPreinversionDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        final xmlString = aliadoPreinversionDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final aliadosPreinversionRaw = decodedResp.entries.first.value['Table'];
        final aliadosPreinversion = List.from(aliadosPreinversionRaw)
            .map((e) => AliadoPreinversionModel.fromJson(e))
            .toList();

        return aliadosPreinversion;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
