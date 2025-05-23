import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/tipo_entidad_model.dart';
import '../../utils.dart';

abstract class TipoEntidadRemoteDataSource {
  Future<List<TipoEntidadModel>> getTiposEntidades(UsuarioEntity usuario);
}

class TipoEntidadRemoteDataSourceImpl implements TipoEntidadRemoteDataSource {
  final http.Client client;

  TipoEntidadRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoEntidadModel>> getTiposEntidades(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final tipoEntidadSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposEntidades</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final tipoEntidadResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: tipoEntidadSOAP);

      if (tipoEntidadResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los tipos de entidades']);
      }

      final tipoEntidadDoc = xml.XmlDocument.parse(tipoEntidadResp.body);

      final respuesta =
          tipoEntidadDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (tipoEntidadDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = tipoEntidadDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tiposEntidadesRaw = decodedResp.entries.first.value['Table'];

        if (tiposEntidadesRaw is List) {
          return List.from(tiposEntidadesRaw)
              .map((e) => TipoEntidadModel.fromJson(e))
              .toList();
        } else {
          return [TipoEntidadModel.fromJson(tiposEntidadesRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener los tipos de entidades']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
