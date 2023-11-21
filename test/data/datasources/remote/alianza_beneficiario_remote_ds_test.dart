import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/alianza_beneficiario_remote_ds.dart';
import 'package:paap/data/models/alianza_beneficiario_model.dart';
import 'package:paap/data/models/usuario_model.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late AlianzaBeneficiarioRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource =
        AlianzaBeneficiarioRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('GuardarAlianzaBeneficiario', () {
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

    final alianzaBeneficiarioModel = AlianzaBeneficiarioModel(
      alianzaId: '1',
      beneficiarioId: '0',
      municipioId: '91001',
      veredaId: '34485',
      areaFinca: '1.00',
      areaProyecto: '2.00',
      tipoTenenciaId: '1',
      experiencia: '1',
      asociado: 'true',
      conocePerfil: 'true',
      fueBeneficiado: 'true',
      cualBeneficio: 'fdasf',
      activo: 'true',
      miembrosHogar: '1',
      miembrosEcoActivos: '1',
      residenciaId: '1',
      accesoExplotacionTierra: 'false',
      gastosMensuales: '1',
      mesesAsociado: '1',
      nombreOrganizacion: 'fsda1',
      activoInmobiliario: '1.00',
      activoFinanciero: '1.00',
      activoProductivo: '1.00',
      activoCorriente: '1.00',
      nota: 'rrrrrr',
      nombreFinca: 'fsad',
      tipoDiscapacidadId: '1',
      nivelEscolarId: '1',
      cotizanteBeps: 'false',
      estadoCivilId: '2',
      calificacionSisben: '3',
      ingresosMensuales: '2',
      actividadEconomicaId: '1',
      ingresosDiarios: '2',
      diasTrabajo: '2',
      longitud: '4.000000',
      latitud: '3.000000',
      cedulaCatastral: '231',
      beneficioId: '8',
      conyugeTipoIdentificacionId: '1',
      conyugeId: '23423',
      conyugeNombre1: 'aasf',
      conyugeNombre2: 'fdsfds',
      conyugeApellido1: 'asdfre',
      conyugeApellido2: '',
      conyugeGeneroId: '2',
      conyugeFechaExpedicionDocumento: '2022-12-16T00:00:00+01:00',
      conyugeGrupoEspecialId: '1',
      conyugeFechaNacimiento: '2022-12-16T00:00:00+01:00',
      conyugeIngresosMensuales: '12313',
    );

    String dataConyuge = '';

    if (alianzaBeneficiarioModel.estadoCivilId != '2' &&
        alianzaBeneficiarioModel.estadoCivilId != '5') {
      dataConyuge = '''
            <ConyugeTipoIdentificacionId>1</ConyugeTipoIdentificacionId>
            <ConyugeId>${alianzaBeneficiarioModel.beneficiarioId}</ConyugeId>
            <ConyugeNombre1></ConyugeNombre1>
            <ConyugeNombre2></ConyugeNombre2>
            <ConyugeApellido1></ConyugeApellido1>
            <ConyugeApellido2></ConyugeApellido2>
            <ConyugeGeneroId>1</ConyugeGeneroId>
            <ConyugeFechaExpedicionDocumento>1900-01-01T00:00:00+01:00</ConyugeFechaExpedicionDocumento>
            <ConyugeGrupoEspecialId>1</ConyugeGrupoEspecialId>
            <ConyugeFechaNacimiento>1900-01-01T00:00:00+01:00</ConyugeFechaNacimiento>
            <ConyugeIngresosMensuales>0</ConyugeIngresosMensuales>
      ''';
    } else {
      dataConyuge = '''
            <ConyugeTipoIdentificacionId>${alianzaBeneficiarioModel.conyugeTipoIdentificacionId}</ConyugeTipoIdentificacionId>
            <ConyugeId>${alianzaBeneficiarioModel.conyugeId}</ConyugeId>
            <ConyugeNombre1>${alianzaBeneficiarioModel.conyugeNombre1}</ConyugeNombre1>
            <ConyugeNombre2>${alianzaBeneficiarioModel.conyugeNombre2}</ConyugeNombre2>
            <ConyugeApellido1>${alianzaBeneficiarioModel.conyugeApellido1}</ConyugeApellido1>
            <ConyugeApellido2>${alianzaBeneficiarioModel.conyugeApellido2}</ConyugeApellido2>
            <ConyugeGeneroId>${alianzaBeneficiarioModel.conyugeGeneroId}</ConyugeGeneroId>
            <ConyugeFechaExpedicionDocumento>${alianzaBeneficiarioModel.conyugeFechaExpedicionDocumento}</ConyugeFechaExpedicionDocumento>
            <ConyugeGrupoEspecialId>${alianzaBeneficiarioModel.conyugeGrupoEspecialId}</ConyugeGrupoEspecialId>
            <ConyugeFechaNacimiento>${alianzaBeneficiarioModel.conyugeFechaNacimiento}</ConyugeFechaNacimiento>
            <ConyugeIngresosMensuales>${alianzaBeneficiarioModel.conyugeIngresosMensuales}</ConyugeIngresosMensuales>
      ''';
    }

    final alianzaBeneficiarioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarAlianzaBeneficiario xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <AlianzaId>${alianzaBeneficiarioModel.alianzaId}</AlianzaId>
            <BeneficiarioId>${alianzaBeneficiarioModel.beneficiarioId}</BeneficiarioId>
            <MunicipioId>${alianzaBeneficiarioModel.municipioId}</MunicipioId>
            <VeredaId>${alianzaBeneficiarioModel.veredaId}</VeredaId>
            <AreaFinca>${alianzaBeneficiarioModel.areaFinca}</AreaFinca>
            <AreaProyecto>${alianzaBeneficiarioModel.areaProyecto}</AreaProyecto>
            <TipoTenenciaId>${alianzaBeneficiarioModel.tipoTenenciaId}</TipoTenenciaId>
            <Experiencia>${alianzaBeneficiarioModel.experiencia}</Experiencia>
            <Asociado>${alianzaBeneficiarioModel.asociado}</Asociado>
            <ConocePerfil>${alianzaBeneficiarioModel.conocePerfil}</ConocePerfil>
            <FueBeneficiado>${alianzaBeneficiarioModel.fueBeneficiado}</FueBeneficiado>
            <CualBeneficio>${alianzaBeneficiarioModel.cualBeneficio}</CualBeneficio>
            <Activo>${alianzaBeneficiarioModel.activo}</Activo>
            <MiembrosHogar>${alianzaBeneficiarioModel.miembrosHogar}</MiembrosHogar>
            <MiembrosEcoActivos>${alianzaBeneficiarioModel.miembrosEcoActivos}</MiembrosEcoActivos>
            <ResidenciaId>${alianzaBeneficiarioModel.residenciaId}</ResidenciaId>
            <AccesoExplotacionTierra>${alianzaBeneficiarioModel.accesoExplotacionTierra}</AccesoExplotacionTierra>
            <GastosMensuales>${alianzaBeneficiarioModel.gastosMensuales}</GastosMensuales>
            <MesesAsociado>${alianzaBeneficiarioModel.mesesAsociado}</MesesAsociado>
            <NombreOrganizacion>${alianzaBeneficiarioModel.nombreOrganizacion}</NombreOrganizacion>
            <ActivoInmobiliario>${alianzaBeneficiarioModel.activoInmobiliario}</ActivoInmobiliario>
            <ActivoFinanciero>${alianzaBeneficiarioModel.activoFinanciero}</ActivoFinanciero>
            <ActivoProductivo>${alianzaBeneficiarioModel.activoProductivo}</ActivoProductivo>
            <ActivoCorriente>${alianzaBeneficiarioModel.activoCorriente}</ActivoCorriente>
            <Nota>${alianzaBeneficiarioModel.nota}</Nota>
            <NombreFinca>${alianzaBeneficiarioModel.nombreFinca}</NombreFinca>
            <NivelEscolarId>${alianzaBeneficiarioModel.nivelEscolarId}</NivelEscolarId>
            <CotizanteBEPS>${alianzaBeneficiarioModel.cotizanteBeps}</CotizanteBEPS>
            <EstadoCivilId>${alianzaBeneficiarioModel.estadoCivilId}</EstadoCivilId>
            <CalificacionSISBEN>${alianzaBeneficiarioModel.calificacionSisben}</CalificacionSISBEN>
            <IngresosMensuales>${alianzaBeneficiarioModel.ingresosMensuales}</IngresosMensuales>
            <TipoDiscapacidadId>${alianzaBeneficiarioModel.tipoDiscapacidadId}</TipoDiscapacidadId>
            <ActividadEconomicaId>${alianzaBeneficiarioModel.actividadEconomicaId}</ActividadEconomicaId>
            <IngresosDiarios>${alianzaBeneficiarioModel.ingresosDiarios}</IngresosDiarios>
            <DiasTrabajo>${alianzaBeneficiarioModel.diasTrabajo}</DiasTrabajo>
            <Longitud>${alianzaBeneficiarioModel.longitud}</Longitud>
            <Latitud>${alianzaBeneficiarioModel.latitud}</Latitud>
            <CedulaCatastral>${alianzaBeneficiarioModel.cedulaCatastral}</CedulaCatastral>
            <BeneficioId>${alianzaBeneficiarioModel.beneficioId}</BeneficioId>
            $dataConyuge
          </objeto>
        </GuardarAlianzaBeneficiario>
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
                "SOAPAction": "${Constants.urlSOAP}/GuardarAlianzaBeneficiario"
              },
              body: alianzaBeneficiarioSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body>
                <GuardarAlianzaBeneficiarioResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                    <GuardarAlianzaBeneficiarioResult>
                        <respuesta>true</respuesta>
                        <mensaje>Transacción realizada correctamente</mensaje>
                        <registroId>-1</registroId>
                    </GuardarAlianzaBeneficiarioResult>
                </GuardarAlianzaBeneficiarioResponse>
            </soap:Body>
        </soap:Envelope>''', 200),
        );

        // act
        final saveAlianzaBeneficiarioResult = await dataSource
            .saveAlianzaBeneficiario(usuarioModel, alianzaBeneficiarioModel);

        // assert
        expect(saveAlianzaBeneficiarioResult, equals(alianzaBeneficiarioModel));
      },
    );
  });
}
