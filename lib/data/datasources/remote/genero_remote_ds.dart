import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/genero_model.dart';
import '../../utils.dart';

abstract class GeneroRemoteDataSource {
  Future<List<GeneroModel>> getGeneros(UsuarioEntity usuario);
}

class GeneroRemoteDataSourceImpl implements GeneroRemoteDataSource {
  final http.Client client;

  GeneroRemoteDataSourceImpl({required this.client});

  @override
  Future<List<GeneroModel>> getGeneros(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final generoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaGeneros</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final generoResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: generoSOAP);

      if (generoResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los géneros']);
      }

      final generoDoc = xml.XmlDocument.parse(generoResp.body);

      final respuesta =
          generoDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (generoDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = generoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final generosRaw = decodedResp.entries.first.value['Table'];

        if (generosRaw is List) {
          return List.from(generosRaw)
              .map((e) => GeneroModel.fromJson(e))
              .toList();
        } else {
          return [GeneroModel.fromJson(generosRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener los géneros']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
