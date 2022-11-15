import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/rubro_model.dart';
import '../../../utils.dart';

abstract class RubroRemoteDataSource {
  Future<List<RubroModel>> getRubros(UsuarioEntity usuario);
}

class RubroRemoteDataSourceImpl implements RubroRemoteDataSource {
  final http.Client client;

  RubroRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RubroModel>> getRubros(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final rubroSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaRubros</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final rubroResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: rubroSOAP);

    if (rubroResp.statusCode == 200) {
      final rubroDoc = xml.XmlDocument.parse(rubroResp.body);

      final respuesta =
          rubroDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          rubroDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = rubroDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final rubrosRaw = decodedResp.entries.first.value['Table'];

        if (rubrosRaw is List) {
          return List.from(rubrosRaw)
              .map((e) => RubroModel.fromJson(e))
              .toList();
        } else {
          return [RubroModel.fromJson(rubrosRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
