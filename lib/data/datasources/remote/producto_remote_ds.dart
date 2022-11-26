import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/producto_model.dart';
import '../../utils.dart';

abstract class ProductoRemoteDataSource {
  Future<List<ProductoModel>> getProductos(UsuarioEntity usuario);
}

class ProductoRemoteDataSourceImpl implements ProductoRemoteDataSource {
  final http.Client client;

  ProductoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductoModel>> getProductos(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final productoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaProductos</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final productoResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: productoSOAP);

    if (productoResp.statusCode == 200) {
      final productoDoc = xml.XmlDocument.parse(productoResp.body);

      final respuesta =
          productoDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          productoDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = productoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final productosRaw = decodedResp.entries.first.value['Table'];

        if (productosRaw is List) {
          return List.from(productosRaw)
              .map((e) => ProductoModel.fromJson(e))
              .toList();
        } else {
          return [ProductoModel.fromJson(productosRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
