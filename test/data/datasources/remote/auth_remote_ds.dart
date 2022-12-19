import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/auth_remote_ds.dart';
import 'package:paap/data/models/usuario_model.dart';
import 'package:paap/domain/core/error/failure.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AuthRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('verificacion', () {
    final usuarioModel = UsuarioModel(
        usuarioId: 'adamariatorrenegra@hotmail.com', contrasena: '');
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final verificacionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <Verificacion xmlns="${Constants.urlSOAP}/">
          <objeto>
            <UsuarioId>${usuarioModel.usuarioId}</UsuarioId>
            <Contrasena>${usuarioModel.contrasena}</Contrasena>
          </objeto>
        </Verificacion>
      </soap:Body>
    </soap:Envelope>''';

    final consultarUsuarioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarUsuario xmlns="${Constants.urlSOAP}/">
          <usuario>
            <UsuarioId>${usuarioModel.usuarioId}</UsuarioId>
            <Contrasena>${usuarioModel.contrasena}</Contrasena>
          </usuario>
          <objeto>
            <UsuarioId>${usuarioModel.usuarioId}</UsuarioId>
            <Contrasena>${usuarioModel.contrasena}</Contrasena>
          </objeto>
        </ConsultarUsuario>
      </soap:Body>
    </soap:Envelope>''';

    test(
      'should return true when the response code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.post(uri,
              headers: {
                "Content-Type": "text/xml; charset=utf-8",
                "SOAPAction": "${Constants.urlSOAP}/Verificacion"
              },
              body: verificacionSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
          <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:xsd="http://www.w3.org/2001/XMLSchema">
              <soap:Body>
                  <VerificacionResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                      <VerificacionResult>
                          <respuesta>true</respuesta>
                          <mensaje>Usuario autenticado</mensaje>
                      </VerificacionResult>
                  </VerificacionResponse>
              </soap:Body>
          </soap:Envelope>''', 200),
        );

        // arrange
        when(
          mockHttpClient.post(uri,
              headers: {
                "Content-Type": "text/xml; charset=utf-8",
                "SOAPAction": "${Constants.urlSOAP}/ConsultarUsuario"
              },
              body: consultarUsuarioSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
          <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:xsd="http://www.w3.org/2001/XMLSchema">
              <soap:Body>
                  <ConsultarUsuarioResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                      <ConsultarUsuarioResult>
                          <respuesta>true</respuesta>
                          <mensaje>Consulta exitosa</mensaje>
                          <objeto xsi:type="Usuarios">
                              <UsuarioId>adamariatorrenegra@hotmail.com</UsuarioId>
                              <Nombre>Ada Maria</Nombre>
                              <Apellido>Torrenegra</Apellido>
                              <Direccion />
                              <TelefonoFijo />
                              <TelefonoMovil />
                              <Correo />
                              <Contrasena />
                              <FechaActivacion>2022-10-05T00:00:00</FechaActivacion>
                              <FechaDesactivacion>2022-12-13T00:00:00</FechaDesactivacion>
                              <FechaCambio>2023-04-19T00:00:00</FechaCambio>
                              <Activo>true</Activo>
                          </objeto>
                      </ConsultarUsuarioResult>
                  </ConsultarUsuarioResponse>
              </soap:Body>
          </soap:Envelope>''', 200),
        );

        // act
        final verificacionResult = await dataSource.verificacion(usuarioModel);

        // assert
        expect(verificacionResult, equals(usuarioModel));

        // act
        final consultarUsuarioResult =
            await dataSource.consultarUsuario(uri, usuarioModel);

        // assert
        expect(consultarUsuarioResult, equals(usuarioModel));
      },
    );

    test(
      'should return false when the response code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.post(uri,
              headers: {
                "Content-Type": "text/xml; charset=utf-8",
                "SOAPAction": "${Constants.urlSOAP}/Verificacion"
              },
              body: verificacionSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
          <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:xsd="http://www.w3.org/2001/XMLSchema">
              <soap:Body>
                  <VerificacionResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                      <VerificacionResult>
                          <respuesta>false</respuesta>
                          <mensaje>Usuario NO autenticado</mensaje>
                      </VerificacionResult>
                  </VerificacionResponse>
              </soap:Body>
          </soap:Envelope>''', 200),
        );

        // act
        final call = dataSource.verificacion(usuarioModel);

        // assert
        expect(() => call, throwsA(isA<ServerFailure>()));
      },
    );
  });
}
