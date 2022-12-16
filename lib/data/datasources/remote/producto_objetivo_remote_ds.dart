import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/Producto_objetivo_model.dart';
import '../../utils.dart';

abstract class ProductoObjetivoRemoteDataSource {
  Future<List<ProductoObjetivoModel>> getProductosObjetivos(
      UsuarioEntity usuario);
}

class ProductoObjetivoRemoteDataSourceImpl
    implements ProductoObjetivoRemoteDataSource {
  final http.Client client;

  ProductoObjetivoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductoObjetivoModel>> getProductosObjetivos(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final productoObjetivoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Nombre>${usuario.nombre}</Nombre>
            <Apellido>${usuario.apellido}</Apellido>
            <Direccion>${usuario.direccion}</Direccion>
            <TelefonoFijo>${usuario.telefonoFijo}</TelefonoFijo>
            <TelefonoMovil>${usuario.telefonoMovil}</TelefonoMovil>
            <Correo>${usuario.correo}</Correo>
            <Contrasena>${usuario.contrasena}</Contrasena>
            <FechaActivacion>${usuario.fechaActivacion}</FechaActivacion>
            <FechaDesactivacion>${usuario.fechaDesactivacion}</FechaDesactivacion>
            <FechaCambio>${usuario.fechaCambio}</FechaCambio>
            <Activo>${usuario.activo}</Activo>
          </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaProductosObjetivos</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final productoObjetivoResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: productoObjetivoSOAP);

    if (productoObjetivoResp.statusCode == 200) {
      final productoObjetivoDoc =
          xml.XmlDocument.parse(productoObjetivoResp.body);

      final respuesta = productoObjetivoDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          productoObjetivoDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = productoObjetivoDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final productosObjetivosRaw = decodedResp.entries.first.value['Table'];

        if (productosObjetivosRaw is List) {
          return List.from(productosObjetivosRaw)
              .map((e) => ProductoObjetivoModel.fromJson(e))
              .toList();
        } else {
          return [ProductoObjetivoModel.fromJson(productosObjetivosRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }
}
