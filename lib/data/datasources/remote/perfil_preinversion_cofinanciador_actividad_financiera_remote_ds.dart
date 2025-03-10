import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/perfil_preinversion_cofinanciador_actividad_financiera_model.dart';
import '../../utils.dart';

abstract class PerfilPreInversionCofinanciadorActividadFinancieraRemoteDataSource {
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilPreInversionCofinanciadorActividadesFinancieras(
          UsuarioEntity usuario);
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>
      savePerfilesPreInversionesCofinanciadoresActividadesFinancieras(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilesPreInversionesCofinanciadoresActividadesFinancierasEntity);
}

class PerfilPreInversionCofinanciadorActividadFinancieraRemoteDataSourceImpl
    implements
        PerfilPreInversionCofinanciadorActividadFinancieraRemoteDataSource {
  final http.Client client;

  PerfilPreInversionCofinanciadorActividadFinancieraRemoteDataSourceImpl(
      {required this.client});

  @override
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilPreInversionCofinanciadorActividadesFinancieras(
          UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilPreInversionCofinanciadorActividadesFinancierasSOAP =
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
            <string>TablaPerfilesPreInversionesCofinanciadoresActividadesFinancieras</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilPreInversionCofinanciadorActividadFinancieraResp =
          await client.post(uri,
              headers: {
                "Content-Type": "text/xml; charset=utf-8",
                "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
              },
              body: perfilPreInversionCofinanciadorActividadesFinancierasSOAP);

      if (perfilPreInversionCofinanciadorActividadFinancieraResp.statusCode !=
          200) {
        throw const ServerFailure(
            ['Error al obtener las actividades financieras del cofinanciador']);
      }

      final perfilPreInversionCofinanciadorActividadFinancieraDoc =
          xml.XmlDocument.parse(
              perfilPreInversionCofinanciadorActividadFinancieraResp.body);

      final respuesta = perfilPreInversionCofinanciadorActividadFinancieraDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        if (perfilPreInversionCofinanciadorActividadFinancieraDoc
            .findAllElements('NewDataSet')
            .isEmpty) {
          return [];
        }

        final xmlString = perfilPreInversionCofinanciadorActividadFinancieraDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilPreInversionCofinanciadorActividadesFinancierasRaw =
            decodedResp.entries.first.value['Table'];

        if (perfilPreInversionCofinanciadorActividadesFinancierasRaw is List) {
          return List.from(
                  perfilPreInversionCofinanciadorActividadesFinancierasRaw)
              .map((e) =>
                  PerfilPreInversionCofinanciadorActividadFinancieraModel
                      .fromJson(e))
              .toList();
        } else {
          return [
            PerfilPreInversionCofinanciadorActividadFinancieraModel.fromJson(
                perfilPreInversionCofinanciadorActividadesFinancierasRaw)
          ];
        }
      } else {
        throw const ServerFailure(
            ['Error al obtener las actividades financieras del cofinanciador']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>
      savePerfilesPreInversionesCofinanciadoresActividadesFinancieras(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilesPreInversionesCofinanciadoresActividadesFinancierasEntity) async {
    List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
        perfilesPreInversionesCofinanciadoresActividadesFinancierasUpload = [];
    for (var perfilPreInversionCofinanciadorActividadFinanciera
        in perfilesPreInversionesCofinanciadoresActividadesFinancierasEntity) {
      final resp = await savePerfilPreInversionCofinanciadorActividadFinanciera(
          usuario, perfilPreInversionCofinanciadorActividadFinanciera);
      if (resp != null) {
        perfilesPreInversionesCofinanciadoresActividadesFinancierasUpload
            .add(resp);
      }
    }
    return perfilesPreInversionesCofinanciadoresActividadesFinancierasUpload;
  }

  Future<PerfilPreInversionCofinanciadorActividadFinancieraEntity?>
      savePerfilPreInversionCofinanciadorActividadFinanciera(
          UsuarioEntity usuario,
          PerfilPreInversionCofinanciadorActividadFinancieraEntity
              perfilPreInversionCofinanciadorActividadFinancieraEntity) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilPreInversionCofinanciadorActividadFinancieraSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionCofinanciadorActividadFinanciera xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <ActividadFinancieraId>${perfilPreInversionCofinanciadorActividadFinancieraEntity.actividadFinancieraId}</ActividadFinancieraId>
            <PerfilPreInversionId>${perfilPreInversionCofinanciadorActividadFinancieraEntity.perfilPreInversionId}</PerfilPreInversionId>
            <CofinanciadorId>${perfilPreInversionCofinanciadorActividadFinancieraEntity.cofinanciadorId}</CofinanciadorId>
            <DesembolsoId>${perfilPreInversionCofinanciadorActividadFinancieraEntity.desembolsoId}</DesembolsoId>
            <Valor>${perfilPreInversionCofinanciadorActividadFinancieraEntity.valor}</Valor>
          </objeto>
        </GuardarPerfilPreInversionCofinanciadorActividadFinanciera>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilPreInversionCofinanciadorActividadFinancieraResp =
          await client.post(uri,
              headers: {
                "Content-Type": "text/xml; charset=utf-8",
                "SOAPAction":
                    "${Constants.urlSOAP}/GuardarPerfilPreInversionCofinanciadorActividadFinanciera"
              },
              body: perfilPreInversionCofinanciadorActividadFinancieraSOAP);

      if (perfilPreInversionCofinanciadorActividadFinancieraResp.statusCode !=
          200) {
        throw const ServerFailure(
            ['Error al guardar la actividad financiera del cofinanciador']);
      }

      final perfilPreInversionCofinanciadorActividadFinancieraDoc =
          xml.XmlDocument.parse(
              perfilPreInversionCofinanciadorActividadFinancieraResp.body);

      final respuesta = perfilPreInversionCofinanciadorActividadFinancieraDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        return perfilPreInversionCofinanciadorActividadFinancieraEntity;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
