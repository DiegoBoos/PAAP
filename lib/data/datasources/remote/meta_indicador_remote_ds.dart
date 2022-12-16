import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/meta_indicador_model.dart';
import '../../utils.dart';

abstract class MetaIndicadorRemoteDataSource {
  Future<List<MetaIndicadorModel>> getMetasIndicadores(UsuarioEntity usuario);
}

class MetaIndicadorRemoteDataSourceImpl
    implements MetaIndicadorRemoteDataSource {
  final http.Client client;

  MetaIndicadorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MetaIndicadorModel>> getMetasIndicadores(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final metaIndicadorSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Nombre>${usuario.nombre}</Nombre>
            <Apellido>${usuario.apellido}</Apellido>
            <Direccion>${usuario.direccion}</Direccion>
            <TelefonoFijo>${usuario.telefonoFijo}</TelefonoFijo>
            <TelefonoMovil>${usuario.telefonoMovil}</TelefonoMovil>
            <Correo>${usuario.correo}</Correo>
            <Contrasena>${usuario.contrasena}</Contrasena>
            <FechaActivacion>${usuario.fechaActivacion}</FechaActivacion>
            <FechaDesactivacion>${usuario.fechaDesactivacion}</FechaDesactivacion>
            <FechaCambio>${usuario.fechaCambio}</FechaCambio>
            <Activo>${usuario.activo}</Activo>
          </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaMetasIndicadores</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final metaIndicadorResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: metaIndicadorSOAP);

    if (metaIndicadorResp.statusCode == 200) {
      final metaIndicadorDoc = xml.XmlDocument.parse(metaIndicadorResp.body);

      final respuesta = metaIndicadorDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          metaIndicadorDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = metaIndicadorDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final metasIndicadoresRaw = decodedResp.entries.first.value['Table'];

        if (metasIndicadoresRaw is List) {
          return List.from(metasIndicadoresRaw)
              .map((e) => MetaIndicadorModel.fromJson(e))
              .toList();
        } else {
          return [MetaIndicadorModel.fromJson(metasIndicadoresRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
