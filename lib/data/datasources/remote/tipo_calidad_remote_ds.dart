import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/tipo_calidad_model.dart';
import '../../utils.dart';

abstract class TipoCalidadRemoteDataSource {
  Future<List<TipoCalidadModel>> getTiposCalidades(UsuarioEntity usuario);
}

class TipoCalidadRemoteDataSourceImpl implements TipoCalidadRemoteDataSource {
  final http.Client client;

  TipoCalidadRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoCalidadModel>> getTiposCalidades(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final tipoCalidadSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposCalidades</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final tipoCalidadResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: tipoCalidadSOAP);

      if (tipoCalidadResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los tipos de calidad']);
      }

      final tipoCalidadDoc = xml.XmlDocument.parse(tipoCalidadResp.body);

      final respuesta =
          tipoCalidadDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (tipoCalidadDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = tipoCalidadDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tiposCalidadesRaw = decodedResp.entries.first.value['Table'];

        if (tiposCalidadesRaw is List) {
          return List.from(tiposCalidadesRaw)
              .map((e) => TipoCalidadModel.fromJson(e))
              .toList();
        } else {
          return [TipoCalidadModel.fromJson(tiposCalidadesRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener los tipos de calidad']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
