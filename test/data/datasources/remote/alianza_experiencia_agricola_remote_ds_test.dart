import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/alianza_experiencia_agricola_remote_ds.dart';
import 'package:paap/data/models/alianza_experiencia_agricola_model.dart';
import 'package:paap/data/models/usuario_model.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late AlianzaExperienciaAgricolaRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource =
        AlianzaExperienciaAgricolaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('GuardarAlianzaExperienciaAgricola', () {
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

    final alianzaExperienciaAgricolaModel = AlianzaExperienciaAgricolaModel(
        tipoActividadProductivaId: '1',
        beneficiarioId: '0',
        frecuenciaId: '1',
        areaCultivo: '100.00',
        cantidadProducida: '200.00',
        cantidadVendida: '100.00',
        cantidadAutoconsumo: '100.00',
        costoImplementacion: '31200.00',
        valorJornal: '100.00',
        totalIngresoNeto: '200.00',
        areaPasto: '400.00',
        areaSinUso: '500.00',
        areaReservaConservacion: '600.00',
        areaImplementacion: '700.00',
        totalAreaPredio: '800.00');

    final alianzaExperienciaAgricolaSOAP =
        '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarAlianzaExperienciaAgricola xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <TipoActividadProductivaId>${alianzaExperienciaAgricolaModel.tipoActividadProductivaId}</TipoActividadProductivaId>
            <BeneficiarioId>${alianzaExperienciaAgricolaModel.beneficiarioId}</BeneficiarioId>
            <FrecuenciaId>${alianzaExperienciaAgricolaModel.frecuenciaId}</FrecuenciaId>
            <AreaCultivo>${alianzaExperienciaAgricolaModel.areaCultivo}</AreaCultivo>
            <CantidadProducida>${alianzaExperienciaAgricolaModel.cantidadProducida}</CantidadProducida>
            <CantidadVendida>${alianzaExperienciaAgricolaModel.cantidadVendida}</CantidadVendida>
            <CantidadAutoconsumo>${alianzaExperienciaAgricolaModel.cantidadAutoconsumo}</CantidadAutoconsumo>
            <CostoImplementacion>${alianzaExperienciaAgricolaModel.costoImplementacion}</CostoImplementacion>
            <ValorJornal>${alianzaExperienciaAgricolaModel.valorJornal}</ValorJornal>
            <TotalIngresoNeto>${alianzaExperienciaAgricolaModel.totalIngresoNeto}</TotalIngresoNeto>
            <AreaPasto>${alianzaExperienciaAgricolaModel.areaPasto}</AreaPasto>
            <AreaSinUso>${alianzaExperienciaAgricolaModel.areaSinUso}</AreaSinUso>
            <AreaReservaConservacion>${alianzaExperienciaAgricolaModel.areaReservaConservacion}</AreaReservaConservacion>
            <AreaImplementacion>${alianzaExperienciaAgricolaModel.areaImplementacion}</AreaImplementacion>
            <TotalAreaPredio>${alianzaExperienciaAgricolaModel.totalAreaPredio}</TotalAreaPredio>
          </objeto>
        </GuardarAlianzaExperienciaAgricola>
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
                    "${Constants.urlSOAP}/GuardarAlianzaExperienciaAgricola"
              },
              body: alianzaExperienciaAgricolaSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body>
                <GuardarAlianzaExperienciaAgricolaResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                    <GuardarAlianzaExperienciaAgricolaResult>
                        <respuesta>true</respuesta>
                        <mensaje>Transacción realizada correctamente</mensaje>
                        <registroId>-1</registroId>
                    </GuardarAlianzaExperienciaAgricolaResult>
                </GuardarAlianzaExperienciaAgricolaResponse>
            </soap:Body>
        </soap:Envelope>''', 200),
        );

        // act
        final saveAlianzaExperienciaAgricolaResult =
            await dataSource.saveAlianzaExperienciaAgricola(
                usuarioModel, alianzaExperienciaAgricolaModel);

        // assert
        expect(saveAlianzaExperienciaAgricolaResult,
            equals(alianzaExperienciaAgricolaModel));
      },
    );
  });
}
