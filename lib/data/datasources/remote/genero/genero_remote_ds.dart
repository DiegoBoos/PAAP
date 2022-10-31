import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/genero_model.dart';
import '../../../utils.dart';

abstract class GeneroRemoteDataSource {
  Future<List<GeneroModel>> getGeneros(UsuarioEntity usuario);
}

class GeneroRemoteDataSourceImpl implements GeneroRemoteDataSource {
  final http.Client client;

  GeneroRemoteDataSourceImpl({required this.client});

  @override
  Future<List<GeneroModel>> getGeneros(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final generoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaGeneros</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final generoResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: generoSOAP);

    if (generoResp.statusCode == 200) {
      final generoDoc = xml.XmlDocument.parse(generoResp.body);

      final respuesta =
          generoDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          generoDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = generoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final generosRaw = decodedResp.entries.first.value['Table'];
        final generos =
            List.from(generosRaw).map((e) => GeneroModel.fromJson(e)).toList();

        return generos;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
