import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/beneficiario_preinversion_model.dart';
import '../../../utils.dart';

abstract class BeneficiarioPreinversionRemoteDataSource {
  Future<List<BeneficiarioPreinversionModel>> getBeneficiariosPreinversiones(
      UsuarioEntity usuario);
}

class BeneficiarioPreinversionRemoteDataSourceImpl
    implements BeneficiarioPreinversionRemoteDataSource {
  final http.Client client;

  BeneficiarioPreinversionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BeneficiarioPreinversionModel>> getBeneficiariosPreinversiones(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final beneficiariosPreinversionesOAP =
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
            <string>TablaBeneficiariosPreinversiones</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final beneficiarioPreinversionResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: beneficiariosPreinversionesOAP);

    if (beneficiarioPreinversionResp.statusCode == 200) {
      final beneficiarioPreinversionDoc =
          xml.XmlDocument.parse(beneficiarioPreinversionResp.body);

      final respuesta = beneficiarioPreinversionDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = beneficiarioPreinversionDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        final xmlString = beneficiarioPreinversionDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final beneficiariosPreinversionesRaw =
            decodedResp.entries.first.value['Table'];
        final beneficiariosPreinversiones =
            List.from(beneficiariosPreinversionesRaw)
                .map((e) => BeneficiarioPreinversionModel.fromJson(e))
                .toList();

        return beneficiariosPreinversiones;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
