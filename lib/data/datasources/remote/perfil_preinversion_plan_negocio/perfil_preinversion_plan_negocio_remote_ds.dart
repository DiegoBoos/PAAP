import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/perfil_preinversion_plan_negocio_model.dart';
import '../../../utils.dart';

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
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilPreInversionPlanNegociosSOAP =
        '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
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
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilPreInversionPlanNegocioSOAP =
        '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionPlanNegocio xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
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
            <ProductoId>${perfilPreInversionPlanNegocioEntity.productoId}</ProductoId>
            <TipoCalidadId>${perfilPreInversionPlanNegocioEntity.tipoCalidadId}</TipoCalidadId>
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
        body: perfilPreInversionPlanNegocioSOAP);

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
  }
}
