import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../models/convocatoria.dart';
import '../../utils.dart';

abstract class ConvocatoriaRemoteDataSource {
  Future<List<ConvocatoriaModel>> getConvocatorias(UsuarioEntity usuario);
}

class ConvocatoriaRemoteDataSourceImpl implements ConvocatoriaRemoteDataSource {
  final http.Client client;

  ConvocatoriaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ConvocatoriaModel>> getConvocatorias(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final convocatoriaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaConvocatorias</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final convocatoriaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: convocatoriaSOAP);

      if (convocatoriaResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener las convocatorias']);
      }

      final convocatoriaDoc = xml.XmlDocument.parse(convocatoriaResp.body);

      final respuesta =
          convocatoriaDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (convocatoriaDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = convocatoriaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final convocatoriasRaw = decodedResp.entries.first.value['Table'];

        if (convocatoriasRaw is List) {
          return List.from(convocatoriasRaw)
              .map((e) => ConvocatoriaModel.fromJson(e))
              .toList();
        } else {
          return [ConvocatoriaModel.fromJson(convocatoriasRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener las convocatorias']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
