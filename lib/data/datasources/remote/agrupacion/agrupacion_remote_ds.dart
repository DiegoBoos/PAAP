import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/agrupacion_model.dart';
import '../../../utils.dart';

abstract class AgrupacionRemoteDataSource {
  Future<List<AgrupacionModel>> getAgrupaciones(UsuarioEntity usuario);
}

class AgrupacionRemoteDataSourceImpl implements AgrupacionRemoteDataSource {
  final http.Client client;

  AgrupacionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AgrupacionModel>> getAgrupaciones(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final agrupacionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaAgrupaciones</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final agrupacionResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: agrupacionSOAP);

    if (agrupacionResp.statusCode == 200) {
      final agrupacionDoc = xml.XmlDocument.parse(agrupacionResp.body);

      final respuesta =
          agrupacionDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          agrupacionDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = agrupacionDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final agrupacionsRaw = decodedResp.entries.first.value['Table'];
        final agrupacions = List.from(agrupacionsRaw)
            .map((e) => AgrupacionModel.fromJson(e))
            .toList();

        return agrupacions;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
