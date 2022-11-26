import 'dart:convert';

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
}

class EvaluacionRemoteDataSourceImpl implements EvaluacionRemoteDataSource {
  final http.Client client;

  EvaluacionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EvaluacionModel>> getEvaluaciones(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final evaluacionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
  }

  @override
  Future<List<EvaluacionEntity>> saveEvaluaciones(
      UsuarioEntity usuario, List<EvaluacionEntity> evaluacionesEntity) async {
    List<EvaluacionEntity> evaluacionesUpload = [];
    for (var evaluacion in evaluacionesEntity) {
      final resp = await saveVisita(usuario, evaluacion);
      if (resp != null) {
        evaluacionesUpload.add(resp);
      }
    }
    return evaluacionesUpload;
  }

  Future<EvaluacionEntity?> saveVisita(
      UsuarioEntity usuario, EvaluacionEntity evaluacionEntity) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final evaluacionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarEvaluacion xmlns="http://alianzasproductivas.minagricultura.gov.co/">
        <usuario>
                <UsuarioId>${usuario.usuarioId}</UsuarioId>
                <Contrasena>${usuario.contrasena}</Contrasena>
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
        return evaluacionEntity;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
