import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

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
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

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

      if (beneficioResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los beneficios']);
      }

      final beneficioDoc = xml.XmlDocument.parse(beneficioResp.body);

      final respuesta =
          beneficioDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (beneficioDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

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
        throw const ServerFailure(['Error al obtener los beneficios']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
