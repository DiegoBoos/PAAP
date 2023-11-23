import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/perfil_cofinanciador_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/perfil_cofinanciador_model.dart';
import '../../utils.dart';

abstract class PerfilCofinanciadorRemoteDataSource {
  Future<List<PerfilCofinanciadorModel>> getPerfilCofinanciadores(
      UsuarioEntity usuario);
  Future<List<PerfilCofinanciadorEntity>> savePerfilesCofinanciadores(
      UsuarioEntity usuario,
      List<PerfilCofinanciadorEntity> perfilesCofinanciadoressEntity);
}

class PerfilCofinanciadorRemoteDataSourceImpl
    implements PerfilCofinanciadorRemoteDataSource {
  final http.Client client;

  PerfilCofinanciadorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilCofinanciadorModel>> getPerfilCofinanciadores(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilCofinanciadoresOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaPerfilesCofinanciadores</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilCofinanciadorResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: perfilCofinanciadoresOAP);

      if (perfilCofinanciadorResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los cofinanciadores']);
      }

      final perfilCofinanciadorDoc =
          xml.XmlDocument.parse(perfilCofinanciadorResp.body);

      final respuesta = perfilCofinanciadorDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        if (perfilCofinanciadorDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = perfilCofinanciadorDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilCofinanciadoresRaw =
            decodedResp.entries.first.value['Table'];

        if (perfilCofinanciadoresRaw is List) {
          return List.from(perfilCofinanciadoresRaw)
              .map((e) => PerfilCofinanciadorModel.fromJson(e))
              .toList();
        } else {
          return [PerfilCofinanciadorModel.fromJson(perfilCofinanciadoresRaw)];
        }
      } else {
        throw const ServerFailure(
            ['Error al obtener los cofinanciadores del perfil']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<List<PerfilCofinanciadorEntity>> savePerfilesCofinanciadores(
      UsuarioEntity usuario,
      List<PerfilCofinanciadorEntity> perfilesCofinanciadoresEntity) async {
    List<PerfilCofinanciadorEntity> perfilesCofinanciadoresUpload = [];
    for (var perfilCofinanciador in perfilesCofinanciadoresEntity) {
      final resp = await savePerfilCofinanciador(usuario, perfilCofinanciador);
      if (resp != null) {
        perfilesCofinanciadoresUpload.add(resp);
      }
    }
    return perfilesCofinanciadoresUpload;
  }

  Future<PerfilCofinanciadorEntity?> savePerfilCofinanciador(
      UsuarioEntity usuario,
      PerfilCofinanciadorEntity perfilCofinanciadorEntity) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilCofinanciadoresOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilCofinanciador xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilId>${perfilCofinanciadorEntity.perfilId}</PerfilId>
            <CofinanciadorId>${perfilCofinanciadorEntity.cofinanciadorId}</CofinanciadorId>
            <Monto>${perfilCofinanciadorEntity.monto}</Monto>
            <Participacion>${perfilCofinanciadorEntity.participacion}</Participacion>   
          </objeto>
        </GuardarPerfilCofinanciador>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilCofinanciadorResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/GuardarPerfilCofinanciador"
          },
          body: perfilCofinanciadoresOAP);

      if (perfilCofinanciadorResp.statusCode != 200) {
        throw const ServerFailure(['Error al guardar el cofinanciador']);
      }

      final perfilCofinanciadorDoc =
          xml.XmlDocument.parse(perfilCofinanciadorResp.body);

      final respuesta = perfilCofinanciadorDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        return perfilCofinanciadorEntity;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
