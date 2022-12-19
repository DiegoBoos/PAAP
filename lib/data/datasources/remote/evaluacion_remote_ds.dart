import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:paap/domain/entities/evaluacion_entity.dart';
import 'package:xml/xml.dart' as xml;

import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';
import '../../models/evaluacion_model.dart';
import '../../utils.dart';

abstract class EvaluacionRemoteDataSource {
  Future<List<EvaluacionModel>> getEvaluaciones(UsuarioEntity usuario);
  Future<List<EvaluacionEntity>> saveEvaluaciones(
      UsuarioEntity usuario, List<EvaluacionEntity> evaluacionesEntity);
  Future<List<EvaluacionEntity>> getEvaluacionesNuevas(
      UsuarioEntity usuario, List<String> perfilesIds);
}

class EvaluacionRemoteDataSourceImpl implements EvaluacionRemoteDataSource {
  final http.Client client;

  EvaluacionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EvaluacionModel>> getEvaluaciones(UsuarioEntity usuario) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final evaluacionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaEvaluaciones</string>            
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final evaluacionResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: evaluacionSOAP);

      if (evaluacionResp.statusCode == 200) {
        final evaluacionDoc = xml.XmlDocument.parse(evaluacionResp.body);

        final respuesta =
            evaluacionDoc.findAllElements('respuesta').map((e) => e.text).first;

        final mensaje =
            evaluacionDoc.findAllElements('mensaje').map((e) => e.text).first;

        if (respuesta == 'true') {
          final xmlString = evaluacionDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final evaluacionesRaw = decodedResp.entries.first.value['Table'];

          if (evaluacionesRaw is List) {
            return List.from(evaluacionesRaw)
                .map((e) => EvaluacionModel.fromJson(e))
                .toList();
          } else {
            return [EvaluacionModel.fromJson(evaluacionesRaw)];
          }
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
  Future<List<EvaluacionEntity>> saveEvaluaciones(
      UsuarioEntity usuario, List<EvaluacionEntity> evaluacionesEntity) async {
    List<EvaluacionEntity> evaluacionesUpload = [];
    for (var evaluacion in evaluacionesEntity) {
      final resp = await saveEvaluacion(usuario, evaluacion);
      if (resp != null) {
        //evaluacion.remoteEvaluacionId = resp.evaluacionId;
        evaluacionesUpload.add(resp);
      }
    }
    return evaluacionesUpload;
  }

  Future<EvaluacionEntity?> saveEvaluacion(
      UsuarioEntity usuario, EvaluacionEntity evaluacionEntity) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');
      final evaluacionIdTable = evaluacionEntity.evaluacionId;
      if (evaluacionEntity.recordStatus == 'N') {
        evaluacionEntity.evaluacionId = '0';
      }
      final evaluacionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarEvaluacion xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <EvaluacionId>${evaluacionEntity.evaluacionId}</EvaluacionId>
            <PerfilId>${evaluacionEntity.perfilId}</PerfilId>
            <Resumen>${evaluacionEntity.resumen}</Resumen>
            <Fortalezas>${evaluacionEntity.fortalezas}</Fortalezas>
            <Debilidades>${evaluacionEntity.debilidades}</Debilidades>
            <Riesgos>${evaluacionEntity.riesgos}</Riesgos>
            <Finalizado>${evaluacionEntity.finalizado}</Finalizado>
            <FechaEvaluacion>${evaluacionEntity.fechaEvaluacion}</FechaEvaluacion>
            <PreAprobado>${evaluacionEntity.preAprobado}</PreAprobado>
          </objeto>
        </GuardarEvaluacion>
      </soap:Body>
    </soap:Envelope>
    ''';

      final evaluacionResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/GuardarEvaluacion"
          },
          body: evaluacionSOAP);

      if (evaluacionResp.statusCode == 200) {
        final evaluacionDoc = xml.XmlDocument.parse(evaluacionResp.body);

        final respuesta =
            evaluacionDoc.findAllElements('respuesta').map((e) => e.text).first;

        if (respuesta == 'true') {
          final evaluacionPorPerfil =
              await getEvaluacionPorPerfil(usuario, evaluacionEntity.perfilId);
          evaluacionPorPerfil?.remoteEvaluacionId =
              evaluacionPorPerfil.evaluacionId;
          evaluacionPorPerfil?.evaluacionId = evaluacionIdTable;

          return evaluacionPorPerfil;
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

  @override
  Future<List<EvaluacionEntity>> getEvaluacionesNuevas(
      UsuarioEntity usuario, List<String> perfilesIds) async {
    List<EvaluacionEntity> evaluacionesNews = [];
    for (var perfilId in perfilesIds) {
      final resp = await getEvaluacionPorPerfil(usuario, perfilId);
      if (resp != null) {
        evaluacionesNews.add(resp);
      }
    }
    return evaluacionesNews;
  }

  Future<EvaluacionModel?> getEvaluacionPorPerfil(
      UsuarioEntity usuario, perfilId) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final evaluacionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaEvaluacionesPorPerfil</string>            
            <string>$perfilId</string>            
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final evaluacionResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: evaluacionSOAP);

      if (evaluacionResp.statusCode == 200) {
        final evaluacionDoc = xml.XmlDocument.parse(evaluacionResp.body);

        final respuesta =
            evaluacionDoc.findAllElements('respuesta').map((e) => e.text).first;

        final mensaje =
            evaluacionDoc.findAllElements('mensaje').map((e) => e.text).first;

        if (respuesta == 'true') {
          final xmlString = evaluacionDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final evaluacionesRaw = decodedResp.entries.first.value['Table'];

          if (evaluacionesRaw is List) {
            return List.from(evaluacionesRaw)
                .map((e) => EvaluacionModel.fromJson(e))
                .toList()[0];
          } else {
            return EvaluacionModel.fromJson(evaluacionesRaw);
          }
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
}
