import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/evaluacion_remote_ds.dart';
import 'package:paap/data/models/evaluacion_model.dart';
import 'package:paap/data/models/usuario_model.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late EvaluacionRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = EvaluacionRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('GuardarEvaluacion', () {
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

    final evaluacionModel = EvaluacionModel(
      evaluacionId: '1',
      perfilId: '1',
      resumen:
          't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters',
      fortalezas: 'Concepto Fortalezas',
      debilidades: 'Concepto Debilidades',
      riesgos:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
      finalizado: 'true',
      fechaEvaluacion: '2022-11-15T21:54:23.857+01:00',
      preAprobado: 'false',
    );

    final evaluacionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarEvaluacion xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <EvaluacionId>${evaluacionModel.evaluacionId}</EvaluacionId>
            <PerfilId>${evaluacionModel.perfilId}</PerfilId>
            <Resumen>${evaluacionModel.resumen}</Resumen>
            <Fortalezas>${evaluacionModel.fortalezas}</Fortalezas>
            <Debilidades>${evaluacionModel.debilidades}</Debilidades>
            <Riesgos>${evaluacionModel.riesgos}</Riesgos>
            <Finalizado>${evaluacionModel.finalizado}</Finalizado>
            <FechaEvaluacion>${evaluacionModel.fechaEvaluacion}</FechaEvaluacion>
            <PreAprobado>${evaluacionModel.preAprobado}</PreAprobado>
          </objeto>
        </GuardarEvaluacion>
      </soap:Body>
    </soap:Envelope>
    ''';

    final evaluacionPorPerfilSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
          <parametros>
            <string>TablaEvaluacionesPorPerfil</string>            
            <string>${evaluacionModel.perfilId}</string>            
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    test('debe retornar true cuando el status code sea 200', () async {
      // arrange
      when(
        mockHttpClient.post(uri,
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "SOAPAction": "${Constants.urlSOAP}/GuardarEvaluacion"
            },
            body: evaluacionSOAP),
      ).thenAnswer(
        (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body>
                <GuardarEvaluacionResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                    <GuardarEvaluacionResult>
                        <respuesta>true</respuesta>
                        <mensaje>Transacción realizada correctamente</mensaje>
                        <objeto xsi:type="Evaluaciones">
                            <EvaluacionId>1</EvaluacionId>
                            <PerfilId>1</PerfilId>
                            <Resumen>t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters</Resumen>
                            <Fortalezas>Concepto Fortalezas</Fortalezas>
                            <Debilidades>Concepto Debilidades</Debilidades>
                            <Riesgos>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s</Riesgos>
                            <Finalizado>true</Finalizado>
                            <FechaEvaluacion>2022-11-15T21:54:23.857+01:00</FechaEvaluacion>
                            <PreAprobado>false</PreAprobado>
                        </objeto>
                        <registroId>-1</registroId>
                    </GuardarEvaluacionResult>
                </GuardarEvaluacionResponse>
            </soap:Body>
        </soap:Envelope>''', 200),
      );

      // arrange
      when(
        mockHttpClient.post(uri,
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
            },
            body: evaluacionPorPerfilSOAP),
      ).thenAnswer(
        (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
          <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
              <soap:Body>
                  <ObtenerDatosResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                      <ObtenerDatosResult>
                          <respuesta>true</respuesta>
                          <mensaje>Transacción realizada correctamente</mensaje>
                          <datos>
                              <xs:schema id="NewDataSet" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
                                  <xs:element name="NewDataSet" msdata:IsDataSet="true" msdata:UseCurrentLocale="true">
                                      <xs:complexType>
                                          <xs:choice minOccurs="0" maxOccurs="unbounded">
                                              <xs:element name="Table">
                                                  <xs:complexType>
                                                      <xs:sequence>
                                                          <xs:element name="EvaluacionId" type="xs:long" minOccurs="0" />
                                                          <xs:element name="PerfilId" type="xs:int" minOccurs="0" />
                                                          <xs:element name="Resumen" type="xs:string" minOccurs="0" />
                                                          <xs:element name="Fortalezas" type="xs:string" minOccurs="0" />
                                                          <xs:element name="Debilidades" type="xs:string" minOccurs="0" />
                                                          <xs:element name="Riesgos" type="xs:string" minOccurs="0" />
                                                          <xs:element name="Finalizado" type="xs:boolean" minOccurs="0" />
                                                          <xs:element name="UsuarioIdCoordinador" type="xs:string" minOccurs="0" />
                                                          <xs:element name="FechaEvaluacion" type="xs:dateTime" minOccurs="0" />
                                                          <xs:element name="PreAprobado" type="xs:boolean" minOccurs="0" />
                                                      </xs:sequence>
                                                  </xs:complexType>
                                              </xs:element>
                                          </xs:choice>
                                      </xs:complexType>
                                  </xs:element>
                              </xs:schema>
                              <diffgr:diffgram xmlns:msdata="urn:schemas-microsoft-com:xml-msdata" xmlns:diffgr="urn:schemas-microsoft-com:xml-diffgram-v1">
                                  <NewDataSet xmlns="">
                                      <Table diffgr:id="Table1" msdata:rowOrder="0">
                                          <EvaluacionId>1</EvaluacionId>
                                          <PerfilId>1</PerfilId>
                                          <Resumen>t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters</Resumen>
                                          <Fortalezas>Concepto Fortalezas</Fortalezas>
                                          <Debilidades>Concepto Debilidades</Debilidades>
                                          <Riesgos>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s</Riesgos>
                                          <Finalizado>true</Finalizado>
                                          <UsuarioIdCoordinador>danny.duran@minagricultura.gov.co</UsuarioIdCoordinador>
                                          <FechaEvaluacion>2023-01-04T23:03:59.38+01:00</FechaEvaluacion>
                                          <PreAprobado>false</PreAprobado>
                                      </Table>
                                  </NewDataSet>
                              </diffgr:diffgram>
                          </datos>
                          <registroId>-1</registroId>
                      </ObtenerDatosResult>
                  </ObtenerDatosResponse>
              </soap:Body>
          </soap:Envelope>''', 200),
      );

      // act
      final saveEvaluacionResult =
          await dataSource.saveEvaluacion(usuarioModel, evaluacionModel);

      // assert
      expect(saveEvaluacionResult, equals(evaluacionModel));

      // act
      final saveEvaluacionPorPerfilResult = await dataSource
          .getEvaluacionPorPerfil(usuarioModel, evaluacionModel.perfilId);

      // assert
      expect(saveEvaluacionPorPerfilResult, equals(evaluacionModel));
    });
  });
}
