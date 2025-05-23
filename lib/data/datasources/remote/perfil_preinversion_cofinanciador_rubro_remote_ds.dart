import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

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
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

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

      if (perfilPreInversionCofinanciadorRubroResp.statusCode != 200) {
        throw const ServerFailure(
            ['Error al obtener los rubros de los cofinanciadores']);
      }

      final perfilPreInversionCofinanciadorRubroDoc =
          xml.XmlDocument.parse(perfilPreInversionCofinanciadorRubroResp.body);

      final respuesta = perfilPreInversionCofinanciadorRubroDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        if (perfilPreInversionCofinanciadorRubroDoc
            .findAllElements('NewDataSet')
            .isEmpty) {
          return [];
        }

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
              .map((e) => PerfilPreInversionCofinanciadorRubroModel.fromJson(e))
              .toList();
        } else {
          return [
            PerfilPreInversionCofinanciadorRubroModel.fromJson(
                perfilPreInversionCofinanciadorRubrosRaw)
          ];
        }
      } else {
        throw const ServerFailure(
            ['Error al obtener los rubros de los cofinanciadores']);
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
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

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

      if (perfilPreInversionCofinanciadorRubroResp.statusCode != 200) {
        throw const ServerFailure(
            ['Error al guardar el rubro del cofinanciador']);
      }

      final perfilPreInversionCofinanciadorRubroDoc =
          xml.XmlDocument.parse(perfilPreInversionCofinanciadorRubroResp.body);

      final respuesta = perfilPreInversionCofinanciadorRubroDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        return perfilPreInversionCofinanciadorRubroEntity;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
