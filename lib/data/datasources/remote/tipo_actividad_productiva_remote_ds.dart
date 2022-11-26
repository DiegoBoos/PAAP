import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';
import '../../models/tipo_actividad_productiva_model.dart';
import '../../utils.dart';

abstract class TipoActividadProductivaRemoteDataSource {
  Future<List<TipoActividadProductivaModel>> getTiposActividadesProductivas(
      UsuarioEntity usuario);
}

class TipoActividadProductivaRemoteDataSourceImpl
    implements TipoActividadProductivaRemoteDataSource {
  final http.Client client;

  TipoActividadProductivaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoActividadProductivaModel>> getTiposActividadesProductivas(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final tipoActividadProductivaSOAP =
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
            <string>TablaTiposActividadesProductivas</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final tipoActividadProductivaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: tipoActividadProductivaSOAP);

    if (tipoActividadProductivaResp.statusCode == 200) {
      final tipoActividadProductivaDoc =
          xml.XmlDocument.parse(tipoActividadProductivaResp.body);

      final respuesta = tipoActividadProductivaDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          tipoActividadProductivaDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = tipoActividadProductivaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tiposActividadesProductivasRaw =
            decodedResp.entries.first.value['Table'];

        if (tiposActividadesProductivasRaw is List) {
          return List.from(tiposActividadesProductivasRaw)
              .map((e) => TipoActividadProductivaModel.fromJson(e))
              .toList();
        } else {
          return [
            TipoActividadProductivaModel.fromJson(
                tiposActividadesProductivasRaw)
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
