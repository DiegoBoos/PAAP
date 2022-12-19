import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/departamento_model.dart';
import '../../models/municipio_model.dart';
import '../../utils.dart';

abstract class MunicipioRemoteDataSource {
  Future<List<MunicipioModel>> getMunicipios(UsuarioEntity usuario);
}

class MunicipioRemoteDataSourceImpl implements MunicipioRemoteDataSource {
  final http.Client client;

  MunicipioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MunicipioModel>> getMunicipios(UsuarioEntity usuario) async {
    final departamentos = await getDepartamentos(usuario);

    List<MunicipioModel> municipios = [];

    for (var departamento in departamentos) {
      final municipiosDepartamento =
          await getMunicipiosByDepartamento(usuario, departamento.id);
      municipios.addAll(municipiosDepartamento);
    }
    return municipios;
  }

  Future<List<MunicipioModel>> getMunicipiosByDepartamento(
      UsuarioEntity usuario, String departamentoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final municipioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaMunicipios</string>       
            <string>$departamentoId</string>       
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final municipioResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: municipioSOAP);

      if (municipioResp.statusCode == 200) {
        final municipioDoc = xml.XmlDocument.parse(municipioResp.body);

        final respuesta =
            municipioDoc.findAllElements('respuesta').map((e) => e.text).first;

        if (respuesta == 'true' &&
            municipioDoc.findAllElements('NewDataSet').isNotEmpty) {
          final xmlString = municipioDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final municipiosRaw = decodedResp.entries.first.value['Table'];

          if (municipiosRaw is List) {
            return List.from(municipiosRaw)
                .map((e) => MunicipioModel.fromJson(e))
                .toList();
          } else {
            return [MunicipioModel.fromJson(municipiosRaw)];
          }
        } else {
          return [];
        }
      } else {
        throw ServerException();
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<List<DepartamentoModel>> getDepartamentos(
      UsuarioEntity usuario) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final departamentoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaDepartamentos</string>       
            <string>169</string>       
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final departamentoResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: departamentoSOAP);

      if (departamentoResp.statusCode == 200) {
        final departamentoDoc = xml.XmlDocument.parse(departamentoResp.body);

        final respuesta = departamentoDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            departamentoDoc.findAllElements('NewDataSet').isNotEmpty) {
          final xmlString = departamentoDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final departamentosRaw = decodedResp.entries.first.value['Table'];

          if (departamentosRaw is List) {
            return List.from(departamentosRaw)
                .map((e) => DepartamentoModel.fromJson(e))
                .toList();
          } else {
            return [DepartamentoModel.fromJson(departamentosRaw)];
          }
        } else {
          return [];
        }
      } else {
        throw ServerException();
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
