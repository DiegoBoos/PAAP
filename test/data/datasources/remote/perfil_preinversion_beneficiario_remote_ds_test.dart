import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paap/data/constants.dart';
import 'package:paap/data/datasources/remote/perfil_preinversion_beneficiario_remote_ds.dart';
import 'package:paap/data/models/perfil_preinversion_beneficiario_model.dart';
import 'package:paap/data/models/usuario_model.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late PerfilPreInversionBeneficiarioRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = PerfilPreInversionBeneficiarioRemoteDataSourceImpl(
        client: mockHttpClient);
  });

  group('GuardarPerfilPreInversionBeneficiario', () {
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

    final perfilPreInversionBeneficiarioModel =
        PerfilPreInversionBeneficiarioModel(
      perfilPreInversionId: '1',
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

    if (perfilPreInversionBeneficiarioModel.estadoCivilId != '2' &&
        perfilPreInversionBeneficiarioModel.estadoCivilId != '5') {
      dataConyuge = '''
            <ConyugeTipoIdentificacionId>1</ConyugeTipoIdentificacionId>
            <ConyugeId>${perfilPreInversionBeneficiarioModel.beneficiarioId}</ConyugeId>
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
            <ConyugeTipoIdentificacionId>${perfilPreInversionBeneficiarioModel.conyugeTipoIdentificacionId}</ConyugeTipoIdentificacionId>
            <ConyugeId>${perfilPreInversionBeneficiarioModel.conyugeId}</ConyugeId>
            <ConyugeNombre1>${perfilPreInversionBeneficiarioModel.conyugeNombre1}</ConyugeNombre1>
            <ConyugeNombre2>${perfilPreInversionBeneficiarioModel.conyugeNombre2}</ConyugeNombre2>
            <ConyugeApellido1>${perfilPreInversionBeneficiarioModel.conyugeApellido1}</ConyugeApellido1>
            <ConyugeApellido2>${perfilPreInversionBeneficiarioModel.conyugeApellido2}</ConyugeApellido2>
            <ConyugeGeneroId>${perfilPreInversionBeneficiarioModel.conyugeGeneroId}</ConyugeGeneroId>
            <ConyugeFechaExpedicionDocumento>${perfilPreInversionBeneficiarioModel.conyugeFechaExpedicionDocumento}</ConyugeFechaExpedicionDocumento>
            <ConyugeGrupoEspecialId>${perfilPreInversionBeneficiarioModel.conyugeGrupoEspecialId}</ConyugeGrupoEspecialId>
            <ConyugeFechaNacimiento>${perfilPreInversionBeneficiarioModel.conyugeFechaNacimiento}</ConyugeFechaNacimiento>
            <ConyugeIngresosMensuales>${perfilPreInversionBeneficiarioModel.conyugeIngresosMensuales}</ConyugeIngresosMensuales>
      ''';
    }

    final perfilPreInversionBeneficiarioSOAP =
        '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionBeneficiario xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionBeneficiarioModel.perfilPreInversionId}</PerfilPreInversionId>
            <BeneficiarioId>${perfilPreInversionBeneficiarioModel.beneficiarioId}</BeneficiarioId>
            <MunicipioId>${perfilPreInversionBeneficiarioModel.municipioId}</MunicipioId>
            <VeredaId>${perfilPreInversionBeneficiarioModel.veredaId}</VeredaId>
            <AreaFinca>${perfilPreInversionBeneficiarioModel.areaFinca}</AreaFinca>
            <AreaProyecto>${perfilPreInversionBeneficiarioModel.areaProyecto}</AreaProyecto>
            <TipoTenenciaId>${perfilPreInversionBeneficiarioModel.tipoTenenciaId}</TipoTenenciaId>
            <Experiencia>${perfilPreInversionBeneficiarioModel.experiencia}</Experiencia>
            <Asociado>${perfilPreInversionBeneficiarioModel.asociado}</Asociado>
            <ConocePerfil>${perfilPreInversionBeneficiarioModel.conocePerfil}</ConocePerfil>
            <FueBeneficiado>${perfilPreInversionBeneficiarioModel.fueBeneficiado}</FueBeneficiado>
            <CualBeneficio>${perfilPreInversionBeneficiarioModel.cualBeneficio}</CualBeneficio>
            <Activo>${perfilPreInversionBeneficiarioModel.activo}</Activo>
            <MiembrosHogar>${perfilPreInversionBeneficiarioModel.miembrosHogar}</MiembrosHogar>
            <MiembrosEcoActivos>${perfilPreInversionBeneficiarioModel.miembrosEcoActivos}</MiembrosEcoActivos>
            <ResidenciaId>${perfilPreInversionBeneficiarioModel.residenciaId}</ResidenciaId>
            <AccesoExplotacionTierra>${perfilPreInversionBeneficiarioModel.accesoExplotacionTierra}</AccesoExplotacionTierra>
            <GastosMensuales>${perfilPreInversionBeneficiarioModel.gastosMensuales}</GastosMensuales>
            <MesesAsociado>${perfilPreInversionBeneficiarioModel.mesesAsociado}</MesesAsociado>
            <NombreOrganizacion>${perfilPreInversionBeneficiarioModel.nombreOrganizacion}</NombreOrganizacion>
            <ActivoInmobiliario>${perfilPreInversionBeneficiarioModel.activoInmobiliario}</ActivoInmobiliario>
            <ActivoFinanciero>${perfilPreInversionBeneficiarioModel.activoFinanciero}</ActivoFinanciero>
            <ActivoProductivo>${perfilPreInversionBeneficiarioModel.activoProductivo}</ActivoProductivo>
            <ActivoCorriente>${perfilPreInversionBeneficiarioModel.activoCorriente}</ActivoCorriente>
            <Nota>${perfilPreInversionBeneficiarioModel.nota}</Nota>
            <NombreFinca>${perfilPreInversionBeneficiarioModel.nombreFinca}</NombreFinca>
            <NivelEscolarId>${perfilPreInversionBeneficiarioModel.nivelEscolarId}</NivelEscolarId>
            <CotizanteBEPS>${perfilPreInversionBeneficiarioModel.cotizanteBeps}</CotizanteBEPS>
            <EstadoCivilId>${perfilPreInversionBeneficiarioModel.estadoCivilId}</EstadoCivilId>
            <CalificacionSISBEN>${perfilPreInversionBeneficiarioModel.calificacionSisben}</CalificacionSISBEN>
            <IngresosMensuales>${perfilPreInversionBeneficiarioModel.ingresosMensuales}</IngresosMensuales>
            <TipoDiscapacidadId>${perfilPreInversionBeneficiarioModel.tipoDiscapacidadId}</TipoDiscapacidadId>
            <ActividadEconomicaId>${perfilPreInversionBeneficiarioModel.actividadEconomicaId}</ActividadEconomicaId>
            <IngresosDiarios>${perfilPreInversionBeneficiarioModel.ingresosDiarios}</IngresosDiarios>
            <DiasTrabajo>${perfilPreInversionBeneficiarioModel.diasTrabajo}</DiasTrabajo>
            <Longitud>${perfilPreInversionBeneficiarioModel.longitud}</Longitud>
            <Latitud>${perfilPreInversionBeneficiarioModel.latitud}</Latitud>
            <CedulaCatastral>${perfilPreInversionBeneficiarioModel.cedulaCatastral}</CedulaCatastral>
            $dataConyuge
          </objeto>
        </GuardarPerfilPreInversionBeneficiario>
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
                    "${Constants.urlSOAP}/GuardarPerfilPreInversionBeneficiario"
              },
              body: perfilPreInversionBeneficiarioSOAP),
        ).thenAnswer(
          (_) async => http.Response('''<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <soap:Body>
                <GuardarPerfilPreInversionBeneficiarioResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
                    <GuardarPerfilPreInversionBeneficiarioResult>
                        <respuesta>true</respuesta>
                        <mensaje>Transacción realizada correctamente</mensaje>
                        <registroId>-1</registroId>
                    </GuardarPerfilPreInversionBeneficiarioResult>
                </GuardarPerfilPreInversionBeneficiarioResponse>
            </soap:Body>
        </soap:Envelope>''', 200),
        );

        // act
        final savePerfilPreInversionBeneficiarioResult =
            await dataSource.savePerfilPreInversionBeneficiario(
                usuarioModel, perfilPreInversionBeneficiarioModel);

        // assert
        expect(savePerfilPreInversionBeneficiarioResult,
            equals(perfilPreInversionBeneficiarioModel));
      },
    );
  });
}
