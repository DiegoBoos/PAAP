import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/perfil_preinversion_precio_remote_ds.dart';
import 'package:paap/data/models/perfil_preinversion_precio_model.dart';
import 'package:paap/data/models/usuario_model.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late PerfilPreInversionPrecioRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource =
        PerfilPreInversionPrecioRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('GuardarPerfilPreInversionPrecio', () {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PAAP/ServiciosDesarrollo/PAAPServicioWeb.asmx');

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

    final perfilPreInversionPrecioModel = PerfilPreInversionPrecioModel(
      perfilPreInversionId: '1',
      productoId: '6',
      unidadId: '12',
      tipoCalidadId: '1',
      precio: '100000.00',
    );

    final perfilPreInversionPrecioSOAP =
        '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionPrecio xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionPrecioModel.perfilPreInversionId}</PerfilPreInversionId>
            <ProductoId>${perfilPreInversionPrecioModel.productoId}</ProductoId>
            <TipoCalidadId>${perfilPreInversionPrecioModel.tipoCalidadId}</TipoCalidadId>
            <Precio>${perfilPreInversionPrecioModel.precio}</Precio>
            <UnidadId>${perfilPreInversionPrecioModel.unidadId}</UnidadId>
          </objeto>
        </GuardarPerfilPreInversionPrecio>
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
                    "${Constants.urlSOAP}/GuardarPerfilPreInversionPrecio"
              },
              body: perfilPreInversionPrecioSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body>
                <GuardarPerfilPreInversionPrecioResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                    <GuardarPerfilPreInversionPrecioResult>
                        <respuesta>true</respuesta>
                        <mensaje>Transacción realizada correctamente</mensaje>
                        <registroId>-1</registroId>
                    </GuardarPerfilPreInversionPrecioResult>
                </GuardarPerfilPreInversionPrecioResponse>
            </soap:Body>
        </soap:Envelope>''', 200),
        );

        // act
        final savePerfilPreInversionPrecioResult =
            await dataSource.savePerfilPreInversionPrecio(
                usuarioModel, perfilPreInversionPrecioModel);

        // assert
        expect(savePerfilPreInversionPrecioResult,
            equals(perfilPreInversionPrecioModel));
      },
    );
  });
}
