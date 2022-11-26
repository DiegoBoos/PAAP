import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/tipo_proyecto_model.dart';
import '../../utils.dart';

abstract class TipoProyectoRemoteDataSource {
  Future<List<TipoProyectoModel>> getTiposProyectos(UsuarioEntity usuario);
}

class TipoProyectoRemoteDataSourceImpl implements TipoProyectoRemoteDataSource {
  final http.Client client;

  TipoProyectoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoProyectoModel>> getTiposProyectos(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final tipoProyectoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposProyectos</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final tipoProyectoResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: tipoProyectoSOAP);

    if (tipoProyectoResp.statusCode == 200) {
      final tipoProyectoDoc = xml.XmlDocument.parse(tipoProyectoResp.body);

      final respuesta =
          tipoProyectoDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          tipoProyectoDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = tipoProyectoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tiposProyectosRaw = decodedResp.entries.first.value['Table'];

        if (tiposProyectosRaw is List) {
          return List.from(tiposProyectosRaw)
              .map((e) => TipoProyectoModel.fromJson(e))
              .toList();
        } else {
          return [TipoProyectoModel.fromJson(tiposProyectosRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
