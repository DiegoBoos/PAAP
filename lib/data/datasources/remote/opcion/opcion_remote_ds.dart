import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/opcion_model.dart';
import '../../../utils.dart';

abstract class OpcionRemoteDataSource {
  Future<List<OpcionModel>> getOpciones(UsuarioEntity usuario);
}

class OpcionRemoteDataSourceImpl implements OpcionRemoteDataSource {
  final http.Client client;

  OpcionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<OpcionModel>> getOpciones(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final opcioneSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaOpciones</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final opcionResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: opcioneSOAP);

    if (opcionResp.statusCode == 200) {
      final opcionDoc = xml.XmlDocument.parse(opcionResp.body);

      final respuesta =
          opcionDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          opcionDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = opcionDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final opcionesRaw = decodedResp.entries.first.value['Table'];

        if (opcionesRaw is List) {
          return List.from(opcionesRaw)
              .map((e) => OpcionModel.fromJson(e))
              .toList();
        } else {
          return [OpcionModel.fromJson(opcionesRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
