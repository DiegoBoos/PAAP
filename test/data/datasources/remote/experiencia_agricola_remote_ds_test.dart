import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/experiencia_agricola_remote_ds.dart';
import 'package:paap/data/models/experiencia_agricola_model.dart';
import 'package:paap/data/models/usuario_model.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late ExperienciaAgricolaRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource =
        ExperienciaAgricolaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('GuardarExperienciaAgricola', () {
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

    final experienciaAgricolaModel = ExperienciaAgricolaModel(
        tipoActividadProductivaId: '1',
        beneficiarioId: '0',
        frecuenciaId: '1',
        areaCultivo: '100.00',
        cantidadProducida: '200.00',
        cantidadVendida: '100.00',
        cantidadAutoconsumo: '100.00',
        costoImplementacion: '240.00',
        valorJornal: '100.00',
        totalIngresoNeto: '200.00',
        areaPasto: '100.00',
        areaSinUso: '200.00',
        areaReservaConservacion: '300.00',
        areaImplementacion: '400.00',
        totalAreaPredio: '100.00');

    final experienciaAgricolaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarExperienciaAgricola xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <TipoActividadProductivaId>${experienciaAgricolaModel.tipoActividadProductivaId}</TipoActividadProductivaId>
            <BeneficiarioId>${experienciaAgricolaModel.beneficiarioId}</BeneficiarioId>
            <FrecuenciaId>${experienciaAgricolaModel.frecuenciaId}</FrecuenciaId>
            <AreaCultivo>${experienciaAgricolaModel.areaCultivo}</AreaCultivo>
            <CantidadProducida>${experienciaAgricolaModel.cantidadProducida}</CantidadProducida>
            <CantidadVendida>${experienciaAgricolaModel.cantidadVendida}</CantidadVendida>
            <CantidadAutoconsumo>${experienciaAgricolaModel.cantidadAutoconsumo}</CantidadAutoconsumo>
            <CostoImplementacion>${experienciaAgricolaModel.costoImplementacion}</CostoImplementacion>
            <ValorJornal>${experienciaAgricolaModel.valorJornal}</ValorJornal>
            <TotalIngresoNeto>${experienciaAgricolaModel.totalIngresoNeto}</TotalIngresoNeto>
            <AreaPasto>${experienciaAgricolaModel.areaPasto}</AreaPasto>
            <AreaSinUso>${experienciaAgricolaModel.areaSinUso}</AreaSinUso>
            <AreaReservaConservacion>${experienciaAgricolaModel.areaReservaConservacion}</AreaReservaConservacion>
            <AreaImplementacion>${experienciaAgricolaModel.areaImplementacion}</AreaImplementacion>
            <TotalAreaPredio>${experienciaAgricolaModel.totalAreaPredio}</TotalAreaPredio>
            
          </objeto>
        </GuardarExperienciaAgricola>
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
                "SOAPAction": "${Constants.urlSOAP}/GuardarExperienciaAgricola"
              },
              body: experienciaAgricolaSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body>
                <GuardarExperienciaAgricolaResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                    <GuardarExperienciaAgricolaResult>
                        <respuesta>true</respuesta>
                        <mensaje>Transacción realizada correctamente</mensaje>
                        <registroId>-1</registroId>
                    </GuardarExperienciaAgricolaResult>
                </GuardarExperienciaAgricolaResponse>
            </soap:Body>
        </soap:Envelope>''', 200),
        );

        // act
        final saveExperienciaAgricolaResult = await dataSource
            .saveExperienciaAgricola(usuarioModel, experienciaAgricolaModel);

        // assert
        expect(saveExperienciaAgricolaResult, equals(experienciaAgricolaModel));
      },
    );
  });
}
