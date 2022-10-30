import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/tipo_proyecto_model.dart';
import '../../../utils.dart';

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

    final tipoproyectoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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

    final tipoproyectoResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: tipoproyectoSOAP);

    if (tipoproyectoResp.statusCode == 200) {
      final tipoproyectoDoc = xml.XmlDocument.parse(tipoproyectoResp.body);

      final respuesta =
          tipoproyectoDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          tipoproyectoDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = tipoproyectoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tipoproyectosRaw = decodedResp.entries.first.value['Table'];
        final tipoproyectos = List.from(tipoproyectosRaw)
            .map((e) => TipoProyectoModel.fromJson(e))
            .toList();

        return tipoproyectos;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
