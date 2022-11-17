import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../../domain/core/error/exception.dart';

import '../../constants.dart';
import '../../models/experiencia_agricola_model.dart';
import '../../utils.dart';

abstract class ExperienciaAgricolaRemoteDataSource {
  Future<List<ExperienciaAgricolaModel>> getExperienciasAgricolas(
      UsuarioEntity usuario);
}

class ExperienciaAgricolaRemoteDataSourceImpl
    implements ExperienciaAgricolaRemoteDataSource {
  final http.Client client;

  ExperienciaAgricolaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ExperienciaAgricolaModel>> getExperienciasAgricolas(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final experienciaAgricolaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaExperienciasAgricolas</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final experienciaAgricolaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: experienciaAgricolaSOAP);

    if (experienciaAgricolaResp.statusCode == 200) {
      final experienciaAgricolaDoc =
          xml.XmlDocument.parse(experienciaAgricolaResp.body);

      final respuesta = experienciaAgricolaDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          experienciaAgricolaDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = experienciaAgricolaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final experienciasAgricolasRaw =
            decodedResp.entries.first.value['Table'];

        if (experienciasAgricolasRaw is List) {
          return List.from(experienciasAgricolasRaw)
              .map((e) => ExperienciaAgricolaModel.fromJson(e))
              .toList();
        } else {
          return [ExperienciaAgricolaModel.fromJson(experienciasAgricolasRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
