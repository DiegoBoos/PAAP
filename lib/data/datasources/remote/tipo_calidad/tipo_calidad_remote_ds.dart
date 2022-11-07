import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/tipo_calidad_model.dart';
import '../../../utils.dart';

abstract class TipoCalidadRemoteDataSource {
  Future<List<TipoCalidadModel>> getTiposCalidades(UsuarioEntity usuario);
}

class TipoCalidadRemoteDataSourceImpl implements TipoCalidadRemoteDataSource {
  final http.Client client;

  TipoCalidadRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoCalidadModel>> getTiposCalidades(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final tipocalidadSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposCalidades</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final tipocalidadResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: tipocalidadSOAP);

    if (tipocalidadResp.statusCode == 200) {
      final tipocalidadDoc = xml.XmlDocument.parse(tipocalidadResp.body);

      final respuesta =
          tipocalidadDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          tipocalidadDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = tipocalidadDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tipocalidadesRaw = decodedResp.entries.first.value['Table'];
        final tipocalidades = List.from(tipocalidadesRaw)
            .map((e) => TipoCalidadModel.fromJson(e))
            .toList();

        return tipocalidades;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
