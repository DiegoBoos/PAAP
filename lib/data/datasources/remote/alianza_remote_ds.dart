import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/alianza_model.dart';
import '../../models/alianzas_model.dart';
import '../../utils.dart';

abstract class AlianzaRemoteDataSource {
  Future<List<AlianzaModel>> getAlianzas(UsuarioEntity usuario);
}

class AlianzaRemoteDataSourceImpl implements AlianzaRemoteDataSource {
  final http.Client client;

  AlianzaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AlianzaModel>> getAlianzas(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final alianzaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaAlianzas</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final alianzaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: alianzaSOAP);

      if (alianzaResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener las alianzas']);
      }

      final alianzaDoc = xml.XmlDocument.parse(alianzaResp.body);

      final respuesta =
          alianzaDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (alianzaDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = alianzaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final alianzasRaw = decodedResp.entries.first.value['Table'];
        final alianzas = List.from(alianzasRaw)
            .map((e) => AlianzasModel.fromJson(e))
            .toList();

        List<AlianzaModel> listAlianza = [];
        for (var alianza in alianzas) {
          final dsAlianza = await getAlianzaTable(usuario, alianza.id!);
          listAlianza.add(dsAlianza);
        }
        return listAlianza;
      } else {
        throw const ServerFailure(['Error al obtener las alianzas']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<AlianzaModel> getAlianzaTable(
      UsuarioEntity usuario, String alianzaId) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final alianzaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarAlianza xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
          <objeto>
            <AlianzaId>$alianzaId</AlianzaId>
          </objeto>
        </ConsultarAlianza>
      </soap:Body>
    </soap:Envelope>''';

      final alianzaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ConsultarAlianza"
          },
          body: alianzaSOAP);

      if (alianzaResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener la alianza']);
      }

      final alianzaDoc = xml.XmlDocument.parse(alianzaResp.body);

      final respuesta =
          alianzaDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          alianzaDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = alianzaDoc
            .findAllElements('objeto')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final decodedResp = json.decode(res);

        final alianza = AlianzaModel.fromJson(decodedResp['objeto']);

        return alianza;
      } else {
        throw ServerFailure([mensaje]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
