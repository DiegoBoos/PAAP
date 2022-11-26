import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/objetivo_model.dart';
import '../../utils.dart';

abstract class ObjetivoRemoteDataSource {
  Future<List<ObjetivoModel>> getObjetivos(UsuarioEntity usuario);
}

class ObjetivoRemoteDataSourceImpl implements ObjetivoRemoteDataSource {
  final http.Client client;

  ObjetivoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ObjetivoModel>> getObjetivos(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final objetivoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaObjetivos</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final objetivoResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: objetivoSOAP);

    if (objetivoResp.statusCode == 200) {
      final objetivoDoc = xml.XmlDocument.parse(objetivoResp.body);

      final respuesta =
          objetivoDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          objetivoDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = objetivoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final objetivosRaw = decodedResp.entries.first.value['Table'];

        if (objetivosRaw is List) {
          return List.from(objetivosRaw)
              .map((e) => ObjetivoModel.fromJson(e))
              .toList();
        } else {
          return [ObjetivoModel.fromJson(objetivosRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
