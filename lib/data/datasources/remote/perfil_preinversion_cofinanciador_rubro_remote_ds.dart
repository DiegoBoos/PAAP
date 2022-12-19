import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/perfil_preinversion_cofinanciador_rubro_model.dart';
import '../../utils.dart';

abstract class PerfilPreInversionCofinanciadorRubroRemoteDataSource {
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilPreInversionCofinanciadorRubros(UsuarioEntity usuario);
  Future<List<PerfilPreInversionCofinanciadorRubroEntity>>
      savePerfilesPreInversionesCofinanciadoresRubros(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorRubroEntity>
              perfilesPreInversionesCofinanciadoresRubrosEntity);
}

class PerfilPreInversionCofinanciadorRubroRemoteDataSourceImpl
    implements PerfilPreInversionCofinanciadorRubroRemoteDataSource {
  final http.Client client;

  PerfilPreInversionCofinanciadorRubroRemoteDataSourceImpl(
      {required this.client});

  @override
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilPreInversionCofinanciadorRubros(UsuarioEntity usuario) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final perfilPreInversionCofinanciadorRubrosSOAP =
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
            <string>TablaPerfilesPreInversionesCofinanciadoresRubros</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilPreInversionCofinanciadorRubroResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: perfilPreInversionCofinanciadorRubrosSOAP);

      if (perfilPreInversionCofinanciadorRubroResp.statusCode == 200) {
        final perfilPreInversionCofinanciadorRubroDoc = xml.XmlDocument.parse(
            perfilPreInversionCofinanciadorRubroResp.body);

        final respuesta = perfilPreInversionCofinanciadorRubroDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            perfilPreInversionCofinanciadorRubroDoc
                .findAllElements('NewDataSet')
                .isNotEmpty) {
          final xmlString = perfilPreInversionCofinanciadorRubroDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final perfilPreInversionCofinanciadorRubrosRaw =
              decodedResp.entries.first.value['Table'];

          if (perfilPreInversionCofinanciadorRubrosRaw is List) {
            return List.from(perfilPreInversionCofinanciadorRubrosRaw)
                .map((e) =>
                    PerfilPreInversionCofinanciadorRubroModel.fromJson(e))
                .toList();
          } else {
            return [
              PerfilPreInversionCofinanciadorRubroModel.fromJson(
                  perfilPreInversionCofinanciadorRubrosRaw)
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
  Future<List<PerfilPreInversionCofinanciadorRubroEntity>>
      savePerfilesPreInversionesCofinanciadoresRubros(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorRubroEntity>
              perfilesPreInversionesCofinanciadoresRubrosEntity) async {
    List<PerfilPreInversionCofinanciadorRubroEntity>
        perfilesPreInversionesCofinanciadoresRubrosUpload = [];
    for (var perfilPreInversionCofinanciadorRubro
        in perfilesPreInversionesCofinanciadoresRubrosEntity) {
      final resp = await savePerfilPreInversionCofinanciadorRubro(
          usuario, perfilPreInversionCofinanciadorRubro);
      if (resp != null) {
        perfilesPreInversionesCofinanciadoresRubrosUpload.add(resp);
      }
    }
    return perfilesPreInversionesCofinanciadoresRubrosUpload;
  }

  Future<PerfilPreInversionCofinanciadorRubroEntity?>
      savePerfilPreInversionCofinanciadorRubro(
          UsuarioEntity usuario,
          PerfilPreInversionCofinanciadorRubroEntity
              perfilPreInversionCofinanciadorRubroEntity) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final perfilPreInversionCofinanciadorRubroSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionCofinanciadorRubro xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionCofinanciadorRubroEntity.perfilPreInversionId}</PerfilPreInversionId>
            <CofinanciadorId>${perfilPreInversionCofinanciadorRubroEntity.cofinanciadorId}</CofinanciadorId>
            <DesembolsoId>${perfilPreInversionCofinanciadorRubroEntity.desembolsoId}</DesembolsoId>
            <ActividadFinancieraId>${perfilPreInversionCofinanciadorRubroEntity.actividadFinancieraId}</ActividadFinancieraId>
            <RubroId>${perfilPreInversionCofinanciadorRubroEntity.rubroId}</RubroId>
            <Valor>${perfilPreInversionCofinanciadorRubroEntity.valor}</Valor>
            
          </objeto>
        </GuardarPerfilPreInversionCofinanciadorRubro>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilPreInversionCofinanciadorRubroResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction":
                "${Constants.urlSOAP}/GuardarPerfilPreInversionCofinanciadorRubro"
          },
          body: perfilPreInversionCofinanciadorRubroSOAP);

      if (perfilPreInversionCofinanciadorRubroResp.statusCode == 200) {
        final perfilPreInversionCofinanciadorRubroDoc = xml.XmlDocument.parse(
            perfilPreInversionCofinanciadorRubroResp.body);

        final respuesta = perfilPreInversionCofinanciadorRubroDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          return perfilPreInversionCofinanciadorRubroEntity;
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
