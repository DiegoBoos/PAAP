import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/actividad_economica_model.dart';
import '../../../utils.dart';

abstract class ActividadEconomicaRemoteDataSource {
  Future<List<ActividadEconomicaModel>> getActividadesEconomicas(
      UsuarioEntity usuario);
}

class ActividadEconomicaRemoteDataSourceImpl
    implements ActividadEconomicaRemoteDataSource {
  final http.Client client;

  ActividadEconomicaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ActividadEconomicaModel>> getActividadesEconomicas(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final actividadEconomicaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaActividadesEconomicas</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final actividadEconomicaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: actividadEconomicaSOAP);

    if (actividadEconomicaResp.statusCode == 200) {
      final actividadEconomicaDoc =
          xml.XmlDocument.parse(actividadEconomicaResp.body);

      final respuesta = actividadEconomicaDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = actividadEconomicaDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        final xmlString = actividadEconomicaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final actividadesEconomicasRaw =
            decodedResp.entries.first.value['Table'];
        final actividadesEconomicas = List.from(actividadesEconomicasRaw)
            .map((e) => ActividadEconomicaModel.fromJson(e))
            .toList();

        return actividadesEconomicas;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
