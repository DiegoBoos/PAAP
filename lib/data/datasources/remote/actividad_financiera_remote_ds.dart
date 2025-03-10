import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/actividad_financiera_model.dart';
import '../../utils.dart';

abstract class ActividadFinancieraRemoteDataSource {
  Future<List<ActividadFinancieraModel>> getActividadesFinancieras(
      UsuarioEntity usuario);
}

class ActividadFinancieraRemoteDataSourceImpl
    implements ActividadFinancieraRemoteDataSource {
  final http.Client client;

  ActividadFinancieraRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ActividadFinancieraModel>> getActividadesFinancieras(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final actividadFinancieraSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaActividadesFinancieras</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final actividadFinancieraResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: actividadFinancieraSOAP);

      if (actividadFinancieraResp.statusCode != 200) {
        throw const ServerFailure(
            ['Error al obtener las actividades financieras']);
      }

      final actividadFinancieraDoc =
          xml.XmlDocument.parse(actividadFinancieraResp.body);

      final respuesta = actividadFinancieraDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = actividadFinancieraDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        if (actividadFinancieraDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = actividadFinancieraDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final actividadesFinancierasRaw =
            decodedResp.entries.first.value['Table'];

        if (actividadesFinancierasRaw is List) {
          return List.from(actividadesFinancierasRaw)
              .map((e) => ActividadFinancieraModel.fromJson(e))
              .toList();
        } else {
          return [ActividadFinancieraModel.fromJson(actividadesFinancierasRaw)];
        }
      } else {
        throw ServerFailure([mensaje]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
