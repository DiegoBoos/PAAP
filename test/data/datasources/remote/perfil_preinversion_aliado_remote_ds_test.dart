import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/perfil_preinversion_aliado_remote_ds.dart';
import 'package:paap/data/models/perfil_preinversion_aliado_model.dart';
import 'package:paap/data/models/usuario_model.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late PerfilPreInversionAliadoRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource =
        PerfilPreInversionAliadoRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('GuardarPerfilPreInversionAliado', () {
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

    final perfilPreInversionAliadoModel = PerfilPreInversionAliadoModel(
        perfilPreInversionId: '1',
        aliadoId: '0',
        productoId: '6',
        volumenCompra: '123.00',
        unidadId: '1',
        frecuenciaId: '1',
        porcentajeCompra: '123',
        sitioEntregaId: '2');

    final perfilPreInversionAliadoSOAP =
        '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionAliado xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionAliadoModel.perfilPreInversionId}</PerfilPreInversionId>
            <AliadoId>${perfilPreInversionAliadoModel.aliadoId}</AliadoId>
            <ProductoId>${perfilPreInversionAliadoModel.productoId}</ProductoId>
            <VolumenCompra>${perfilPreInversionAliadoModel.volumenCompra}</VolumenCompra>
            <UnidadId>${perfilPreInversionAliadoModel.unidadId}</UnidadId>
            <FrecuenciaId>${perfilPreInversionAliadoModel.frecuenciaId}</FrecuenciaId>
            <PorcentajeCompra>${perfilPreInversionAliadoModel.porcentajeCompra}</PorcentajeCompra>
            <SitioEntregaId>${perfilPreInversionAliadoModel.sitioEntregaId}</SitioEntregaId>
          </objeto>
        </GuardarPerfilPreInversionAliado>
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
                    "${Constants.urlSOAP}/GuardarPerfilPreInversionAliado"
              },
              body: perfilPreInversionAliadoSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body>
              <GuardarPerfilPreInversionAliadoResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                <GuardarPerfilPreInversionAliadoResult>
                    <respuesta>true</respuesta>
                    <mensaje>Transacción realizada correctamente</mensaje>
                    <registroId>-1</registroId>
                </GuardarPerfilPreInversionAliadoResult>
            </GuardarPerfilPreInversionAliadoResponse>
            </soap:Body>
        </soap:Envelope>''', 200),
        );

        // act
        final savePerfilPreInversionAliadoResult =
            await dataSource.savePerfilPreInversionAliado(
                usuarioModel, perfilPreInversionAliadoModel);

        // assert
        expect(savePerfilPreInversionAliadoResult,
            equals(perfilPreInversionAliadoModel));
      },
    );
  });
}
