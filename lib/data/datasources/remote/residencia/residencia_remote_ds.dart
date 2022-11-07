import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/residencia_model.dart';
import '../../../utils.dart';

abstract class ResidenciaRemoteDataSource {
  Future<List<ResidenciaModel>> getResidencias(UsuarioEntity usuario);
}

class ResidenciaRemoteDataSourceImpl implements ResidenciaRemoteDataSource {
  final http.Client client;

  ResidenciaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ResidenciaModel>> getResidencias(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final residenciaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaResidencias</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final residenciaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: residenciaSOAP);

    if (residenciaResp.statusCode == 200) {
      final residenciaDoc = xml.XmlDocument.parse(residenciaResp.body);

      final respuesta =
          residenciaDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          residenciaDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = residenciaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final residenciasRaw = decodedResp.entries.first.value['Table'];
        final residencias = List.from(residenciasRaw)
            .map((e) => ResidenciaModel.fromJson(e))
            .toList();

        return residencias;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
