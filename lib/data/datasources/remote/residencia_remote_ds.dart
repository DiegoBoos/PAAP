import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/residencia_model.dart';
import '../../utils.dart';

abstract class ResidenciaRemoteDataSource {
  Future<List<ResidenciaModel>> getResidencias(UsuarioEntity usuario);
}

class ResidenciaRemoteDataSourceImpl implements ResidenciaRemoteDataSource {
  final http.Client client;

  ResidenciaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ResidenciaModel>> getResidencias(UsuarioEntity usuario) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final residenciaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaResidencias</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final residenciaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: residenciaSOAP);

      if (residenciaResp.statusCode == 200) {
        final residenciaDoc = xml.XmlDocument.parse(residenciaResp.body);

        final respuesta =
            residenciaDoc.findAllElements('respuesta').map((e) => e.text).first;

        if (respuesta == 'true' &&
            residenciaDoc.findAllElements('NewDataSet').isNotEmpty) {
          final xmlString = residenciaDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final residenciasRaw = decodedResp.entries.first.value['Table'];

          if (residenciasRaw is List) {
            return List.from(residenciasRaw)
                .map((e) => ResidenciaModel.fromJson(e))
                .toList();
          } else {
            return [ResidenciaModel.fromJson(residenciasRaw)];
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
