import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/cofinanciador_model.dart';
import '../../utils.dart';

abstract class CofinanciadorRemoteDataSource {
  Future<List<CofinanciadorModel>> getCofinanciadoresByDepartamento(
      UsuarioEntity usuario);
}

class CofinanciadorRemoteDataSourceImpl
    implements CofinanciadorRemoteDataSource {
  final http.Client client;

  CofinanciadorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CofinanciadorModel>> getCofinanciadoresByDepartamento(
      UsuarioEntity usuario) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final cofinanciadorSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaCofinanciadores</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final cofinanciadorResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: cofinanciadorSOAP);

      if (cofinanciadorResp.statusCode == 200) {
        final cofinanciadorDoc = xml.XmlDocument.parse(cofinanciadorResp.body);

        final respuesta = cofinanciadorDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            cofinanciadorDoc.findAllElements('NewDataSet').isNotEmpty) {
          final xmlString = cofinanciadorDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final cofinanciadoresRaw = decodedResp.entries.first.value['Table'];

          if (cofinanciadoresRaw is List) {
            return List.from(cofinanciadoresRaw)
                .map((e) => CofinanciadorModel.fromJson(e))
                .toList();
          } else {
            return [CofinanciadorModel.fromJson(cofinanciadoresRaw)];
          }
        } else {
          return [];
        }
      } else {
        throw ServerException();
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
