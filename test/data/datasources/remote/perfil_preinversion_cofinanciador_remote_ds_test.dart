import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/perfil_preinversion_cofinanciador_remote_ds.dart';
import 'package:paap/data/models/perfil_preinversion_cofinanciador_model.dart';
import 'package:paap/data/models/usuario_model.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late PerfilPreInversionCofinanciadorRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = PerfilPreInversionCofinanciadorRemoteDataSourceImpl(
        client: mockHttpClient);
  });

  group('GuardarPerfilPreInversionCofinanciador', () {
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

    final perfilPreInversionCofinanciadorModel =
        PerfilPreInversionCofinanciadorModel(
            perfilPreInversionId: '1',
            cofinanciadorId: '91',
            monto: '12000000.00',
            participacion: '0.00');

    final perfilPreInversionCofinanciadorSOAP =
        '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionCofinanciador xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionCofinanciadorModel.perfilPreInversionId}</PerfilPreInversionId>
            <CofinanciadorId>${perfilPreInversionCofinanciadorModel.cofinanciadorId}</CofinanciadorId>
            <Monto>${perfilPreInversionCofinanciadorModel.monto}</Monto>
            <Participacion>${perfilPreInversionCofinanciadorModel.participacion}</Participacion>
          </objeto>
        </GuardarPerfilPreInversionCofinanciador>
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
                "SOAPAction":
                    "${Constants.urlSOAP}/GuardarPerfilPreInversionCofinanciador"
              },
              body: perfilPreInversionCofinanciadorSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body>
                <GuardarPerfilPreInversionCofinanciadorResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                    <GuardarPerfilPreInversionCofinanciadorResult>
                        <respuesta>true</respuesta>
                        <mensaje>Transacción realizada correctamente</mensaje>
                        <registroId>-1</registroId>
                    </GuardarPerfilPreInversionCofinanciadorResult>
                </GuardarPerfilPreInversionCofinanciadorResponse>
            </soap:Body>
        </soap:Envelope>''', 200),
        );

        // act
        final savePerfilPreInversionCofinanciadorResult =
            await dataSource.savePerfilPreInversionCofinanciador(
                usuarioModel, perfilPreInversionCofinanciadorModel);

        // assert
        expect(savePerfilPreInversionCofinanciadorResult,
            equals(perfilPreInversionCofinanciadorModel));
      },
    );
  });
}
