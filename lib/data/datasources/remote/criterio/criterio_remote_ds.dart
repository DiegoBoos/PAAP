import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/criterio_model.dart';
import '../../../utils.dart';

abstract class CriterioRemoteDataSource {
  Future<List<CriterioModel>> getCriterios(UsuarioEntity usuario);
}

class CriterioRemoteDataSourceImpl implements CriterioRemoteDataSource {
  final http.Client client;

  CriterioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CriterioModel>> getCriterios(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final criterioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaCriterios</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final criterioResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: criterioSOAP);

    if (criterioResp.statusCode == 200) {
      final criterioDoc = xml.XmlDocument.parse(criterioResp.body);

      final respuesta =
          criterioDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          criterioDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = criterioDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final criteriosRaw = decodedResp.entries.first.value['Table'];
        final criterios = List.from(criteriosRaw)
            .map((e) => CriterioModel.fromJson(e))
            .toList();

        return criterios;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
