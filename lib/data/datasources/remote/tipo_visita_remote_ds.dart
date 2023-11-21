import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/tipo_visita_model.dart';
import '../../utils.dart';

abstract class TipoVisitaRemoteDataSource {
  Future<List<TipoVisitaModel>> getTiposVisitas(UsuarioEntity usuario);
}

class TipoVisitaRemoteDataSourceImpl implements TipoVisitaRemoteDataSource {
  final http.Client client;

  TipoVisitaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoVisitaModel>> getTiposVisitas(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final tipoVisitaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposVisitas</string>       
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final tipoVisitaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: tipoVisitaSOAP);

      if (tipoVisitaResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los tipos de visita']);
      }

      final tipoVisitaDoc = xml.XmlDocument.parse(tipoVisitaResp.body);

      final respuesta =
          tipoVisitaDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (tipoVisitaDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = tipoVisitaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tiposVisitasRaw = decodedResp.entries.first.value['Table'];

        if (tiposVisitasRaw is List) {
          return List.from(tiposVisitasRaw)
              .map((e) => TipoVisitaModel.fromJson(e))
              .toList();
        } else {
          return [TipoVisitaModel.fromJson(tiposVisitasRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener los tipos de visita']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
