import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/visita_remote_ds.dart';
import 'package:paap/data/models/visita_model.dart';
import 'package:paap/data/models/usuario_model.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late VisitaRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = VisitaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('GuardarVisita', () {
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

    final visitaModel = VisitaModel(
        perfilId: '44',
        tipoVisitaId: '1',
        fechaInicial: '2022-12-04T00:00:00',
        fechaFinal: '2022-12-04T00:00:00',
        estadoVisitaId: '1',
        observacion: '',
        usuarioId: 'hugo.suarez@minagricultura.gov.co',
        fechaRegistro: '2022-12-04T20:05:58.85');

    final visitaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarVisita xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilId>${visitaModel.perfilId}</PerfilId>
            <TipoVisitaId>${visitaModel.tipoVisitaId}</TipoVisitaId>
            <FechaInicial>${visitaModel.fechaInicial}</FechaInicial>
            <FechaFinal>${visitaModel.fechaFinal}</FechaFinal>
            <EstadoVisitaId>${visitaModel.estadoVisitaId}</EstadoVisitaId>
            <Observacion>${visitaModel.observacion}</Observacion>
            <UsuarioId>${visitaModel.usuarioId}</UsuarioId>
            <FechaRegistro>${visitaModel.fechaRegistro}</FechaRegistro>
          </objeto>
        </GuardarVisita>
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
                "SOAPAction": "${Constants.urlSOAP}/GuardarVisita"
              },
              body: visitaSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body>
                <GuardarVisitaResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                    <GuardarVisitaResult>
                        <respuesta>true</respuesta>
                        <mensaje>Transacción realizada correctamente</mensaje>
                        <registroId>-1</registroId>
                    </GuardarVisitaResult>
                </GuardarVisitaResponse>
            </soap:Body>
        </soap:Envelope>''', 200),
        );

        // act
        final saveVisitaResult =
            await dataSource.saveVisita(usuarioModel, visitaModel);

        // assert
        expect(saveVisitaResult, equals(visitaModel));
      },
    );
  });
}
