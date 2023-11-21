import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/criterio_model.dart';
import '../../utils.dart';

abstract class CriterioRemoteDataSource {
  Future<List<CriterioModel>> getCriterios(UsuarioEntity usuario);
}

class CriterioRemoteDataSourceImpl implements CriterioRemoteDataSource {
  final http.Client client;

  CriterioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CriterioModel>> getCriterios(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final criterioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaCriterios</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final criterioResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: criterioSOAP);

      if (criterioResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los criterios']);
      }

      final criterioDoc = xml.XmlDocument.parse(criterioResp.body);

      final respuesta =
          criterioDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (criterioDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = criterioDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final criteriosRaw = decodedResp.entries.first.value['Table'];
        if (criteriosRaw is List) {
          return List.from(criteriosRaw)
              .map((e) => CriterioModel.fromJson(e))
              .toList();
        } else {
          return [CriterioModel.fromJson(criteriosRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener los criterios']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
