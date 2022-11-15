import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/perfil_preinversion_beneficiario_model.dart';
import '../../../utils.dart';

abstract class PerfilPreInversionBeneficiarioRemoteDataSource {
  Future<List<PerfilPreInversionBeneficiarioModel>>
      getPerfilPreInversionBeneficiarios(UsuarioEntity usuario);
}

class PerfilPreInversionBeneficiarioRemoteDataSourceImpl
    implements PerfilPreInversionBeneficiarioRemoteDataSource {
  final http.Client client;

  PerfilPreInversionBeneficiarioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreInversionBeneficiarioModel>>
      getPerfilPreInversionBeneficiarios(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilPreInversionBeneficiariosSOAP =
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
            <string>TablaPerfilesPreInversionesBeneficiarios</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final perfilPreInversionBeneficiarioResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilPreInversionBeneficiariosSOAP);

    if (perfilPreInversionBeneficiarioResp.statusCode == 200) {
      final perfilPreInversionBeneficiarioDoc =
          xml.XmlDocument.parse(perfilPreInversionBeneficiarioResp.body);

      final respuesta = perfilPreInversionBeneficiarioDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          perfilPreInversionBeneficiarioDoc
              .findAllElements('NewDataSet')
              .isNotEmpty) {
        final xmlString = perfilPreInversionBeneficiarioDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilPreInversionBeneficiariosRaw =
            decodedResp.entries.first.value['Table'];

        if (perfilPreInversionBeneficiariosRaw is List) {
          return List.from(perfilPreInversionBeneficiariosRaw)
              .map((e) => PerfilPreInversionBeneficiarioModel.fromJson(e))
              .toList();
        } else {
          return [
            PerfilPreInversionBeneficiarioModel.fromJson(
                perfilPreInversionBeneficiariosRaw)
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
