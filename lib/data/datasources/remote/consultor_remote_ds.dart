import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/consultor_model.dart';
import '../../utils.dart';

abstract class ConsultorRemoteDataSource {
  Future<List<ConsultorModel>> getConsultores(UsuarioEntity usuario);
}

class ConsultorRemoteDataSourceImpl implements ConsultorRemoteDataSource {
  final http.Client client;

  ConsultorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ConsultorModel>> getConsultores(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final consultorSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaConsultores</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final consultorResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: consultorSOAP);

      if (consultorResp.statusCode == 200) {
        final consultorDoc = xml.XmlDocument.parse(consultorResp.body);

        final respuesta =
            consultorDoc.findAllElements('respuesta').map((e) => e.text).first;

        if (respuesta == 'true' &&
            consultorDoc.findAllElements('NewDataSet').isNotEmpty) {
          final xmlString = consultorDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final consultoresRaw = decodedResp.entries.first.value['Table'];

          if (consultoresRaw is List) {
            return List.from(consultoresRaw)
                .map((e) => ConsultorModel.fromJson(e))
                .toList();
          } else {
            return [ConsultorModel.fromJson(consultoresRaw)];
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
