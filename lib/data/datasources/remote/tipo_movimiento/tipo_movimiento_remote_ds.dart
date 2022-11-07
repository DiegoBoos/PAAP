import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/tipo_movimiento_model.dart';
import '../../../utils.dart';

abstract class TipoMovimientoRemoteDataSource {
  Future<List<TipoMovimientoModel>> getTiposMovimientos(UsuarioEntity usuario);
}

class TipoMovimientoRemoteDataSourceImpl
    implements TipoMovimientoRemoteDataSource {
  final http.Client client;

  TipoMovimientoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoMovimientoModel>> getTiposMovimientos(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final tipomovimientoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaTiposMovimientos</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final tipomovimientoResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: tipomovimientoSOAP);

    if (tipomovimientoResp.statusCode == 200) {
      final tipomovimientoDoc = xml.XmlDocument.parse(tipomovimientoResp.body);

      final respuesta = tipomovimientoDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje =
          tipomovimientoDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = tipomovimientoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final tipomovimientosRaw = decodedResp.entries.first.value['Table'];
        final tipomovimientos = List.from(tipomovimientosRaw)
            .map((e) => TipoMovimientoModel.fromJson(e))
            .toList();

        return tipomovimientos;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
