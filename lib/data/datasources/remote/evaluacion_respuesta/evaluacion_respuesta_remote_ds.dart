import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paap/domain/entities/evaluacion_respuesta_entity.dart';
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';
import '../../../models/evaluacion_respuesta_model.dart';
import '../../../utils.dart';

abstract class EvaluacionRespuestaRemoteDataSource {
  Future<List<EvaluacionRespuestaModel>> getEvaluacionesRespuestas(
      UsuarioEntity usuario);
  Future<List<EvaluacionRespuestaEntity>> saveEvaluacionesRespuestas(
      UsuarioEntity usuario,
      List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity);
}

class EvaluacionRespuestaRemoteDataSourceImpl
    implements EvaluacionRespuestaRemoteDataSource {
  final http.Client client;

  EvaluacionRespuestaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EvaluacionRespuestaModel>> getEvaluacionesRespuestas(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final evaluacionRespuestaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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

    if (evaluacionRespuestaResp.statusCode == 200) {
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
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<EvaluacionRespuestaEntity>> saveEvaluacionesRespuestas(
      UsuarioEntity usuario,
      List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity) async {
    List<EvaluacionRespuestaEntity> evaluacionesRespuestasUpload = [];
    for (var evaluacionRespuesta in evaluacionesRespuestasEntity) {
      final resp = await saveVisita(usuario, evaluacionRespuesta);
      if (resp != null) {
        evaluacionesRespuestasUpload.add(resp);
      }
    }
    return evaluacionesRespuestasUpload;
  }

  Future<EvaluacionRespuestaEntity?> saveVisita(UsuarioEntity usuario,
      EvaluacionRespuestaEntity evaluacionRespuestaEntity) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final evaluacionRespuestaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarEvaluacionRespuesta xmlns="http://alianzasproductivas.minagricultura.gov.co/">
        <usuario>
                <UsuarioId>${usuario.usuarioId}</UsuarioId>
                <Contrasena>${usuario.contrasena}</Contrasena>
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

    if (evaluacionRespuestaResp.statusCode == 200) {
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
    } else {
      return null;
    }
  }
}
