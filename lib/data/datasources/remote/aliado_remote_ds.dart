import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/aliado_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/aliado_model.dart';
import '../../models/aliados_model.dart';
import '../../utils.dart';

abstract class AliadoRemoteDataSource {
  Future<List<AliadoModel>> getAliados(UsuarioEntity usuario);
  Future<List<AliadoEntity>> saveAliados(
      UsuarioEntity usuario, List<AliadoEntity> aliadosEntity);
}

class AliadoRemoteDataSourceImpl implements AliadoRemoteDataSource {
  final http.Client client;

  AliadoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AliadoModel>> getAliados(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final aliadoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaAliados</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final aliadoResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: aliadoSOAP);

      if (aliadoResp.statusCode == 200) {
        final aliadoDoc = xml.XmlDocument.parse(aliadoResp.body);

        final respuesta =
            aliadoDoc.findAllElements('respuesta').map((e) => e.text).first;

        if (respuesta == 'true' &&
            aliadoDoc.findAllElements('NewDataSet').isNotEmpty) {
          final xmlString = aliadoDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final aliadosRaw = decodedResp.entries.first.value['Table'];

          final aliados = List.from(aliadosRaw)
              .map((e) => AliadosModel.fromJson(e))
              .toList();

          List<AliadoModel> listAliado = [];
          for (var aliado in aliados) {
            final dsAliado = await getAliadoTable(usuario, aliado.aliadoId);
            listAliado.add(dsAliado);
          }
          return listAliado;
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

  Future<AliadoModel> getAliadoTable(
      UsuarioEntity usuario, String aliadoId) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final aliadoesSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarAliado xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
          <objeto>
            <AliadoId>$aliadoId</AliadoId>
          </objeto>
        </ConsultarAliado>
      </soap:Body>
    </soap:Envelope>''';

      final aliadoResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ConsultarAliado"
          },
          body: aliadoesSOAP);

      if (aliadoResp.statusCode == 200) {
        final aliadoDoc = xml.XmlDocument.parse(aliadoResp.body);

        final respuesta =
            aliadoDoc.findAllElements('respuesta').map((e) => e.text).first;

        final mensaje =
            aliadoDoc.findAllElements('mensaje').map((e) => e.text).first;

        if (respuesta == 'true') {
          final xmlString = aliadoDoc
              .findAllElements('objeto')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final decodedResp = json.decode(res);

          final aliado = AliadoModel.fromJson(decodedResp['objeto']);

          return aliado;
        } else {
          throw ServerFailure([mensaje]);
        }
      } else {
        throw ServerException();
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<List<AliadoEntity>> saveAliados(
      UsuarioEntity usuario, List<AliadoEntity> aliadosEntity) async {
    List<AliadoEntity> aliadosUpload = [];
    for (var aliado in aliadosEntity) {
      final resp = await saveAliado(usuario, aliado);
      if (resp != null) {
        aliadosUpload.add(resp);
      }
    }
    return aliadosUpload;
  }

  Future<AliadoEntity?> saveAliado(
      UsuarioEntity usuario, AliadoEntity aliadoEntity) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final aliadoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarAliado xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
          <objeto>
            <AliadoId>${aliadoEntity.aliadoId}</AliadoId>
            <Nombre>${aliadoEntity.nombre}</Nombre>
            <FechaCreacion>${aliadoEntity.fechaCreacion}</FechaCreacion>
            <NombreContacto>${aliadoEntity.nombreContacto}</NombreContacto>
            <Direccion>${aliadoEntity.direccion}</Direccion>
            <TelefonoFijo>${aliadoEntity.telefonoFijo}</TelefonoFijo>
            <TelefonoMovil>${aliadoEntity.telefonoMovil}</TelefonoMovil>
            <Correo>${aliadoEntity.correo}</Correo>
            <MunicipioId>${aliadoEntity.municipioId}</MunicipioId>
            <Experiencia>${aliadoEntity.experiencia}</Experiencia>
            <FechaActivacion>${aliadoEntity.fechaActivacion}</FechaActivacion>
            <FechaDesactivacion>${aliadoEntity.fechaDesactivacion}</FechaDesactivacion>
            <FechaCambio>${aliadoEntity.fechaCambio}</FechaCambio>
            <Activo>${aliadoEntity.activo}</Activo>
          </objeto>
        </GuardarAliado>
      </soap:Body>
    </soap:Envelope>
    ''';

      final aliadoResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/GuardarAliado"
          },
          body: aliadoSOAP);

      if (aliadoResp.statusCode == 200) {
        final aliadoDoc = xml.XmlDocument.parse(aliadoResp.body);

        final respuesta =
            aliadoDoc.findAllElements('respuesta').map((e) => e.text).first;

        if (respuesta == 'true') {
          return aliadoEntity;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
