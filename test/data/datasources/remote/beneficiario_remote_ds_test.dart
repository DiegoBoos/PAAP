import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/beneficiario_remote_ds.dart';
import 'package:paap/data/models/beneficiario_model.dart';
import 'package:paap/data/models/usuario_model.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late BeneficiarioRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = BeneficiarioRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('GuardarBeneficiario', () {
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

    final beneficiarioModel = BeneficiarioModel(
        beneficiarioId: '0',
        nombre1: 'Manuel',
        nombre2: 'de Jesus',
        apellido1: 'Castrillo',
        apellido2: 'Carmona',
        generoId: '1',
        fechaNacimiento: '1964-11-09T00:00:00+01:00',
        fechaExpedicionDocumento: '1983-01-29T00:00:00+01:00',
        grupoEspecialId: '1',
        telefonoMovil: '311 745 1629',
        activo: 'true',
        tipoIdentificacionId: '1');

    final beneficiarioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarBeneficiario xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <Nombre1>${beneficiarioModel.nombre1}</Nombre1>
            <Nombre2>${beneficiarioModel.nombre2}</Nombre2>
            <Apellido1>${beneficiarioModel.apellido1}</Apellido1>
            <Apellido2>${beneficiarioModel.apellido2}</Apellido2>
            <GeneroId>${beneficiarioModel.generoId}</GeneroId>
            <FechaNacimiento>${beneficiarioModel.fechaNacimiento}</FechaNacimiento>
            <FechaExpedicionDocumento>${beneficiarioModel.fechaExpedicionDocumento}</FechaExpedicionDocumento>
            <GrupoEspecialId>${beneficiarioModel.grupoEspecialId}</GrupoEspecialId>
            <TelefonoMovil>${beneficiarioModel.telefonoMovil}</TelefonoMovil>
            <Activo>${beneficiarioModel.activo}</Activo>
            <TipoIdentificacionId>${beneficiarioModel.tipoIdentificacionId}</TipoIdentificacionId>
          </objeto>
        </GuardarBeneficiario>
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
                "SOAPAction": "${Constants.urlSOAP}/GuardarBeneficiario"
              },
              body: beneficiarioSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body>
                <GuardarBeneficiarioResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                    <GuardarBeneficiarioResult>
                        <respuesta>true</respuesta>
                        <mensaje>Transacción realizada correctamente</mensaje>
                        <registroId>-1</registroId>
                    </GuardarBeneficiarioResult>
                </GuardarBeneficiarioResponse>
            </soap:Body>
        </soap:Envelope>''', 200),
        );

        // act
        final saveBeneficiarioResult =
            await dataSource.saveBeneficiario(usuarioModel, beneficiarioModel);

        // assert
        expect(saveBeneficiarioResult, equals(beneficiarioModel));
      },
    );
  });
}
