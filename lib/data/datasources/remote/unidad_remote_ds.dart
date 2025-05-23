import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/unidad_model.dart';
import '../../utils.dart';

abstract class UnidadRemoteDataSource {
  Future<List<UnidadModel>> getUnidades(UsuarioEntity usuario);
}

class UnidadRemoteDataSourceImpl implements UnidadRemoteDataSource {
  final http.Client client;

  UnidadRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UnidadModel>> getUnidades(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final unidadSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaUnidades</string>        
            <string>1</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final unidadResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: unidadSOAP);

      if (unidadResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener las unidades']);
      }

      final unidadDoc = xml.XmlDocument.parse(unidadResp.body);

      final respuesta =
          unidadDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (unidadDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = unidadDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final unidadesRaw = decodedResp.entries.first.value['Table'];

        if (unidadesRaw is List) {
          return List.from(unidadesRaw)
              .map((e) => UnidadModel.fromJson(e))
              .toList();
        } else {
          return [UnidadModel.fromJson(unidadesRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener las unidades']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
