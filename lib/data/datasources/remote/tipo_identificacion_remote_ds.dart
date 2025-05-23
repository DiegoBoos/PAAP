import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/tipo_identificacion_model.dart';
import '../../utils.dart';

abstract class TipoIdentificacionRemoteDataSource {
  Future<List<TipoIdentificacionModel>> getTiposIdentificaciones(
      UsuarioEntity usuario);
}

class TipoIdentificacionRemoteDataSourceImpl
    implements TipoIdentificacionRemoteDataSource {
  final http.Client client;

  TipoIdentificacionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoIdentificacionModel>> getTiposIdentificaciones(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final tipoIdentificacionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposIdentificaciones</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final tipoIdentificacionResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: tipoIdentificacionSOAP);

      if (tipoIdentificacionResp.statusCode != 200) {
        throw const ServerFailure(
            ['Error al obtener los tipos de identificación']);
      }

      final tipoIdentificacionDoc =
          xml.XmlDocument.parse(tipoIdentificacionResp.body);

      final respuesta = tipoIdentificacionDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        if (tipoIdentificacionDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = tipoIdentificacionDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tiposIdentificacionesRaw =
            decodedResp.entries.first.value['Table'];

        if (tiposIdentificacionesRaw is List) {
          return List.from(tiposIdentificacionesRaw)
              .map((e) => TipoIdentificacionModel.fromJson(e))
              .toList();
        } else {
          return [TipoIdentificacionModel.fromJson(tiposIdentificacionesRaw)];
        }
      } else {
        throw const ServerFailure(
            ['Error al obtener los tipos de identificación']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
