import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../models/menu_model.dart';
import '../../utils.dart';

abstract class MenuRemoteDataSource {
  Future<List<MenuModel>> getMenu(UsuarioEntity usuario);
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  final http.Client client;

  MenuRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MenuModel>> getMenu(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final menuSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaMenus</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final menuResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: menuSOAP);

      if (menuResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los menús']);
      }

      final menuDoc = xml.XmlDocument.parse(menuResp.body);

      final respuesta =
          menuDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (menuDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = menuDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final menusRaw = decodedResp.entries.first.value['Table'];

        if (menusRaw is List) {
          return List.from(menusRaw).map((e) => MenuModel.fromJson(e)).toList();
        } else {
          return [MenuModel.fromJson(menusRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener los menús']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
