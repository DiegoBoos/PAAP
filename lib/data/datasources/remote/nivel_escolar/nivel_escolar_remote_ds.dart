import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/nivel_escolar_model.dart';
import '../../../utils.dart';

abstract class NivelEscolarRemoteDataSource {
  Future<List<NivelEscolarModel>> getNivelesEscolares(UsuarioEntity usuario);
}

class NivelEscolarRemoteDataSourceImpl implements NivelEscolarRemoteDataSource {
  final http.Client client;

  NivelEscolarRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NivelEscolarModel>> getNivelesEscolares(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final nivelesEscolarSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaNivelesEscolares</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final nivelesEscolarResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: nivelesEscolarSOAP);

    if (nivelesEscolarResp.statusCode == 200) {
      final nivelesEscolarDoc = xml.XmlDocument.parse(nivelesEscolarResp.body);

      final respuesta = nivelesEscolarDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje =
          nivelesEscolarDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true' &&
          nivelesEscolarDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = nivelesEscolarDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final nivelesEscolaresRaw = decodedResp.entries.first.value['Table'];

        if (nivelesEscolaresRaw is List) {
          return List.from(nivelesEscolaresRaw)
              .map((e) => NivelEscolarModel.fromJson(e))
              .toList();
        } else {
          return [NivelEscolarModel.fromJson(nivelesEscolaresRaw)];
        }
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
