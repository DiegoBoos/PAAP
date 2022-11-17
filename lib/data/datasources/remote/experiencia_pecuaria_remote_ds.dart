import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../../domain/core/error/exception.dart';

import '../../constants.dart';
import '../../models/experiencia_pecuaria_model.dart';
import '../../utils.dart';

abstract class ExperienciaPecuariaRemoteDataSource {
  Future<List<ExperienciaPecuariaModel>> getExperienciasPecuarias(
      UsuarioEntity usuario);
}

class ExperienciaPecuariaRemoteDataSourceImpl
    implements ExperienciaPecuariaRemoteDataSource {
  final http.Client client;

  ExperienciaPecuariaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ExperienciaPecuariaModel>> getExperienciasPecuarias(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final experienciaPecuariaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaExperienciasPecuarias</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final experienciaPecuariaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: experienciaPecuariaSOAP);

    if (experienciaPecuariaResp.statusCode == 200) {
      final experienciaPecuariaDoc =
          xml.XmlDocument.parse(experienciaPecuariaResp.body);

      final respuesta = experienciaPecuariaDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          experienciaPecuariaDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = experienciaPecuariaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final experienciasPecuariasRaw =
            decodedResp.entries.first.value['Table'];

        if (experienciasPecuariasRaw is List) {
          return List.from(experienciasPecuariasRaw)
              .map((e) => ExperienciaPecuariaModel.fromJson(e))
              .toList();
        } else {
          return [ExperienciaPecuariaModel.fromJson(experienciasPecuariasRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
