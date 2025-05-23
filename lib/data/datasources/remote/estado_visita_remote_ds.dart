import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/estado_visita_model.dart';
import '../../utils.dart';

abstract class EstadoVisitaRemoteDataSource {
  Future<List<EstadoVisitaModel>> getEstadosVisitas(UsuarioEntity usuario);
}

class EstadoVisitaRemoteDataSourceImpl implements EstadoVisitaRemoteDataSource {
  final http.Client client;

  EstadoVisitaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EstadoVisitaModel>> getEstadosVisitas(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final estadovisitaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaEstadosVisitas</string>       
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final estadovisitaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: estadovisitaSOAP);

      if (estadovisitaResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los estados de visita']);
      }

      final estadovisitaDoc = xml.XmlDocument.parse(estadovisitaResp.body);

      final respuesta =
          estadovisitaDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          estadovisitaDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (estadovisitaDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = estadovisitaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final estadovisitasRaw = decodedResp.entries.first.value['Table'];
        final estadovisitas = List.from(estadovisitasRaw)
            .map((e) => EstadoVisitaModel.fromJson(e))
            .toList();

        return estadovisitas;
      } else {
        throw ServerFailure([mensaje]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
