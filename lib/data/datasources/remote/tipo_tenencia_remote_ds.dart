import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/tipo_tenencia_model.dart';
import '../../utils.dart';

abstract class TipoTenenciaRemoteDataSource {
  Future<List<TipoTenenciaModel>> getTiposTenencias(UsuarioEntity usuario);
}

class TipoTenenciaRemoteDataSourceImpl implements TipoTenenciaRemoteDataSource {
  final http.Client client;

  TipoTenenciaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoTenenciaModel>> getTiposTenencias(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final tipoTenenciaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposTenencias</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final tipoTenenciaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: tipoTenenciaSOAP);

    if (tipoTenenciaResp.statusCode == 200) {
      final tipoTenenciaDoc = xml.XmlDocument.parse(tipoTenenciaResp.body);

      final respuesta =
          tipoTenenciaDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          tipoTenenciaDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = tipoTenenciaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tiposTenenciasRaw = decodedResp.entries.first.value['Table'];

        if (tiposTenenciasRaw is List) {
          return List.from(tiposTenenciasRaw)
              .map((e) => TipoTenenciaModel.fromJson(e))
              .toList();
        } else {
          return [TipoTenenciaModel.fromJson(tiposTenenciasRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
