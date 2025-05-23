import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

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
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final tipoProyectoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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

      if (tipoProyectoResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los tipos de proyectos']);
      }

      final tipoProyectoDoc = xml.XmlDocument.parse(tipoProyectoResp.body);

      final respuesta =
          tipoProyectoDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (tipoProyectoDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

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
        throw const ServerFailure(['Error al obtener los tipos de proyectos']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
