import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/tipo_entidad_model.dart';
import '../../../utils.dart';

abstract class TipoEntidadRemoteDataSource {
  Future<List<TipoEntidadModel>> getTiposEntidades(UsuarioEntity usuario);
}

class TipoEntidadRemoteDataSourceImpl implements TipoEntidadRemoteDataSource {
  final http.Client client;

  TipoEntidadRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoEntidadModel>> getTiposEntidades(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final tipoEntidadSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposEntidades</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final tipoEntidadResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: tipoEntidadSOAP);

    if (tipoEntidadResp.statusCode == 200) {
      final tipoEntidadDoc = xml.XmlDocument.parse(tipoEntidadResp.body);

      final respuesta =
          tipoEntidadDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          tipoEntidadDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = tipoEntidadDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tiposEntidadesRaw = decodedResp.entries.first.value['Table'];
        final tiposEntidades = List.from(tiposEntidadesRaw)
            .map((e) => TipoEntidadModel.fromJson(e))
            .toList();

        return tiposEntidades;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
