import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';

import '../../models/departamento_model.dart';
import '../../models/municipio_model.dart';
import '../../models/vereda_model.dart';
import '../../utils.dart';

abstract class VeredaRemoteDataSource {
  Future<List<VeredaModel>> getVeredas(UsuarioEntity usuario);
  Future<List<VeredaModel>> downloadVeredas(
      UsuarioEntity usuario, List<String> municipiosIds);
}

class VeredaRemoteDataSourceImpl implements VeredaRemoteDataSource {
  final http.Client client;

  VeredaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<VeredaModel>> downloadVeredas(
      UsuarioEntity usuario, List<String> municipiosIds) async {
    List<VeredaModel> veredas = [];
    for (var municipioId in municipiosIds) {
      final respVeredasMunicipio =
          await getVeredasByMunicipio(usuario, municipioId.toString());
      if (respVeredasMunicipio.isNotEmpty) {
        for (var vereda in respVeredasMunicipio) {
          veredas.add(vereda);
        }
      }
    }
    return veredas;
  }

  @override
  Future<List<VeredaModel>> getVeredas(UsuarioEntity usuario) async {
    final departamentos = await getDepartamentos(usuario);

    List<MunicipioModel> municipios = [];

    for (var departamento in departamentos) {
      final municipiosDepartamento =
          await getMunicipiosByDepartamento(usuario, departamento.id);
      municipios.addAll(municipiosDepartamento);
    }

    List<VeredaModel> veredas = [];

    for (var municipio in municipios) {
      final veredasMunicipio =
          await getVeredasByMunicipio(usuario, municipio.id);

      if (veredasMunicipio.isNotEmpty) {
        veredas.addAll(veredasMunicipio);
      }
    }
    return veredas;
  }

  Future<List<VeredaModel>> getVeredasByMunicipio(
      UsuarioEntity usuario, String municipioId) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final veredaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaVeredas</string>       
            <string>$municipioId</string>       
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final veredaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: veredaSOAP);

      if (veredaResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener las veredas']);
      }

      final veredaDoc = xml.XmlDocument.parse(veredaResp.body);

      final respuesta =
          veredaDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (veredaDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = veredaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        //final Map<String, dynamic> decodedResp = json.decode(res);
        final Map<String, dynamic> decodedResp = jsonDecode(res
            .toString()
            .replaceAll(RegExp(r'[^A-Za-z0-9() áéíóúÁÉÍÓÚñÑ:[\]{}.,";?]'), ''));

        final veredasRaw = decodedResp.entries.first.value['Table'];

        if (veredasRaw is List) {
          return List.from(veredasRaw)
              .map((e) => VeredaModel.fromJson(e))
              .toList();
        } else {
          return [VeredaModel.fromJson(veredasRaw)];
        }
      } else {
        throw const ServerFailure(['Error al obtener las veredas']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<List<MunicipioModel>> getMunicipiosByDepartamento(
      UsuarioEntity usuario, String departamentoId) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

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

      if (municipioResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los municipios']);
      }

      final municipioDoc = xml.XmlDocument.parse(municipioResp.body);

      final respuesta =
          municipioDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (municipioDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

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
        throw const ServerFailure(
            ['Error al obtener los municipios por departamento']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<List<DepartamentoModel>> getDepartamentos(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

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

      if (departamentoResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener los departamentos']);
      }

      final departamentoDoc = xml.XmlDocument.parse(departamentoResp.body);

      final respuesta =
          departamentoDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          departamentoDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (departamentoDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

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
        throw ServerFailure([mensaje]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
