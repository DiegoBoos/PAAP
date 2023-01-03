import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/aliado_remote_ds.dart';
import 'package:paap/data/models/aliado_model.dart';
import 'package:paap/data/models/usuario_model.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late AliadoRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AliadoRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('GuardarAliado', () {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final usuarioModel = UsuarioModel(
        usuarioId: '',
        nombre: '',
        apellido: '',
        direccion: '',
        telefonoFijo: '',
        telefonoMovil: '',
        correo: '',
        contrasena: '',
        fechaActivacion: '',
        fechaDesactivacion: '',
        fechaCambio: '',
        activo: '');

    final aliadoModel = AliadoModel(
        aliadoId: '100',
        nombre: 'string',
        fechaCreacion: '2022-12-28T21:01:26.263Z',
        nombreContacto: 'string',
        direccion: 'string',
        telefonoFijo: 'string',
        telefonoMovil: 'string',
        correo: 'string',
        municipioId: '100',
        experiencia: '100',
        fechaActivacion: '2022-12-28T21:01:26.263Z',
        fechaDesactivacion: '2022-12-28T21:01:26.263Z',
        fechaCambio: '2022-12-28T21:01:26.263Z',
        activo: 'true');

    final aliadoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarAliado xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <AliadoId>${aliadoModel.aliadoId}</AliadoId>
            <Nombre>${aliadoModel.nombre}</Nombre>
            <FechaCreacion>${aliadoModel.fechaCreacion}</FechaCreacion>
            <NombreContacto>${aliadoModel.nombreContacto}</NombreContacto>
            <Direccion>${aliadoModel.direccion}</Direccion>
            <TelefonoFijo>${aliadoModel.telefonoFijo}</TelefonoFijo>
            <TelefonoMovil>${aliadoModel.telefonoMovil}</TelefonoMovil>
            <Correo>${aliadoModel.correo}</Correo>
            <MunicipioId>${aliadoModel.municipioId}</MunicipioId>
            <Experiencia>${aliadoModel.experiencia}</Experiencia>
            <FechaActivacion>${aliadoModel.fechaActivacion}</FechaActivacion>
            <FechaDesactivacion>${aliadoModel.fechaDesactivacion}</FechaDesactivacion>
            <FechaCambio>${aliadoModel.fechaCambio}</FechaCambio>
            <Activo>${aliadoModel.activo}</Activo>
          </objeto>
        </GuardarAliado>
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
                "SOAPAction": "${Constants.urlSOAP}/GuardarAliado"
              },
              body: aliadoSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body>
                <GuardarAliadoResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                    <GuardarAliadoResult>
                        <respuesta>true</respuesta>
                        <mensaje>Transacción realizada correctamente</mensaje>
                        <registroId>-1</registroId>
                    </GuardarAliadoResult>
                </GuardarAliadoResponse>
            </soap:Body>
        </soap:Envelope>''', 200),
        );

        // act
        final saveAliadoResult =
            await dataSource.saveAliado(usuarioModel, aliadoModel);

        // assert
        expect(saveAliadoResult, equals(aliadoModel));
      },
    );
  });
}
