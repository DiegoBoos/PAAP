import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/actividad_financiera_model.dart';
import '../../../utils.dart';

abstract class ActividadFinancieraRemoteDataSource {
  Future<List<ActividadFinancieraModel>> getActividadesFinancieras(
      UsuarioEntity usuario);
}

class ActividadFinancieraRemoteDataSourceImpl
    implements ActividadFinancieraRemoteDataSource {
  final http.Client client;

  ActividadFinancieraRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ActividadFinancieraModel>> getActividadesFinancieras(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final actividadFinancieraSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaActividadesFinancieras</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final actividadFinancieraResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: actividadFinancieraSOAP);

    if (actividadFinancieraResp.statusCode == 200) {
      final actividadFinancieraDoc =
          xml.XmlDocument.parse(actividadFinancieraResp.body);

      final respuesta = actividadFinancieraDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = actividadFinancieraDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        final xmlString = actividadFinancieraDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final actividadesFinancierasRaw =
            decodedResp.entries.first.value['Table'];

        if (actividadesFinancierasRaw is List) {
          return List.from(actividadesFinancierasRaw)
              .map((e) => ActividadFinancieraModel.fromJson(e))
              .toList();
        } else {
          return [ActividadFinancieraModel.fromJson(actividadesFinancierasRaw)];
        }
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
