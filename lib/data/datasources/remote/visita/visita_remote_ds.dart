import 'package:http/http.dart' as http;
import 'package:paap/domain/entities/visita_entity.dart';
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

abstract class VisitaRemoteDataSource {
  Future<int> saveVisita(UsuarioEntity usuario, VisitaEntity visitaEntity);
}

class VisitaRemoteDataSourceImpl implements VisitaRemoteDataSource {
  final http.Client client;

  VisitaRemoteDataSourceImpl({required this.client});

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
