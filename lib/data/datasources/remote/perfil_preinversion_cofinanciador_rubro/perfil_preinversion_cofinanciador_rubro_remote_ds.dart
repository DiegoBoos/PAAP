import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/perfil_preinversion_cofinanciador_rubro_model.dart';
import '../../../utils.dart';

abstract class PerfilPreInversionCofinanciadorRubroRemoteDataSource {
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilPreInversionCofinanciadorRubros(UsuarioEntity usuario);
}

class PerfilPreInversionCofinanciadorRubroRemoteDataSourceImpl
    implements PerfilPreInversionCofinanciadorRubroRemoteDataSource {
  final http.Client client;

  PerfilPreInversionCofinanciadorRubroRemoteDataSourceImpl(
      {required this.client});

  @override
  Future<List<PerfilPreInversionCofinanciadorRubroModel>>
      getPerfilPreInversionCofinanciadorRubros(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilPreInversionCofinanciadorRubrosSOAP =
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
      final perfilPreInversionCofinanciadorRubroDoc =
          xml.XmlDocument.parse(perfilPreInversionCofinanciadorRubroResp.body);

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
              .map((e) => PerfilPreInversionCofinanciadorRubroModel.fromJson(e))
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
  }
}
