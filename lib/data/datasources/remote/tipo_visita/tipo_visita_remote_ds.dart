import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/tipo_visita_model.dart';
import '../../../utils.dart';

abstract class TipoVisitaRemoteDataSource {
  Future<List<TipoVisitaModel>> getTiposVisitas(UsuarioEntity usuario);
}

class TipoVisitaRemoteDataSourceImpl implements TipoVisitaRemoteDataSource {
  final http.Client client;

  TipoVisitaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoVisitaModel>> getTiposVisitas(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final tipovisitaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposVisitas</string>       
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final tipovisitaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: tipovisitaSOAP);

    if (tipovisitaResp.statusCode == 200) {
      final tipovisitaDoc = xml.XmlDocument.parse(tipovisitaResp.body);

      final respuesta =
          tipovisitaDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          tipovisitaDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = tipovisitaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tipovisitasRaw = decodedResp.entries.first.value['Table'];

        final tipovisitas = List.from(tipovisitasRaw)
            .map((e) => TipoVisitaModel.fromJson(e))
            .toList();

        return tipovisitas;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
