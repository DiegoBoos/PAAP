import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/perfil_preinversion_cofinanciador_actividad_financiera_model.dart';
import '../../../utils.dart';

abstract class PerfilPreInversionCofinanciadorActividadFinancieraRemoteDataSource {
  Future<List<PerfilPreInversionCofinanciadorActividadFinancieraModel>>
      getPerfilPreInversionCofinanciadorActividadesFinancieras(
          UsuarioEntity usuario);
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
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilPreInversionCofinanciadorActividadesFinancierasSOAP =
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

    if (perfilPreInversionCofinanciadorActividadFinancieraResp.statusCode ==
        200) {
      final perfilPreInversionCofinanciadorActividadFinancieraDoc =
          xml.XmlDocument.parse(
              perfilPreInversionCofinanciadorActividadFinancieraResp.body);

      final respuesta = perfilPreInversionCofinanciadorActividadFinancieraDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          perfilPreInversionCofinanciadorActividadFinancieraDoc
              .findAllElements('NewDataSet')
              .isNotEmpty) {
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
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
