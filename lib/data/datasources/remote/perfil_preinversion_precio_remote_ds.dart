import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/perfil_preinversion_precio_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/perfil_preinversion_precio_model.dart';
import '../../utils.dart';

abstract class PerfilPreInversionPrecioRemoteDataSource {
  Future<List<PerfilPreInversionPrecioModel>> getPerfilPreInversionPrecios(
      UsuarioEntity usuario);

  Future<List<PerfilPreInversionPrecioEntity>>
      savePerfilesPreInversionesPrecios(
          UsuarioEntity usuario,
          List<PerfilPreInversionPrecioEntity>
              perfilesPreInversionesPreciosEntity);
}

class PerfilPreInversionPrecioRemoteDataSourceImpl
    implements PerfilPreInversionPrecioRemoteDataSource {
  final http.Client client;

  PerfilPreInversionPrecioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreInversionPrecioModel>> getPerfilPreInversionPrecios(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilPreInversionPreciosSOAP =
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
            <string>TablaPerfilesPreInversionesPrecios</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilPreInversionPrecioResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: perfilPreInversionPreciosSOAP);

      if (perfilPreInversionPrecioResp.statusCode == 200) {
        final perfilPreInversionPrecioDoc =
            xml.XmlDocument.parse(perfilPreInversionPrecioResp.body);

        final respuesta = perfilPreInversionPrecioDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            perfilPreInversionPrecioDoc
                .findAllElements('NewDataSet')
                .isNotEmpty) {
          final xmlString = perfilPreInversionPrecioDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final perfilPreInversionPreciosRaw =
              decodedResp.entries.first.value['Table'];

          if (perfilPreInversionPreciosRaw is List) {
            return List.from(perfilPreInversionPreciosRaw)
                .map((e) => PerfilPreInversionPrecioModel.fromJson(e))
                .toList();
          } else {
            return [
              PerfilPreInversionPrecioModel.fromJson(
                  perfilPreInversionPreciosRaw)
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
  Future<List<PerfilPreInversionPrecioEntity>>
      savePerfilesPreInversionesPrecios(
          UsuarioEntity usuario,
          List<PerfilPreInversionPrecioEntity>
              perfilesPreInversionesPreciosEntity) async {
    List<PerfilPreInversionPrecioEntity> perfilesPreInversionesPreciosUpload =
        [];
    for (var perfilPreInversionPrecio in perfilesPreInversionesPreciosEntity) {
      final resp =
          await savePerfilPreInversionPrecio(usuario, perfilPreInversionPrecio);
      if (resp != null) {
        perfilesPreInversionesPreciosUpload.add(resp);
      }
    }
    return perfilesPreInversionesPreciosUpload;
  }

  Future<PerfilPreInversionPrecioEntity?> savePerfilPreInversionPrecio(
      UsuarioEntity usuario,
      PerfilPreInversionPrecioEntity perfilPreInversionPrecioEntity) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilPreInversionPrecioSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionPrecio xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionPrecioEntity.perfilPreInversionId}</PerfilPreInversionId>
            <ProductoId>${perfilPreInversionPrecioEntity.productoId}</ProductoId>
            <TipoCalidadId>${perfilPreInversionPrecioEntity.tipoCalidadId}</TipoCalidadId>
            <Precio>${perfilPreInversionPrecioEntity.precio}</Precio>
            <UnidadId>${perfilPreInversionPrecioEntity.unidadId}</UnidadId>
          </objeto>
        </GuardarPerfilPreInversionPrecio>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilPreInversionPrecioResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/GuardarPerfilPreInversionPrecio"
          },
          body: perfilPreInversionPrecioSOAP);

      if (perfilPreInversionPrecioResp.statusCode == 200) {
        final perfilPreInversionPrecioDoc =
            xml.XmlDocument.parse(perfilPreInversionPrecioResp.body);

        final respuesta = perfilPreInversionPrecioDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          return perfilPreInversionPrecioEntity;
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

  Future<PerfilPreInversionPrecioEntity?> deletePerfilPreInversionPrecio(
      UsuarioEntity usuario,
      PerfilPreInversionPrecioEntity perfilPreInversionPrecioEntity) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilPreInversionPrecioSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <BorrarPerfilPreInversionPrecio xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionPrecioEntity.perfilPreInversionId}</PerfilPreInversionId>
            <PrecioId>${perfilPreInversionPrecioEntity.productoId}</PrecioId>
            <TipoCalidadId>${perfilPreInversionPrecioEntity.tipoCalidadId}</TipoCalidadId>            
          </objeto>
        </BorrarPerfilPreInversionPrecio>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilPreInversionPrecioResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/BorrarPerfilPreInversionPrecio"
          },
          body: perfilPreInversionPrecioSOAP);

      if (perfilPreInversionPrecioResp.statusCode == 200) {
        final perfilPreInversionPrecioDoc =
            xml.XmlDocument.parse(perfilPreInversionPrecioResp.body);

        final respuesta = perfilPreInversionPrecioDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          return perfilPreInversionPrecioEntity;
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
