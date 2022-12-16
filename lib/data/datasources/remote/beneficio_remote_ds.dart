import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/beneficio_model.dart';
import '../../utils.dart';

abstract class BeneficioRemoteDataSource {
  Future<List<BeneficioModel>> getBeneficios(UsuarioEntity usuario);
}

class BeneficioRemoteDataSourceImpl implements BeneficioRemoteDataSource {
  final http.Client client;

  BeneficioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BeneficioModel>> getBeneficios(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final beneficioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaBeneficios</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final beneficioResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: beneficioSOAP);

    if (beneficioResp.statusCode == 200) {
      final beneficioDoc = xml.XmlDocument.parse(beneficioResp.body);

      final respuesta =
          beneficioDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          beneficioDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = beneficioDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final beneficiosRaw = decodedResp.entries.first.value['Table'];

        if (beneficiosRaw is List) {
          return List.from(beneficiosRaw)
              .map((e) => BeneficioModel.fromJson(e))
              .toList();
        } else {
          return [BeneficioModel.fromJson(beneficiosRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
