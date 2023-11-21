import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/agrupacion_model.dart';
import '../../utils.dart';

abstract class AgrupacionRemoteDataSource {
  Future<List<AgrupacionModel>> getAgrupaciones(UsuarioEntity usuario);
}

class AgrupacionRemoteDataSourceImpl implements AgrupacionRemoteDataSource {
  final http.Client client;

  AgrupacionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AgrupacionModel>> getAgrupaciones(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final agrupacioneSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaAgrupaciones</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final agrupacionResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: agrupacioneSOAP);

      if (agrupacionResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener las agrupaciones']);
      }

      final agrupacionDoc = xml.XmlDocument.parse(agrupacionResp.body);

      final respuesta =
          agrupacionDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (agrupacionDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = agrupacionDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final agrupacionesRaw = decodedResp.entries.first.value['Table'];

        if (agrupacionesRaw is List) {
          return List.from(agrupacionesRaw)
              .map((e) => AgrupacionModel.fromJson(e))
              .toList();
        } else {
          return [AgrupacionModel.fromJson(agrupacionesRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener las agrupaciones']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
