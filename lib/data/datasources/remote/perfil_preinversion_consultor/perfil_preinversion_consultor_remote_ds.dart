import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';
import '../../../models/perfil_preinversion_consultor_model.dart';
import '../../../utils.dart';

abstract class PerfilPreInversionConsultorRemoteDataSource {
  Future<List<PerfilPreInversionConsultorModel>>
      getPerfilPreInversionConsultores(UsuarioEntity usuario);
}

class PerfilPreInversionConsultorRemoteDataSourceImpl
    implements PerfilPreInversionConsultorRemoteDataSource {
  final http.Client client;

  PerfilPreInversionConsultorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreInversionConsultorModel>>
      getPerfilPreInversionConsultores(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilPreInversionConsultoresSOAP =
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
            <string>TablaPerfilesPreInversionesConsultores</string>      
            <string>1</string>
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final perfilPreInversionConsultorResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilPreInversionConsultoresSOAP);

    if (perfilPreInversionConsultorResp.statusCode == 200) {
      final perfilPreInversionConsultorDoc =
          xml.XmlDocument.parse(perfilPreInversionConsultorResp.body);

      final respuesta = perfilPreInversionConsultorDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          perfilPreInversionConsultorDoc
              .findAllElements('NewDataSet')
              .isNotEmpty) {
        final xmlString = perfilPreInversionConsultorDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilPreInversionConsultoresRaw =
            decodedResp.entries.first.value['Table'];

        if (perfilPreInversionConsultoresRaw is List) {
          return List.from(perfilPreInversionConsultoresRaw)
              .map((e) => PerfilPreInversionConsultorModel.fromJson(e))
              .toList();
        } else {
          return [
            PerfilPreInversionConsultorModel.fromJson(
                perfilPreInversionConsultoresRaw)
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
