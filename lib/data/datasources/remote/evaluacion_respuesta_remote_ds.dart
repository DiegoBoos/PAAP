import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:paap/domain/entities/evaluacion_respuesta_entity.dart';
import 'package:xml/xml.dart' as xml;

import '../../core/error/failure.dart';
import '../../../domain/entities/evaluacion_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../models/evaluacion_respuesta_model.dart';
import '../../utils.dart';

abstract class EvaluacionRespuestaRemoteDataSource {
  Future<List<EvaluacionRespuestaModel>> getEvaluacionesRespuestas(
      UsuarioEntity usuario);
  Future<List<EvaluacionRespuestaEntity>> saveEvaluacionesRespuestas(
      UsuarioEntity usuario,
      List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity);
  Future<List<EvaluacionRespuestaEntity>> getEvaluacionesRespuestasNuevas(
      UsuarioEntity usuario, List<EvaluacionEntity> evaluaciones);
}

class EvaluacionRespuestaRemoteDataSourceImpl
    implements EvaluacionRespuestaRemoteDataSource {
  final http.Client client;

  EvaluacionRespuestaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EvaluacionRespuestaModel>> getEvaluacionesRespuestas(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final evaluacionRespuestaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaEvaluacionesRespuestas</string>            
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final evaluacionRespuestaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: evaluacionRespuestaSOAP);

      if (evaluacionRespuestaResp.statusCode != 200) {
        throw const ServerFailure(
            ['Error al obtener las evaluaciones respuesta']);
      }

      final evaluacionRespuestaDoc =
          xml.XmlDocument.parse(evaluacionRespuestaResp.body);

      final respuesta = evaluacionRespuestaDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      final mensaje = evaluacionRespuestaDoc
          .findAllElements('mensaje')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        if (evaluacionRespuestaDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = evaluacionRespuestaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final evaluacionesRespuestasRaw =
            decodedResp.entries.first.value['Table'];

        if (evaluacionesRespuestasRaw is List) {
          return List.from(evaluacionesRespuestasRaw)
              .map((e) => EvaluacionRespuestaModel.fromJson(e))
              .toList();
        } else {
          return [EvaluacionRespuestaModel.fromJson(evaluacionesRespuestasRaw)];
        }
      } else {
        throw ServerFailure([mensaje]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<List<EvaluacionRespuestaEntity>> saveEvaluacionesRespuestas(
      UsuarioEntity usuario,
      List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity) async {
    List<EvaluacionRespuestaEntity> evaluacionesRespuestasUpload = [];
    for (var evaluacionRespuesta in evaluacionesRespuestasEntity) {
      final resp = await saveEvaluacionRespuesta(usuario, evaluacionRespuesta);
      if (resp != null) {
        evaluacionesRespuestasUpload.add(resp);
      }
    }
    return evaluacionesRespuestasUpload;
  }

  Future<EvaluacionRespuestaEntity?> saveEvaluacionRespuesta(
      UsuarioEntity usuario,
      EvaluacionRespuestaEntity evaluacionRespuestaEntity) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final evaluacionRespuestaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarEvaluacionRespuesta xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <CriterioId>${evaluacionRespuestaEntity.criterioId}</CriterioId>
            <EvaluacionId>${evaluacionRespuestaEntity.evaluacionId}</EvaluacionId>
            <OpcionId>${evaluacionRespuestaEntity.opcionId}</OpcionId>
            <Observacion>${evaluacionRespuestaEntity.observacion}</Observacion>
          </objeto>
        </GuardarEvaluacionRespuesta>
      </soap:Body>
    </soap:Envelope>
    ''';

      final evaluacionRespuestaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/GuardarEvaluacionRespuesta"
          },
          body: evaluacionRespuestaSOAP);

      if (evaluacionRespuestaResp.statusCode != 200) {
        throw const ServerFailure(['Error al guardar la evaluacion respuesta']);
      }

      final evaluacionRespuestaDoc =
          xml.XmlDocument.parse(evaluacionRespuestaResp.body);

      final respuesta = evaluacionRespuestaDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        return evaluacionRespuestaEntity;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<List<EvaluacionRespuestaEntity>> getEvaluacionesRespuestasNuevas(
      UsuarioEntity usuario, List<EvaluacionEntity> evaluaciones) async {
    List<EvaluacionRespuestaEntity> evaluacionesRespuestasNews = [];
    for (var evaluacion in evaluaciones) {
      final resp = await getEvaluacionesRespuestasPorEvaluacion(
          usuario, evaluacion.evaluacionId);
      if (resp != null) {
        evaluacionesRespuestasNews.add(resp);
      }
    }
    return evaluacionesRespuestasNews;
  }

  Future<EvaluacionRespuestaModel?> getEvaluacionesRespuestasPorEvaluacion(
      UsuarioEntity usuario, evaluacionId) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

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
            <string>TablaEvaluacionesRespuestasPorEvaluaciones</string>            
            <string>$evaluacionId</string>            
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

      if (evaluacionResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener la evaluacion']);
      }

      final evaluacionDoc = xml.XmlDocument.parse(evaluacionResp.body);

      final respuesta =
          evaluacionDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          evaluacionDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (evaluacionDoc.findAllElements('NewDataSet').isEmpty) {
          return null;
        }

        final xmlString = evaluacionDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final evaluacionesRaw = decodedResp.entries.first.value['Table'];

        if (evaluacionesRaw is List) {
          return List.from(evaluacionesRaw)
              .map((e) => EvaluacionRespuestaModel.fromJson(e))
              .toList()[0];
        } else {
          return null;
        }
      } else {
        throw ServerFailure([mensaje]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
