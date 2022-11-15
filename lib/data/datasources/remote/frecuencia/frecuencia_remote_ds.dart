import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/frecuencia_model.dart';
import '../../../utils.dart';

abstract class FrecuenciaRemoteDataSource {
  Future<List<FrecuenciaModel>> getFrecuencias(UsuarioEntity usuario);
}

class FrecuenciaRemoteDataSourceImpl implements FrecuenciaRemoteDataSource {
  final http.Client client;

  FrecuenciaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<FrecuenciaModel>> getFrecuencias(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final frecuenciaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaFrecuencias</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final frecuenciaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: frecuenciaSOAP);

    if (frecuenciaResp.statusCode == 200) {
      final frecuenciaDoc = xml.XmlDocument.parse(frecuenciaResp.body);

      final respuesta =
          frecuenciaDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          frecuenciaDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = frecuenciaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final frecuenciasRaw = decodedResp.entries.first.value['Table'];

        if (frecuenciasRaw is List) {
          return List.from(frecuenciasRaw)
              .map((e) => FrecuenciaModel.fromJson(e))
              .toList();
        } else {
          return [FrecuenciaModel.fromJson(frecuenciasRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
