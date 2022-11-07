import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/tipo_tenencia_model.dart';
import '../../../utils.dart';

abstract class TipoTenenciaRemoteDataSource {
  Future<List<TipoTenenciaModel>> getTiposTenencias(UsuarioEntity usuario);
}

class TipoTenenciaRemoteDataSourceImpl implements TipoTenenciaRemoteDataSource {
  final http.Client client;

  TipoTenenciaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoTenenciaModel>> getTiposTenencias(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final tipotenenciaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposTenencias</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final tipotenenciaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: tipotenenciaSOAP);

    if (tipotenenciaResp.statusCode == 200) {
      final tipotenenciaDoc = xml.XmlDocument.parse(tipotenenciaResp.body);

      final respuesta =
          tipotenenciaDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          tipotenenciaDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = tipotenenciaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tipotenenciasRaw = decodedResp.entries.first.value['Table'];
        final tipotenencias = List.from(tipotenenciasRaw)
            .map((e) => TipoTenenciaModel.fromJson(e))
            .toList();

        return tipotenencias;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
