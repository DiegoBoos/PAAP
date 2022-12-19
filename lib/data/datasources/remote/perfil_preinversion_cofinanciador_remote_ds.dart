import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';
import '../../models/perfil_preinversion_cofinanciador_model.dart';
import '../../utils.dart';

abstract class PerfilPreInversionCofinanciadorRemoteDataSource {
  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilesPreInversionesCofinanciadores(UsuarioEntity usuario);
  Future<List<PerfilPreInversionCofinanciadorEntity>>
      savePerfilesPreInversionesCofinanciadores(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorEntity>
              perfilesPreInversionesCofinanciadoresEntity);
}

class PerfilPreInversionCofinanciadorRemoteDataSourceImpl
    implements PerfilPreInversionCofinanciadorRemoteDataSource {
  final http.Client client;

  PerfilPreInversionCofinanciadorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilesPreInversionesCofinanciadores(UsuarioEntity usuario) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final perfilPreInversionCofinanciadoresSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaPerfilesPreInversionCofinanciadores</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilPreInversionCofinanciadorResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: perfilPreInversionCofinanciadoresSOAP);

      if (perfilPreInversionCofinanciadorResp.statusCode == 200) {
        final perfilPreInversionCofinanciadorDoc =
            xml.XmlDocument.parse(perfilPreInversionCofinanciadorResp.body);

        final respuesta = perfilPreInversionCofinanciadorDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            perfilPreInversionCofinanciadorDoc
                .findAllElements('NewDataSet')
                .isNotEmpty) {
          final xmlString = perfilPreInversionCofinanciadorDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final perfilPreInversionCofinanciadoresRaw =
              decodedResp.entries.first.value['Table'];

          if (perfilPreInversionCofinanciadoresRaw is List) {
            return List.from(perfilPreInversionCofinanciadoresRaw)
                .map((e) => PerfilPreInversionCofinanciadorModel.fromJson(e))
                .toList();
          } else {
            return [
              PerfilPreInversionCofinanciadorModel.fromJson(
                  perfilPreInversionCofinanciadoresRaw)
            ];
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

  @override
  Future<List<PerfilPreInversionCofinanciadorEntity>>
      savePerfilesPreInversionesCofinanciadores(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorEntity>
              perfilesPreInversionesCofinanciadoresEntity) async {
    List<PerfilPreInversionCofinanciadorEntity>
        perfilesPreInversionesCofinanciadoresUpload = [];
    for (var perfilPreInversionCofinanciador
        in perfilesPreInversionesCofinanciadoresEntity) {
      final resp = await savePerfilPreInversionCofinanciador(
          usuario, perfilPreInversionCofinanciador);
      if (resp != null) {
        perfilesPreInversionesCofinanciadoresUpload.add(resp);
      }
    }
    return perfilesPreInversionesCofinanciadoresUpload;
  }

  Future<PerfilPreInversionCofinanciadorEntity?>
      savePerfilPreInversionCofinanciador(
          UsuarioEntity usuario,
          PerfilPreInversionCofinanciadorEntity
              perfilPreInversionCofinanciadorEntity) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final perfilPreInversionCofinanciadorSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionCofinanciador xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionCofinanciadorEntity.perfilPreInversionId}</PerfilPreInversionId>
            <CofinanciadorId>${perfilPreInversionCofinanciadorEntity.cofinanciadorId}</CofinanciadorId>
            <Monto>${perfilPreInversionCofinanciadorEntity.monto}</Monto>
            <Participacion>${perfilPreInversionCofinanciadorEntity.participacion}</Participacion>
            
          </objeto>
        </GuardarPerfilPreInversionCofinanciador>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilPreInversionCofinanciadorResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction":
                "${Constants.urlSOAP}/GuardarPerfilPreInversionCofinanciador"
          },
          body: perfilPreInversionCofinanciadorSOAP);

      if (perfilPreInversionCofinanciadorResp.statusCode == 200) {
        final perfilPreInversionCofinanciadorDoc =
            xml.XmlDocument.parse(perfilPreInversionCofinanciadorResp.body);

        final respuesta = perfilPreInversionCofinanciadorDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          return perfilPreInversionCofinanciadorEntity;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
