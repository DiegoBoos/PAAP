import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/unidad_model.dart';
import '../../../utils.dart';

abstract class UnidadRemoteDataSource {
  Future<List<UnidadModel>> getUnidades(UsuarioEntity usuario);
}

class UnidadRemoteDataSourceImpl implements UnidadRemoteDataSource {
  final http.Client client;

  UnidadRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UnidadModel>> getUnidades(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final unidadSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaUnidades</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final unidadResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: unidadSOAP);

    if (unidadResp.statusCode == 200) {
      final unidadDoc = xml.XmlDocument.parse(unidadResp.body);

      final respuesta =
          unidadDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          unidadDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = unidadDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final unidadsRaw = decodedResp.entries.first.value['Table'];
        final unidads =
            List.from(unidadsRaw).map((e) => UnidadModel.fromJson(e)).toList();

        return unidads;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
