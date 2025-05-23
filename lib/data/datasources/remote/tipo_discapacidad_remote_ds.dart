import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/tipo_discapacidad_model.dart';
import '../../utils.dart';

abstract class TipoDiscapacidadRemoteDataSource {
  Future<List<TipoDiscapacidadModel>> getTiposDiscapacidades(
      UsuarioEntity usuario);
}

class TipoDiscapacidadRemoteDataSourceImpl
    implements TipoDiscapacidadRemoteDataSource {
  final http.Client client;

  TipoDiscapacidadRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoDiscapacidadModel>> getTiposDiscapacidades(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final tipoDiscapacidadSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposDiscapacidades</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final tipoDiscapacidadResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: tipoDiscapacidadSOAP);

      if (tipoDiscapacidadResp.statusCode != 200) {
        throw const ServerFailure(
            ['Error al obtener los tipos de discapacidad']);
      }

      final tipoDiscapacidadDoc =
          xml.XmlDocument.parse(tipoDiscapacidadResp.body);

      final respuesta = tipoDiscapacidadDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        if (tipoDiscapacidadDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = tipoDiscapacidadDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tiposDiscapacidadesRaw = decodedResp.entries.first.value['Table'];

        if (tiposDiscapacidadesRaw is List) {
          return List.from(tiposDiscapacidadesRaw)
              .map((e) => TipoDiscapacidadModel.fromJson(e))
              .toList();
        } else {
          return [TipoDiscapacidadModel.fromJson(tiposDiscapacidadesRaw)];
        }
      } else {
        throw const ServerFailure(
            ['Error al obtener los tipos de discapacidad']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
