import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/beneficiario_model.dart';
import '../../../utils.dart';

abstract class BeneficiarioRemoteDataSource {
  Future<List<BeneficiarioModel>> getBeneficiarios(UsuarioEntity usuario);
}

class BeneficiarioRemoteDataSourceImpl implements BeneficiarioRemoteDataSource {
  final http.Client client;

  BeneficiarioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BeneficiarioModel>> getBeneficiarios(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final beneficiarioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaBeneficiarios</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final beneficiarioResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: beneficiarioSOAP);

    if (beneficiarioResp.statusCode == 200) {
      final beneficiarioDoc = xml.XmlDocument.parse(beneficiarioResp.body);

      final respuesta =
          beneficiarioDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          beneficiarioDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = beneficiarioDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final beneficiariosRaw = decodedResp.entries.first.value['Table'];

        if (beneficiariosRaw is List) {
          return List.from(beneficiariosRaw)
              .map((e) => BeneficiarioModel.fromJson(e))
              .toList();
        } else {
          return [BeneficiarioModel.fromJson(beneficiariosRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
