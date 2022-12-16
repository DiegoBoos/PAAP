import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/indicador_model.dart';
import '../../utils.dart';

abstract class IndicadorRemoteDataSource {
  Future<List<IndicadorModel>> getIndicadores(UsuarioEntity usuario);
}

class IndicadorRemoteDataSourceImpl implements IndicadorRemoteDataSource {
  final http.Client client;

  IndicadorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<IndicadorModel>> getIndicadores(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final indicadorSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaIndicadores</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final indicadorResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: indicadorSOAP);

    if (indicadorResp.statusCode == 200) {
      final indicadorDoc = xml.XmlDocument.parse(indicadorResp.body);

      final respuesta =
          indicadorDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          indicadorDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = indicadorDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final indicadoresRaw = decodedResp.entries.first.value['Table'];

        if (indicadoresRaw is List) {
          return List.from(indicadoresRaw)
              .map((e) => IndicadorModel.fromJson(e))
              .toList();
        } else {
          return [IndicadorModel.fromJson(indicadoresRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
