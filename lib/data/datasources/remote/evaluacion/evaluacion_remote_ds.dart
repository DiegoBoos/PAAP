import 'package:http/http.dart' as http;
import 'package:paap/domain/entities/evaluacion_entity.dart';
import 'package:xml/xml.dart' as xml;

import '../../../../domain/core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

abstract class EvaluacionRemoteDataSource {
  Future<int> saveEvaluacion(
      UsuarioEntity usuario, EvaluacionEntity evaluacionEntity);
}

class EvaluacionRemoteDataSourceImpl implements EvaluacionRemoteDataSource {
  final http.Client client;

  EvaluacionRemoteDataSourceImpl({required this.client});

  @override
  Future<int> saveEvaluacion(
      UsuarioEntity usuario, EvaluacionEntity evaluacionEntity) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final evaluacionSOAP = '''
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarEvaluacion xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
        </ConsultarEvaluacion>
      </soap:Body>
    </soap:Envelope>
    ''';

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
        return 1;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
