import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/grupo_especial_model.dart';
import '../../utils.dart';

abstract class GrupoEspecialRemoteDataSource {
  Future<List<GrupoEspecialModel>> getGruposEspeciales(UsuarioEntity usuario);
}

class GrupoEspecialRemoteDataSourceImpl
    implements GrupoEspecialRemoteDataSource {
  final http.Client client;

  GrupoEspecialRemoteDataSourceImpl({required this.client});

  @override
  Future<List<GrupoEspecialModel>> getGruposEspeciales(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final grupoEspecialSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaGruposEspeciales</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final grupoEspecialResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: grupoEspecialSOAP);

    if (grupoEspecialResp.statusCode == 200) {
      final grupoEspecialDoc = xml.XmlDocument.parse(grupoEspecialResp.body);

      final respuesta = grupoEspecialDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          grupoEspecialDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = grupoEspecialDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final gruposEspecialesRaw = decodedResp.entries.first.value['Table'];

        if (gruposEspecialesRaw is List) {
          return List.from(gruposEspecialesRaw)
              .map((e) => GrupoEspecialModel.fromJson(e))
              .toList();
        } else {
          return [GrupoEspecialModel.fromJson(gruposEspecialesRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
