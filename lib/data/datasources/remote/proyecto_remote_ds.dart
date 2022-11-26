import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/proyecto_model.dart';
import '../../utils.dart';

abstract class ProyectoRemoteDataSource {
  Future<List<ProyectoModel>> getProyectos(UsuarioEntity usuario);
}

class ProyectoRemoteDataSourceImpl implements ProyectoRemoteDataSource {
  final http.Client client;

  ProyectoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProyectoModel>> getProyectos(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final proyectoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaProyectos</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final proyectoResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: proyectoSOAP);

    if (proyectoResp.statusCode == 200) {
      final proyectoDoc = xml.XmlDocument.parse(proyectoResp.body);

      final respuesta =
          proyectoDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          proyectoDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = proyectoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final proyectosRaw = decodedResp.entries.first.value['Table'];

        if (proyectosRaw is List) {
          return List.from(proyectosRaw)
              .map((e) => ProyectoModel.fromJson(e))
              .toList();
        } else {
          return [ProyectoModel.fromJson(proyectosRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
