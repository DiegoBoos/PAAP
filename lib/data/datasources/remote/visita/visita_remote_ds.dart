import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paap/domain/entities/visita_entity.dart';
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';
import '../../../models/perfiles_model.dart';
import '../../../models/visita_model.dart';
import '../../../utils.dart';

abstract class VisitaRemoteDataSource {
  Future<List<VisitaModel>> getVisitas(UsuarioEntity usuario);
  Future<int> saveVisita(UsuarioEntity usuario, VisitaEntity visitaEntity);
}

class VisitaRemoteDataSourceImpl implements VisitaRemoteDataSource {
  final http.Client client;

  VisitaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<VisitaModel>> getVisitas(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilesSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
          </usuario>
          <rol>
            <RolId>400</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaPerfiles</string> 
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final perfilesResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilesSOAP);

    if (perfilesResp.statusCode == 200) {
      final perfilesDoc = xml.XmlDocument.parse(perfilesResp.body);

      final respuesta =
          perfilesDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          perfilesDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = perfilesDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilesRaw = decodedResp.entries.first.value['Table'];

        final perfiles = List.from(perfilesRaw)
            .map((e) => PerfilesModel.fromJson(e))
            .toList();

        List<VisitaModel> listVisita = [];
        for (var perfil in perfiles) {
          final dsVisita = await getVisitaTable(usuario, perfil.id);
          if (dsVisita != null) {
            listVisita.add(dsVisita);
          }
        }
        return listVisita;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  Future<VisitaModel?> getVisitaTable(
      UsuarioEntity usuario, String visitaId) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final visitasSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarVisita xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
            </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <PerfilId>$visitaId</PerfilId>
            <TipoVisitaId>1</TipoVisitaId>
          </objeto>
        </ConsultarVisita>
      </soap:Body>
    </soap:Envelope>''';

    final visitaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ConsultarVisita"
        },
        body: visitasSOAP);

    if (visitaResp.statusCode == 200) {
      final visitaDoc = xml.XmlDocument.parse(visitaResp.body);

      final respuesta =
          visitaDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          visitaDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = visitaDoc
            .findAllElements('objeto')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final decodedResp = json.decode(res);

        final visita = VisitaModel.fromJson(decodedResp['objeto']);

        return visita;
      } else {
        //throw ServerFailure([mensaje]);
        return null;
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<int> saveVisita(
      UsuarioEntity usuario, VisitaEntity visitaEntity) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final visitaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarVisita xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
          </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <PerfilId>${visitaEntity.perfilId}</PerfilId>
            <TipoVisitaId>${visitaEntity.tipoVisitaId}</TipoVisitaId>
            <FechaInicial>${visitaEntity.fechaInicial}</FechaInicial>
            <FechaFinal>${visitaEntity.fechaFinal}</FechaFinal>
            <EstadoVisitaId>${visitaEntity.estadoVisitaId}</EstadoVisitaId>
            <Observacion>${visitaEntity.observacion}</Observacion>
            <UsuarioId>${visitaEntity.usuarioId}</UsuarioId>
            <FechaRegistro>${visitaEntity.fechaRegistro}</FechaRegistro>
          </objeto>
        </GuardarVisita>
      </soap:Body>
    </soap:Envelope>
    ''';

    final visitaResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: visitaSOAP);

    if (visitaResp.statusCode == 200) {
      final visitaDoc = xml.XmlDocument.parse(visitaResp.body);

      final respuesta =
          visitaDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          visitaDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        return 1;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
