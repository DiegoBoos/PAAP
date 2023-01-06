import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/perfil_preinversion_cofinanciador_desembolso_model.dart';
import '../../utils.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsoRemoteDataSource {
  Future<List<PerfilPreInversionCofinanciadorDesembolsoModel>>
      getPerfilPreInversionCofinanciadorDesembolsos(UsuarioEntity usuario);
  Future<List<PerfilPreInversionCofinanciadorDesembolsoEntity>>
      savePerfilesPreInversionesCofinanciadoresDesembolsos(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              perfilesPreInversionesCofinanciadoresDesembolsosEntity);
}

class PerfilPreInversionCofinanciadorDesembolsoRemoteDataSourceImpl
    implements PerfilPreInversionCofinanciadorDesembolsoRemoteDataSource {
  final http.Client client;

  PerfilPreInversionCofinanciadorDesembolsoRemoteDataSourceImpl(
      {required this.client});

  @override
  Future<List<PerfilPreInversionCofinanciadorDesembolsoModel>>
      getPerfilPreInversionCofinanciadorDesembolsos(
          UsuarioEntity usuario) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final perfilPreInversionCofinanciadorDesembolsosSOAP =
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
            <string>TablaPerfilesPreInversionesCofinanciadoresDesembolsos</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilPreInversionCofinanciadorDesembolsoResp =
          await client.post(uri,
              headers: {
                "Content-Type": "text/xml; charset=utf-8",
                "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
              },
              body: perfilPreInversionCofinanciadorDesembolsosSOAP);

      if (perfilPreInversionCofinanciadorDesembolsoResp.statusCode == 200) {
        final perfilPreInversionCofinanciadorDesembolsoDoc =
            xml.XmlDocument.parse(
                perfilPreInversionCofinanciadorDesembolsoResp.body);

        final respuesta = perfilPreInversionCofinanciadorDesembolsoDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            perfilPreInversionCofinanciadorDesembolsoDoc
                .findAllElements('NewDataSet')
                .isNotEmpty) {
          final xmlString = perfilPreInversionCofinanciadorDesembolsoDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final perfilPreInversionCofinanciadorDesembolsosRaw =
              decodedResp.entries.first.value['Table'];

          if (perfilPreInversionCofinanciadorDesembolsosRaw is List) {
            return List.from(perfilPreInversionCofinanciadorDesembolsosRaw)
                .map((e) =>
                    PerfilPreInversionCofinanciadorDesembolsoModel.fromJson(e))
                .toList();
          } else {
            return [
              PerfilPreInversionCofinanciadorDesembolsoModel.fromJson(
                  perfilPreInversionCofinanciadorDesembolsosRaw)
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
  Future<List<PerfilPreInversionCofinanciadorDesembolsoEntity>>
      savePerfilesPreInversionesCofinanciadoresDesembolsos(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              perfilesPreInversionesCofinanciadoresDesembolsosEntity) async {
    List<PerfilPreInversionCofinanciadorDesembolsoEntity>
        perfilesPreInversionesCofinanciadoresDesembolsosUpload = [];
    for (var perfilPreInversionCofinanciadorDesembolso
        in perfilesPreInversionesCofinanciadoresDesembolsosEntity) {
      final resp = await savePerfilPreInversionCofinanciadorDesembolso(
          usuario, perfilPreInversionCofinanciadorDesembolso);
      if (resp != null) {
        perfilesPreInversionesCofinanciadoresDesembolsosUpload.add(resp);
      }
    }
    return perfilesPreInversionesCofinanciadoresDesembolsosUpload;
  }

  Future<PerfilPreInversionCofinanciadorDesembolsoEntity?>
      savePerfilPreInversionCofinanciadorDesembolso(
          UsuarioEntity usuario,
          PerfilPreInversionCofinanciadorDesembolsoEntity
              perfilPreInversionCofinanciadorDesembolsoEntity) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final perfilPreInversionCofinanciadorDesembolsoSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionCofinanciadorDesembolso xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <DesembolsoId>${perfilPreInversionCofinanciadorDesembolsoEntity.desembolsoId}</DesembolsoId>
            <PerfilPreInversionId>${perfilPreInversionCofinanciadorDesembolsoEntity.perfilPreInversionId}</PerfilPreInversionId>
            <CofinanciadorId>${perfilPreInversionCofinanciadorDesembolsoEntity.cofinanciadorId}</CofinanciadorId>
            <DesembolsoId>${perfilPreInversionCofinanciadorDesembolsoEntity.desembolsoId}</DesembolsoId>
            <Fecha>${perfilPreInversionCofinanciadorDesembolsoEntity.fecha}</Fecha>
          </objeto>
        </GuardarPerfilPreInversionCofinanciadorDesembolso>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilPreInversionCofinanciadorDesembolsoResp =
          await client.post(uri,
              headers: {
                "Content-Type": "text/xml; charset=utf-8",
                "SOAPAction":
                    "${Constants.urlSOAP}/GuardarPerfilPreInversionCofinanciadorDesembolso"
              },
              body: perfilPreInversionCofinanciadorDesembolsoSOAP);

      if (perfilPreInversionCofinanciadorDesembolsoResp.statusCode == 200) {
        final perfilPreInversionCofinanciadorDesembolsoDoc =
            xml.XmlDocument.parse(
                perfilPreInversionCofinanciadorDesembolsoResp.body);

        final respuesta = perfilPreInversionCofinanciadorDesembolsoDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          return perfilPreInversionCofinanciadorDesembolsoEntity;
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
