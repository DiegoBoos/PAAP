import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/perfil_preinversion_plan_negocio_model.dart';
import '../../utils.dart';

abstract class PerfilPreInversionPlanNegocioRemoteDataSource {
  Future<List<PerfilPreInversionPlanNegocioModel>>
      getPerfilPreInversionPlanNegocios(UsuarioEntity usuario);

  Future<List<PerfilPreInversionPlanNegocioEntity>>
      savePerfilesPreInversionesPlanNegocios(
          UsuarioEntity usuario,
          List<PerfilPreInversionPlanNegocioEntity>
              perfilesPreInversionesPlanNegociosEntity);
}

class PerfilPreInversionPlanNegocioRemoteDataSourceImpl
    implements PerfilPreInversionPlanNegocioRemoteDataSource {
  final http.Client client;

  PerfilPreInversionPlanNegocioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreInversionPlanNegocioModel>>
      getPerfilPreInversionPlanNegocios(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final perfilPreInversionPlanNegociosSOAP =
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
            <string>TablaPerfilesPreInversionesPlanNegocios</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilPreInversionPlanNegocioResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: perfilPreInversionPlanNegociosSOAP);

      if (perfilPreInversionPlanNegocioResp.statusCode == 200) {
        final perfilPreInversionPlanNegocioDoc =
            xml.XmlDocument.parse(perfilPreInversionPlanNegocioResp.body);

        final respuesta = perfilPreInversionPlanNegocioDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            perfilPreInversionPlanNegocioDoc
                .findAllElements('NewDataSet')
                .isNotEmpty) {
          final xmlString = perfilPreInversionPlanNegocioDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final perfilPreInversionPlanNegociosRaw =
              decodedResp.entries.first.value['Table'];

          if (perfilPreInversionPlanNegociosRaw is List) {
            return List.from(perfilPreInversionPlanNegociosRaw)
                .map((e) => PerfilPreInversionPlanNegocioModel.fromJson(e))
                .toList();
          } else {
            return [
              PerfilPreInversionPlanNegocioModel.fromJson(
                  perfilPreInversionPlanNegociosRaw)
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
  Future<List<PerfilPreInversionPlanNegocioEntity>>
      savePerfilesPreInversionesPlanNegocios(
          UsuarioEntity usuario,
          List<PerfilPreInversionPlanNegocioEntity>
              perfilesPreInversionesPlanNegociosEntity) async {
    List<PerfilPreInversionPlanNegocioEntity>
        perfilesPreInversionesPlanNegociosUpload = [];
    for (var perfilPreInversionPlanNegocio
        in perfilesPreInversionesPlanNegociosEntity) {
      final resp = await savePerfilPreInversionPlanNegocio(
          usuario, perfilPreInversionPlanNegocio);
      if (resp != null) {
        perfilesPreInversionesPlanNegociosUpload.add(resp);
      }
    }
    return perfilesPreInversionesPlanNegociosUpload;
  }

  Future<PerfilPreInversionPlanNegocioEntity?>
      savePerfilPreInversionPlanNegocio(
          UsuarioEntity usuario,
          PerfilPreInversionPlanNegocioEntity
              perfilPreInversionPlanNegocioEntity) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      String ingresosElements = '';

      if (perfilPreInversionPlanNegocioEntity.productoId != '') {
        ingresosElements = '''  
        <ProductoId>${perfilPreInversionPlanNegocioEntity.productoId}</ProductoId>
        <TipoCalidadId>${perfilPreInversionPlanNegocioEntity.tipoCalidadId}</TipoCalidadId>
      ''';
      }

      final perfilPreInversionPlanNegociosOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionPlanNegocio xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionPlanNegocioEntity.perfilPreInversionId}</PerfilPreInversionId>
            <RubroId>${perfilPreInversionPlanNegocioEntity.rubroId}</RubroId>
            <Year>${perfilPreInversionPlanNegocioEntity.year}</Year>
            <Valor>${perfilPreInversionPlanNegocioEntity.valor}</Valor>
            <Cantidad>${perfilPreInversionPlanNegocioEntity.cantidad}</Cantidad>
            <UnidadId>${perfilPreInversionPlanNegocioEntity.unidadId}</UnidadId>
            $ingresosElements
          </objeto>
        </GuardarPerfilPreInversionPlanNegocio>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilPreInversionPlanNegocioResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction":
                "${Constants.urlSOAP}/GuardarPerfilPreInversionPlanNegocio"
          },
          body: perfilPreInversionPlanNegociosOAP);

      if (perfilPreInversionPlanNegocioResp.statusCode == 200) {
        final perfilPreInversionPlanNegocioDoc =
            xml.XmlDocument.parse(perfilPreInversionPlanNegocioResp.body);

        final respuesta = perfilPreInversionPlanNegocioDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          return perfilPreInversionPlanNegocioEntity;
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
