import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/beneficiario_alianza_model.dart';
import '../../../utils.dart';

abstract class BeneficiarioAlianzaRemoteDataSource {
  Future<List<BeneficiarioAlianzaModel>> getBeneficiariosAlianza(
      UsuarioEntity usuario);
}

class BeneficiarioAlianzaRemoteDataSourceImpl
    implements BeneficiarioAlianzaRemoteDataSource {
  final http.Client client;

  BeneficiarioAlianzaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BeneficiarioAlianzaModel>> getBeneficiariosAlianza(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final beneficiariosAlianzaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaAlianzasBeneficiarios</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final beneficiarioAlianzaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: beneficiariosAlianzaSOAP);

    if (beneficiarioAlianzaResp.statusCode == 200) {
      final beneficiarioAlianzaDoc =
          xml.XmlDocument.parse(beneficiarioAlianzaResp.body);

      final respuesta = beneficiarioAlianzaDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          beneficiarioAlianzaDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = beneficiarioAlianzaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final beneficiariosAlianzaRaw =
            decodedResp.entries.first.value['Table'];
        if (beneficiariosAlianzaRaw is List) {
          return List.from(beneficiariosAlianzaRaw)
              .map((e) => BeneficiarioAlianzaModel.fromJson(e))
              .toList();
        } else {
          return [BeneficiarioAlianzaModel.fromJson(beneficiariosAlianzaRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
