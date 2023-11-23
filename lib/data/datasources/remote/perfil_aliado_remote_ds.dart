import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/perfil_aliado_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/perfil_aliado_model.dart';
import '../../utils.dart';

abstract class PerfilAliadoRemoteDataSource {
  Future<List<PerfilAliadoModel>> getPerfilAliados(UsuarioEntity usuario);
  Future<List<PerfilAliadoEntity>> savePerfilesAliados(
      UsuarioEntity usuario, List<PerfilAliadoEntity> perfilesAliadossEntity);
}

class PerfilAliadoRemoteDataSourceImpl implements PerfilAliadoRemoteDataSource {
  final http.Client client;

  PerfilAliadoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilAliadoModel>> getPerfilAliados(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilAliadosOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaPerfilesAliados</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilAliadoResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: perfilAliadosOAP);

      if (perfilAliadoResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los aliados']);
      }

      final perfilAliadoDoc = xml.XmlDocument.parse(perfilAliadoResp.body);

      final respuesta =
          perfilAliadoDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (perfilAliadoDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = perfilAliadoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilAliadosRaw = decodedResp.entries.first.value['Table'];

        if (perfilAliadosRaw is List) {
          return List.from(perfilAliadosRaw)
              .map((e) => PerfilAliadoModel.fromJson(e))
              .toList();
        } else {
          return [PerfilAliadoModel.fromJson(perfilAliadosRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener los aliados del perfil']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<List<PerfilAliadoEntity>> savePerfilesAliados(UsuarioEntity usuario,
      List<PerfilAliadoEntity> perfilesAliadosEntity) async {
    List<PerfilAliadoEntity> perfilesAliadosUpload = [];
    for (var perfilAliado in perfilesAliadosEntity) {
      final resp = await savePerfilAliado(usuario, perfilAliado);
      if (resp != null) {
        perfilesAliadosUpload.add(resp);
      }
    }
    return perfilesAliadosUpload;
  }

  Future<PerfilAliadoEntity?> savePerfilAliado(
      UsuarioEntity usuario, PerfilAliadoEntity perfilAliadoEntity) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilAliadosOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilAliado xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilId>${perfilAliadoEntity.perfilId}</PerfilId>
            <AliadoId>${perfilAliadoEntity.aliadoId}</AliadoId>
            <ProductoId>${perfilAliadoEntity.productoId}</ProductoId>
            <VolumenCompra>${perfilAliadoEntity.volumenCompra}</VolumenCompra>
            <UnidadId>${perfilAliadoEntity.unidadId}</UnidadId>
            <FrecuenciaId>${perfilAliadoEntity.frecuenciaId}</FrecuenciaId>
            <PorcentajeCompra>${perfilAliadoEntity.porcentajeCompra}</PorcentajeCompra>
            <SitioEntregaId>${perfilAliadoEntity.sitioEntregaId}</SitioEntregaId>
          </objeto>
        </GuardarPerfilAliado>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilAliadoResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/GuardarPerfilAliado"
          },
          body: perfilAliadosOAP);

      if (perfilAliadoResp.statusCode != 200) {
        throw const ServerFailure(['Error al guardar el aliado']);
      }

      final perfilAliadoDoc = xml.XmlDocument.parse(perfilAliadoResp.body);

      final respuesta =
          perfilAliadoDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        return perfilAliadoEntity;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
