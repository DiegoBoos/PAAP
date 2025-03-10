import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/actividad_economica_model.dart';
import '../../utils.dart';

abstract class ActividadEconomicaRemoteDataSource {
  Future<List<ActividadEconomicaModel>> getActividadesEconomicas(
      UsuarioEntity usuario);
}

class ActividadEconomicaRemoteDataSourceImpl
    implements ActividadEconomicaRemoteDataSource {
  final http.Client client;

  ActividadEconomicaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ActividadEconomicaModel>> getActividadesEconomicas(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final actividadEconomicaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaActividadesEconomicas</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final actividadEconomicaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: actividadEconomicaSOAP);

      if (actividadEconomicaResp.statusCode != 200) {
        throw const ServerFailure(
            ['Error al obtener las actividades económicas']);
      }

      final actividadEconomicaDoc =
          xml.XmlDocument.parse(actividadEconomicaResp.body);

      final respuesta = actividadEconomicaDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        if (actividadEconomicaDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = actividadEconomicaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final actividadesEconomicasRaw =
            decodedResp.entries.first.value['Table'];

        if (actividadesEconomicasRaw is List) {
          return List.from(actividadesEconomicasRaw)
              .map((e) => ActividadEconomicaModel.fromJson(e))
              .toList();
        } else {
          return [ActividadEconomicaModel.fromJson(actividadesEconomicasRaw)];
        }
      } else {
        throw const ServerFailure(
            ['Error al obtener las actividades económicas']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
