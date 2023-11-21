import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/estado_civil_model.dart';
import '../../utils.dart';

abstract class EstadoCivilRemoteDataSource {
  Future<List<EstadoCivilModel>> getEstadosCiviles(UsuarioEntity usuario);
}

class EstadoCivilRemoteDataSourceImpl implements EstadoCivilRemoteDataSource {
  final http.Client client;

  EstadoCivilRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EstadoCivilModel>> getEstadosCiviles(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final estadocivilSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaEstadosCiviles</string>       
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final estadocivilResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: estadocivilSOAP);

      if (estadocivilResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los estados civiles']);
      }

      final estadocivilDoc = xml.XmlDocument.parse(estadocivilResp.body);

      final respuesta =
          estadocivilDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (estadocivilDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = estadocivilDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final estadosCivilesRaw = decodedResp.entries.first.value['Table'];

        if (estadosCivilesRaw is List) {
          return List.from(estadosCivilesRaw)
              .map((e) => EstadoCivilModel.fromJson(e))
              .toList();
        } else {
          return [EstadoCivilModel.fromJson(estadosCivilesRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener los estados civiles']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
