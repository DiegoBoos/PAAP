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

    final alianzaBeneficiarioModel = AlianzaBeneficiarioModel(
      alianzaId: '',
      beneficiarioId: '',
      municipioId: '',
      veredaId: '',
      areaFinca: '',
      areaProyecto: '',
      tipoTenenciaId: '',
      experiencia: '',
      asociado: '',
      conocePerfil: '',
      fueBeneficiado: '',
      cualBeneficio: '',
      activo: '',
      miembrosHogar: '',
      miembrosEcoActivos: '',
      residenciaId: '',
      accesoExplotacionTierra: '',
      gastosMensuales: '',
      mesesAsociado: '',
      nombreOrganizacion: '',
      activoInmobiliario: '',
      activoFinanciero: '',
      activoProductivo: '',
      activoCorriente: '',
      nota: '',
      nombreFinca: '',
      tipoDiscapacidadId: '',
      nivelEscolarId: '',
      cotizanteBeps: '',
      estadoCivilId: '',
      conyugeNombre1: '',
      conyugeFechaNacimiento: '',
      conyugeIngresosMensuales: '',
      calificacionSisben: '',
      ingresosMensuales: '',
      conyugeNombre2: '',
      conyugeApellido1: '',
      conyugeApellido2: '',
      conyugeGeneroId: '',
      conyugeFechaExpedicionDocumento: '',
      conyugeGrupoEspecialId: '',
      actividadEconomicaId: '',
      ingresosDiarios: '',
      diasTrabajo: '',
      conyugeTipoIdentificacionId: '',
      conyugeId: '',
      longitud: '',
      latitud: '',
      cedulaCatastral: '',
      beneficioId: '',
    );

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
            <TipoDiscapacidadId>${alianzaBeneficiarioModel.tipoDiscapacidadId}</TipoDiscapacidadId>
            <NivelEscolarId>${alianzaBeneficiarioModel.nivelEscolarId}</NivelEscolarId>
            <CotizanteBEPS>${alianzaBeneficiarioModel.cotizanteBeps}</CotizanteBEPS>
            <EstadoCivilId>${alianzaBeneficiarioModel.estadoCivilId}</EstadoCivilId>
            <ConyugeNombre1>${alianzaBeneficiarioModel.conyugeNombre1}</ConyugeNombre1>
            <ConyugeFechaNacimiento>${alianzaBeneficiarioModel.conyugeFechaNacimiento}</ConyugeFechaNacimiento>
            <ConyugeIngresosMensuales>${alianzaBeneficiarioModel.conyugeIngresosMensuales}</ConyugeIngresosMensuales>
            <CalificacionSISBEN>${alianzaBeneficiarioModel.calificacionSisben}</CalificacionSISBEN>
            <IngresosMensuales>${alianzaBeneficiarioModel.ingresosMensuales}</IngresosMensuales>
            <ConyugeNombre2>${alianzaBeneficiarioModel.conyugeNombre2}</ConyugeNombre2>
            <ConyugeApellido1>${alianzaBeneficiarioModel.conyugeApellido1}</ConyugeApellido1>
            <ConyugeApellido2>${alianzaBeneficiarioModel.conyugeApellido2}</ConyugeApellido2>
            <ConyugeGeneroId>${alianzaBeneficiarioModel.conyugeGeneroId}</ConyugeGeneroId>
            <ConyugeFechaExpedicionDocumento>${alianzaBeneficiarioModel.conyugeFechaExpedicionDocumento}</ConyugeFechaExpedicionDocumento>
            <ConyugeGrupoEspecialId>${alianzaBeneficiarioModel.conyugeGrupoEspecialId}</ConyugeGrupoEspecialId>
            <ActividadEconomicaId>${alianzaBeneficiarioModel.actividadEconomicaId}</ActividadEconomicaId>
            <IngresosDiarios>${alianzaBeneficiarioModel.ingresosDiarios}</IngresosDiarios>
            <DiasTrabajo>${alianzaBeneficiarioModel.diasTrabajo}</DiasTrabajo>
            <ConyugeTipoIdentificacionId>${alianzaBeneficiarioModel.conyugeTipoIdentificacionId}</ConyugeTipoIdentificacionId>
            <ConyugeId>${alianzaBeneficiarioModel.conyugeId}</ConyugeId>
            <Longitud>${alianzaBeneficiarioModel.longitud}</Longitud>
            <Latitud>${alianzaBeneficiarioModel.latitud}</Latitud>
            <CedulaCatastral>${alianzaBeneficiarioModel.cedulaCatastral}</CedulaCatastral>
            <BeneficioId>${alianzaBeneficiarioModel.beneficioId}</BeneficioId>
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
          (_) async => http.Response(
              '''<GuardarAlianzaBeneficiarioResponse xmlns="http://alianzasproductivas.minagricultura.gov.co/">
            <GuardarAlianzaBeneficiarioResult>
                <respuesta>true</respuesta>
                <mensaje>Transacción realizada correctamente</mensaje>
                <registroId>-1</registroId>
            </GuardarAlianzaBeneficiarioResult>
        </GuardarAlianzaBeneficiarioResponse>''', 200),
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
