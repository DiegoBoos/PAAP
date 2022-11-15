import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/perfil_preinversion_cofinanciador_desembolso_model.dart';
import '../../../utils.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsoRemoteDataSource {
  Future<List<PerfilPreInversionCofinanciadorDesembolsoModel>>
      getPerfilPreInversionCofinanciadorDesembolsos(UsuarioEntity usuario);
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
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilPreInversionCofinanciadorDesembolsosSOAP =
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
            <string>TablaPerfilesPreInversionesCofinanciadoresDesembolsos</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final perfilPreInversionCofinanciadorDesembolsoResp = await client.post(uri,
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
  }
}
