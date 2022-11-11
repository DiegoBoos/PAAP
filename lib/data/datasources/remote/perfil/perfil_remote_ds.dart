import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/perfil_model.dart';
import '../../../models/perfiles_model.dart';
import '../../../utils.dart';

abstract class PerfilRemoteDataSource {
  Future<List<PerfilModel>> getPerfiles(UsuarioEntity usuario);
  Future<List<PerfilModel>> getPerfilesFiltros(
      UsuarioEntity usuario, String id, String nombre);
}

class PerfilesRemoteDataSourceImpl implements PerfilRemoteDataSource {
  final http.Client client;

  PerfilesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilModel>> getPerfiles(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilesSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
          </usuario>
          <rol>
            <RolId>400</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaPerfiles</string> 
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final perfilesResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilesSOAP);

    if (perfilesResp.statusCode == 200) {
      final perfilesDoc = xml.XmlDocument.parse(perfilesResp.body);

      final respuesta =
          perfilesDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          perfilesDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = perfilesDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilesRaw = decodedResp.entries.first.value['Table'];

        final perfiles = List.from(perfilesRaw)
            .map((e) => PerfilesModel.fromJson(e))
            .toList();

        List<PerfilModel> listPerfil = [];
        for (var perfil in perfiles) {
          final dsPerfil = await getPerfilTable(usuario, perfil.id);
          listPerfil.add(dsPerfil);
        }
        return listPerfil;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PerfilModel>> getPerfilesFiltros(
      UsuarioEntity usuario, String? id, String? nombre) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilesSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
          </usuario>
          <rol>
            <RolId>400</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaPerfilFiltros</string>        
            <string>$nombre</string>        
            <string>$id</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final perfilesResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilesSOAP);

    if (perfilesResp.statusCode == 200) {
      final perfilesDoc = xml.XmlDocument.parse(perfilesResp.body);

      final respuesta =
          perfilesDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          perfilesDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (perfilesDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }
        final xmlString = perfilesDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilesRaw = decodedResp.entries.first.value['Table'];

        if (perfilesRaw is List) {
          final perfiles = List.from(perfilesRaw)
              .map((e) => PerfilesModel.fromJson(e))
              .toList();

          List<PerfilModel> listPerfil = [];
          for (var perfil in perfiles) {
            final dsPerfil = await getPerfilTable(usuario, perfil.id);
            listPerfil.add(dsPerfil);
          }
          return listPerfil;
        } else {
          return [PerfilModel.fromJson(perfilesRaw)];
        }
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  Future<PerfilModel> getPerfilTable(
      UsuarioEntity usuario, String perfilId) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilesSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarPerfil xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
            </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <PerfilId>$perfilId</PerfilId>
          </objeto>
        </ConsultarPerfil>
      </soap:Body>
    </soap:Envelope>''';

    final perfilResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ConsultarPerfil"
        },
        body: perfilesSOAP);

    if (perfilResp.statusCode == 200) {
      final perfilDoc = xml.XmlDocument.parse(perfilResp.body);

      final respuesta =
          perfilDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          perfilDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = perfilDoc
            .findAllElements('objeto')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final decodedResp = json.decode(res);

        final perfil = PerfilModel.fromJson(decodedResp['objeto']);

        return perfil;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
