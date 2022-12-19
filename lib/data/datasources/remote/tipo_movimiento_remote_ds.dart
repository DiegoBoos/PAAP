import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/tipo_movimiento_model.dart';
import '../../utils.dart';

abstract class TipoMovimientoRemoteDataSource {
  Future<List<TipoMovimientoModel>> getTiposMovimientos(UsuarioEntity usuario);
}

class TipoMovimientoRemoteDataSourceImpl
    implements TipoMovimientoRemoteDataSource {
  final http.Client client;

  TipoMovimientoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoMovimientoModel>> getTiposMovimientos(
      UsuarioEntity usuario) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final tipoMovimientoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposMovimientos</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final tipoMovimientoResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: tipoMovimientoSOAP);

      if (tipoMovimientoResp.statusCode == 200) {
        final tipoMovimientoDoc =
            xml.XmlDocument.parse(tipoMovimientoResp.body);

        final respuesta = tipoMovimientoDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            tipoMovimientoDoc.findAllElements('NewDataSet').isNotEmpty) {
          final xmlString = tipoMovimientoDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final tiposMovimientosRaw = decodedResp.entries.first.value['Table'];

          if (tiposMovimientosRaw is List) {
            return List.from(tiposMovimientosRaw)
                .map((e) => TipoMovimientoModel.fromJson(e))
                .toList();
          } else {
            return [TipoMovimientoModel.fromJson(tiposMovimientosRaw)];
          }
        } else {
          return [];
        }
      } else {
        throw ServerException();
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
