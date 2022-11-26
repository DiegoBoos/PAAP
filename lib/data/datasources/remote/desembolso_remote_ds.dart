import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/desembolso_model.dart';
import '../../utils.dart';

abstract class DesembolsoRemoteDataSource {
  Future<List<DesembolsoModel>> getDesembolsos(UsuarioEntity usuario);
}

class DesembolsoRemoteDataSourceImpl implements DesembolsoRemoteDataSource {
  final http.Client client;

  DesembolsoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DesembolsoModel>> getDesembolsos(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final desembolsoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaDesembolsos</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final desembolsoResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: desembolsoSOAP);

    if (desembolsoResp.statusCode == 200) {
      final desembolsoDoc = xml.XmlDocument.parse(desembolsoResp.body);

      final respuesta =
          desembolsoDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          desembolsoDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = desembolsoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final desembolsosRaw = decodedResp.entries.first.value['Table'];

        if (desembolsosRaw is List) {
          return List.from(desembolsosRaw)
              .map((e) => DesembolsoModel.fromJson(e))
              .toList();
        } else {
          return [DesembolsoModel.fromJson(desembolsosRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
