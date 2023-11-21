import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_aliado_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/perfil_preinversion_aliado_model.dart';
import '../../utils.dart';

abstract class PerfilPreInversionAliadoRemoteDataSource {
  Future<List<PerfilPreInversionAliadoModel>> getPerfilPreInversionAliados(
      UsuarioEntity usuario);
  Future<List<PerfilPreInversionAliadoEntity>>
      savePerfilesPreInversionesAliados(
          UsuarioEntity usuario,
          List<PerfilPreInversionAliadoEntity>
              perfilesPreInversionesAliadosEntity);
}

class PerfilPreInversionAliadoRemoteDataSourceImpl
    implements PerfilPreInversionAliadoRemoteDataSource {
  final http.Client client;

  PerfilPreInversionAliadoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreInversionAliadoModel>> getPerfilPreInversionAliados(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilPreInversionAliadosSOAP =
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
            <string>TablaPerfilesPreInversionesAliados</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilPreInversionAliadoResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: perfilPreInversionAliadosSOAP);

      if (perfilPreInversionAliadoResp.statusCode != 200) {
        throw const ServerFailure(
            ['Error al obtener los aliados de perfil preinversión']);
      }

      final perfilPreInversionAliadoDoc =
          xml.XmlDocument.parse(perfilPreInversionAliadoResp.body);

      final respuesta = perfilPreInversionAliadoDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        if (perfilPreInversionAliadoDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = perfilPreInversionAliadoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilPreInversionAliadosRaw =
            decodedResp.entries.first.value['Table'];
        if (perfilPreInversionAliadosRaw is List) {
          return List.from(perfilPreInversionAliadosRaw)
              .map((e) => PerfilPreInversionAliadoModel.fromJson(e))
              .toList();
        } else {
          return [
            PerfilPreInversionAliadoModel.fromJson(perfilPreInversionAliadosRaw)
          ];
        }
      } else {
        throw const ServerFailure(
            ['Error al obtener los aliados de perfil preinversión']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<List<PerfilPreInversionAliadoEntity>>
      savePerfilesPreInversionesAliados(
          UsuarioEntity usuario,
          List<PerfilPreInversionAliadoEntity>
              perfilesPreInversionesAliadosEntity) async {
    List<PerfilPreInversionAliadoEntity> perfilesPreInversionesAliadosUpload =
        [];
    for (var perfilPreInversionAliado in perfilesPreInversionesAliadosEntity) {
      final resp =
          await savePerfilPreInversionAliado(usuario, perfilPreInversionAliado);
      if (resp != null) {
        perfilesPreInversionesAliadosUpload.add(resp);
      }
    }
    return perfilesPreInversionesAliadosUpload;
  }

  Future<PerfilPreInversionAliadoEntity?> savePerfilPreInversionAliado(
      UsuarioEntity usuario,
      PerfilPreInversionAliadoEntity perfilPreInversionAliadoEntity) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilPreInversionAliadoSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionAliado xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionAliadoEntity.perfilPreInversionId}</PerfilPreInversionId>
            <AliadoId>${perfilPreInversionAliadoEntity.aliadoId}</AliadoId>
            <ProductoId>${perfilPreInversionAliadoEntity.productoId}</ProductoId>
            <VolumenCompra>${perfilPreInversionAliadoEntity.volumenCompra}</VolumenCompra>
            <UnidadId>${perfilPreInversionAliadoEntity.unidadId}</UnidadId>
            <FrecuenciaId>${perfilPreInversionAliadoEntity.frecuenciaId}</FrecuenciaId>
            <PorcentajeCompra>${perfilPreInversionAliadoEntity.porcentajeCompra}</PorcentajeCompra>
            <SitioEntregaId>${perfilPreInversionAliadoEntity.sitioEntregaId}</SitioEntregaId>
          </objeto>
        </GuardarPerfilPreInversionAliado>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilPreInversionAliadoResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/GuardarPerfilPreInversionAliado"
          },
          body: perfilPreInversionAliadoSOAP);

      if (perfilPreInversionAliadoResp.statusCode != 200) {
        throw const ServerFailure(
            ['Error al guardar el aliado del perfil preinversión']);
      }

      final perfilPreInversionAliadoDoc =
          xml.XmlDocument.parse(perfilPreInversionAliadoResp.body);

      final respuesta = perfilPreInversionAliadoDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        return perfilPreInversionAliadoEntity;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
