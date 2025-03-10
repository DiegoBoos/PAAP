import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/sitio_entrega_model.dart';
import '../../utils.dart';

abstract class SitioEntregaRemoteDataSource {
  Future<List<SitioEntregaModel>> getSitiosEntregas(UsuarioEntity usuario);
}

class SitioEntregaRemoteDataSourceImpl implements SitioEntregaRemoteDataSource {
  final http.Client client;

  SitioEntregaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SitioEntregaModel>> getSitiosEntregas(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final sitioEntregaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaSitiosEntregas</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final sitioEntregaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: sitioEntregaSOAP);

      if (sitioEntregaResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los sitios de entrega']);
      }

      final sitioEntregaDoc = xml.XmlDocument.parse(sitioEntregaResp.body);

      final respuesta =
          sitioEntregaDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (sitioEntregaDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = sitioEntregaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final sitiosEntregasRaw = decodedResp.entries.first.value['Table'];

        if (sitiosEntregasRaw is List) {
          return List.from(sitiosEntregasRaw)
              .map((e) => SitioEntregaModel.fromJson(e))
              .toList();
        } else {
          return [SitioEntregaModel.fromJson(sitiosEntregasRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener los sitios de entrega']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
