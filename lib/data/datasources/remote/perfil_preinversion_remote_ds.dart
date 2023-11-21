import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/perfil_preinversion_model.dart';
import '../../models/perfiles_preinversion_model.dart';
import '../../utils.dart';

abstract class PerfilPreInversionRemoteDataSource {
  Future<List<PerfilPreInversionModel>> getPerfilesPreInversion(
      UsuarioEntity usuario);
}

class PerfilesPreInversionRemoteDataSourceImpl
    implements PerfilPreInversionRemoteDataSource {
  final http.Client client;

  PerfilesPreInversionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreInversionModel>> getPerfilesPreInversion(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilesPreInversionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <RolId>400</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaPerfilesPreInversiones</string> 
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilesPreInversionResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: perfilesPreInversionSOAP);

      if (perfilesPreInversionResp.statusCode != 200) {
        throw const ServerFailure(
            ['Error al obtener los perfiles de preinversión']);
      }

      final perfilesPreInversionDoc =
          xml.XmlDocument.parse(perfilesPreInversionResp.body);

      final respuesta = perfilesPreInversionDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = perfilesPreInversionDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        if (perfilesPreInversionDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = perfilesPreInversionDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilesPreInversionRaw =
            decodedResp.entries.first.value['Table'];

        final perfilesPreInversion = List.from(perfilesPreInversionRaw)
            .map((e) => PerfilesPreInversionModel.fromJson(e))
            .toList();

        List<PerfilPreInversionModel> listPerfilesPreInversion = [];
        for (var perfilPreInversion in perfilesPreInversion) {
          final dsPerfilPreInversion =
              await getPerfilPreInversionTable(usuario, perfilPreInversion.id);
          listPerfilesPreInversion.add(dsPerfilPreInversion);
        }
        return listPerfilesPreInversion;
      } else {
        throw ServerFailure([mensaje]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<PerfilPreInversionModel> getPerfilPreInversionTable(
      UsuarioEntity usuario, String perfilPreInversionId) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilesPreInversionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarPerfilPreInversion xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>$perfilPreInversionId</PerfilPreInversionId>
          </objeto>
        </ConsultarPerfilPreInversion>
      </soap:Body>
    </soap:Envelope>''';

      final perfilRespPreInversion = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ConsultarPerfilPreInversion"
          },
          body: perfilesPreInversionSOAP);

      if (perfilRespPreInversion.statusCode != 200) {
        throw const ServerFailure(
            ['Error al obtener el perfil de preinversión']);
      }

      final perfilPreInversionDoc =
          xml.XmlDocument.parse(perfilRespPreInversion.body);

      final respuesta = perfilPreInversionDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = perfilPreInversionDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        final xmlString = perfilPreInversionDoc
            .findAllElements('objeto')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final decodedResp = json.decode(res);

        final perfilPreInversion =
            PerfilPreInversionModel.fromJson(decodedResp['objeto']);

        return perfilPreInversion;
      } else {
        throw ServerFailure([mensaje]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
