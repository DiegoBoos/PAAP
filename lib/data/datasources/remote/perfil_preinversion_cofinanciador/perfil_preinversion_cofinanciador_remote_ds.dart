import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';
import '../../../models/perfil_preinversion_cofinanciador_model.dart';
import '../../../utils.dart';

abstract class PerfilPreInversionCofinanciadorRemoteDataSource {
  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilPreInversionCofinanciadores(UsuarioEntity usuario);
}

class PerfilPreInversionCofinanciadorRemoteDataSourceImpl
    implements PerfilPreInversionCofinanciadorRemoteDataSource {
  final http.Client client;

  PerfilPreInversionCofinanciadorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreInversionCofinanciadorModel>>
      getPerfilPreInversionCofinanciadores(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilPreInversionCofinanciadoresSOAP =
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
            <string>TablaPerfilesPreInversionCofinanciadores</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final perfilPreInversionCofinanciadorResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilPreInversionCofinanciadoresSOAP);

    if (perfilPreInversionCofinanciadorResp.statusCode == 200) {
      final perfilPreInversionCofinanciadorDoc =
          xml.XmlDocument.parse(perfilPreInversionCofinanciadorResp.body);

      final respuesta = perfilPreInversionCofinanciadorDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          perfilPreInversionCofinanciadorDoc
              .findAllElements('NewDataSet')
              .isNotEmpty) {
        final xmlString = perfilPreInversionCofinanciadorDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilPreInversionCofinanciadoresRaw =
            decodedResp.entries.first.value['Table'];

        if (perfilPreInversionCofinanciadoresRaw is List) {
          return List.from(perfilPreInversionCofinanciadoresRaw)
              .map((e) => PerfilPreInversionCofinanciadorModel.fromJson(e))
              .toList();
        } else {
          return [
            PerfilPreInversionCofinanciadorModel.fromJson(
                perfilPreInversionCofinanciadoresRaw)
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
