import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/consultor_model.dart';
import '../../../utils.dart';

abstract class ConsultorRemoteDataSource {
  Future<List<ConsultorModel>> getConsultores(UsuarioEntity usuario);
}

class ConsultorRemoteDataSourceImpl implements ConsultorRemoteDataSource {
  final http.Client client;

  ConsultorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ConsultorModel>> getConsultores(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final consultorSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaConsultores</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final consultorResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: consultorSOAP);

    if (consultorResp.statusCode == 200) {
      final consultorDoc = xml.XmlDocument.parse(consultorResp.body);

      final respuesta =
          consultorDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          consultorDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = consultorDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final consultoresRaw = decodedResp.entries.first.value['Table'];
        final consultores = List.from(consultoresRaw)
            .map((e) => ConsultorModel.fromJson(e))
            .toList();

        return consultores;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
