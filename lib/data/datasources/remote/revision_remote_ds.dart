import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/revision_model.dart';
import '../../utils.dart';

abstract class RevisionRemoteDataSource {
  Future<List<RevisionModel>> getRevisiones(UsuarioEntity usuario);
}

class RevisionRemoteDataSourceImpl implements RevisionRemoteDataSource {
  final http.Client client;

  RevisionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RevisionModel>> getRevisiones(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final revisionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaRevisiones</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final revisionResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: revisionSOAP);

      if (revisionResp.statusCode == 200) {
        final revisionDoc = xml.XmlDocument.parse(revisionResp.body);

        final respuesta =
            revisionDoc.findAllElements('respuesta').map((e) => e.text).first;

        if (respuesta == 'true' &&
            revisionDoc.findAllElements('NewDataSet').isNotEmpty) {
          final xmlString = revisionDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final revisionesRaw = decodedResp.entries.first.value['Table'];

          if (revisionesRaw is List) {
            return List.from(revisionesRaw)
                .map((e) => RevisionModel.fromJson(e))
                .toList();
          } else {
            return [RevisionModel.fromJson(revisionesRaw)];
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
