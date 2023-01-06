import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/evaluacion_respuesta_remote_ds.dart';
import 'package:paap/data/models/evaluacion_respuesta_model.dart';
import 'package:paap/data/models/usuario_model.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late EvaluacionRespuestaRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource =
        EvaluacionRespuestaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('GuardarEvaluacionRespuesta', () {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final usuarioModel = UsuarioModel(
        usuarioId: 'hugo.suarez@minagricultura.gov.co',
        nombre: 'Hugo Armando',
        apellido: 'Suárez León',
        direccion: 'Av Jimenez # 7b-01',
        telefonoFijo: '2543300',
        telefonoMovil: '2543300',
        correo: 'hugo.suarez@minagricultura.gov.co',
        contrasena: 'TWlncmFjaW9uUEFBUCo=',
        fechaActivacion: '2020-03-01T00:00:00+01:00',
        fechaDesactivacion: '2023-04-19T17:41:22.633+02:00',
        fechaCambio: '2023-04-19T17:41:22.633+02:00',
        activo: 'true');

    final evaluacionRespuestaModel = EvaluacionRespuestaModel(
        criterioId: '48',
        evaluacionId: '2',
        opcionId: '148',
        observacion:
            'It is a long established fact that a reader will be distracted by the');

    final evaluacionRespuestaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarEvaluacionRespuesta xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuarioModel.usuarioId}</UsuarioId>
            <Nombre>${usuarioModel.nombre}</Nombre>
            <Apellido>${usuarioModel.apellido}</Apellido>
            <Direccion>${usuarioModel.direccion}</Direccion>
            <TelefonoFijo>${usuarioModel.telefonoFijo}</TelefonoFijo>
            <TelefonoMovil>${usuarioModel.telefonoMovil}</TelefonoMovil>
            <Correo>${usuarioModel.correo}</Correo>
            <Contrasena>${usuarioModel.contrasena}</Contrasena>
            <FechaActivacion>${usuarioModel.fechaActivacion}</FechaActivacion>
            <FechaDesactivacion>${usuarioModel.fechaDesactivacion}</FechaDesactivacion>
            <FechaCambio>${usuarioModel.fechaCambio}</FechaCambio>
            <Activo>${usuarioModel.activo}</Activo>
          </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <CriterioId>${evaluacionRespuestaModel.criterioId}</CriterioId>
            <EvaluacionId>${evaluacionRespuestaModel.evaluacionId}</EvaluacionId>
            <OpcionId>${evaluacionRespuestaModel.opcionId}</OpcionId>
            <Observacion>${evaluacionRespuestaModel.observacion}</Observacion>
          </objeto>
        </GuardarEvaluacionRespuesta>
      </soap:Body>
    </soap:Envelope>
    ''';

    test(
      'debe retornar true cuando el status code sea 200',
      () async {
        // arrange
        when(
          mockHttpClient.post(uri,
              headers: {
                "Content-Type": "text/xml; charset=utf-8",
                "SOAPAction": "${Constants.urlSOAP}/GuardarEvaluacionRespuesta"
              },
              body: evaluacionRespuestaSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body>
                <GuardarEvaluacionRespuestaResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                    <GuardarEvaluacionRespuestaResult>
                        <respuesta>true</respuesta>
                        <mensaje>Transacción realizada correctamente</mensaje>
                        <registroId>-1</registroId>
                    </GuardarEvaluacionRespuestaResult>
                </GuardarEvaluacionRespuestaResponse>
            </soap:Body>
        </soap:Envelope>''', 200),
        );

        // act
        final saveEvaluacionRespuestaResult = await dataSource
            .saveEvaluacionRespuesta(usuarioModel, evaluacionRespuestaModel);

        // assert
        expect(saveEvaluacionRespuestaResult, equals(evaluacionRespuestaModel));
      },
    );
  });
}
