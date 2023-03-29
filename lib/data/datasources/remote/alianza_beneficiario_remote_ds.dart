import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/alianza_beneficiario_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/alianza_beneficiario_model.dart';
import '../../utils.dart';

abstract class AlianzaBeneficiarioRemoteDataSource {
  Future<List<AlianzaBeneficiarioModel>> getAlianzasBeneficiarios(
      UsuarioEntity usuario);
  Future<List<AlianzaBeneficiarioEntity>> saveAlianzasBeneficiarios(
      UsuarioEntity usuario,
      List<AlianzaBeneficiarioEntity>
          perfilesPreInversionesBeneficiariosEntity);
}

class AlianzaBeneficiarioRemoteDataSourceImpl
    implements AlianzaBeneficiarioRemoteDataSource {
  final http.Client client;

  AlianzaBeneficiarioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AlianzaBeneficiarioModel>> getAlianzasBeneficiarios(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final alianzasBeneficiariosSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Nombre>${usuario.nombre}</Nombre>
            <Apellido>${usuario.apellido}</Apellido>
            <Direccion>${usuario.direccion}</Direccion>
            <TelefonoFijo>${usuario.telefonoFijo}</TelefonoFijo>
            <TelefonoMovil>${usuario.telefonoMovil}</TelefonoMovil>
            <Correo>${usuario.correo}</Correo>
            <Contrasena>${usuario.contrasena}</Contrasena>
            <FechaActivacion>${usuario.fechaActivacion}</FechaActivacion>
            <FechaDesactivacion>${usuario.fechaDesactivacion}</FechaDesactivacion>
            <FechaCambio>${usuario.fechaCambio}</FechaCambio>
            <Activo>${usuario.activo}</Activo>
          </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaAlianzasBeneficiarios</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final alianzaBeneficiarioResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: alianzasBeneficiariosSOAP);

      if (alianzaBeneficiarioResp.statusCode == 200) {
        final alianzaBeneficiarioDoc =
            xml.XmlDocument.parse(alianzaBeneficiarioResp.body);

        final respuesta = alianzaBeneficiarioDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            alianzaBeneficiarioDoc.findAllElements('NewDataSet').isNotEmpty) {
          final xmlString = alianzaBeneficiarioDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final alianzasBeneficiariosRaw =
              decodedResp.entries.first.value['Table'];

          if (alianzasBeneficiariosRaw is List) {
            return List.from(alianzasBeneficiariosRaw)
                .map((e) => AlianzaBeneficiarioModel.fromJson(e))
                .toList();
          } else {
            return [
              AlianzaBeneficiarioModel.fromJson(alianzasBeneficiariosRaw)
            ];
          }
        } else {
          return [];
        }
      } else {
        throw ServerException();
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<List<AlianzaBeneficiarioEntity>> saveAlianzasBeneficiarios(
      UsuarioEntity usuario,
      List<AlianzaBeneficiarioEntity>
          perfilesPreInversionesBeneficiariosEntity) async {
    List<AlianzaBeneficiarioEntity> perfilesPreInversionesBeneficiariosUpload =
        [];
    for (var alianzaBeneficiario in perfilesPreInversionesBeneficiariosEntity) {
      final resp = await saveAlianzaBeneficiario(usuario, alianzaBeneficiario);
      if (resp != null) {
        perfilesPreInversionesBeneficiariosUpload.add(resp);
      }
    }
    return perfilesPreInversionesBeneficiariosUpload;
  }

  Future<AlianzaBeneficiarioEntity?> saveAlianzaBeneficiario(
      UsuarioEntity usuario,
      AlianzaBeneficiarioEntity alianzaBeneficiarioEntity) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      String dataConyuge = '';

      if (alianzaBeneficiarioEntity.estadoCivilId != '2' &&
          alianzaBeneficiarioEntity.estadoCivilId != '5') {
        dataConyuge = '''
            <ConyugeTipoIdentificacionId>1</ConyugeTipoIdentificacionId>
            <ConyugeId>${alianzaBeneficiarioEntity.beneficiarioId}</ConyugeId>
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
            <ConyugeTipoIdentificacionId>${alianzaBeneficiarioEntity.conyugeTipoIdentificacionId}</ConyugeTipoIdentificacionId>
            <ConyugeId>${alianzaBeneficiarioEntity.conyugeId}</ConyugeId>
            <ConyugeNombre1>${alianzaBeneficiarioEntity.conyugeNombre1}</ConyugeNombre1>
            <ConyugeNombre2>${alianzaBeneficiarioEntity.conyugeNombre2}</ConyugeNombre2>
            <ConyugeApellido1>${alianzaBeneficiarioEntity.conyugeApellido1}</ConyugeApellido1>
            <ConyugeApellido2>${alianzaBeneficiarioEntity.conyugeApellido2}</ConyugeApellido2>
            <ConyugeGeneroId>${alianzaBeneficiarioEntity.conyugeGeneroId}</ConyugeGeneroId>
            <ConyugeFechaExpedicionDocumento>${alianzaBeneficiarioEntity.conyugeFechaExpedicionDocumento}</ConyugeFechaExpedicionDocumento>
            <ConyugeGrupoEspecialId>${alianzaBeneficiarioEntity.conyugeGrupoEspecialId}</ConyugeGrupoEspecialId>
            <ConyugeFechaNacimiento>${alianzaBeneficiarioEntity.conyugeFechaNacimiento}</ConyugeFechaNacimiento>
            <ConyugeIngresosMensuales>${alianzaBeneficiarioEntity.conyugeIngresosMensuales}</ConyugeIngresosMensuales>
      ''';
      }

      final alianzaBeneficiarioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarAlianzaBeneficiario xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Nombre>${usuario.nombre}</Nombre>
            <Apellido>${usuario.apellido}</Apellido>
            <Direccion>${usuario.direccion}</Direccion>
            <TelefonoFijo>${usuario.telefonoFijo}</TelefonoFijo>
            <TelefonoMovil>${usuario.telefonoMovil}</TelefonoMovil>
            <Correo>${usuario.correo}</Correo>
            <Contrasena>${usuario.contrasena}</Contrasena>
            <FechaActivacion>${usuario.fechaActivacion}</FechaActivacion>
            <FechaDesactivacion>${usuario.fechaDesactivacion}</FechaDesactivacion>
            <FechaCambio>${usuario.fechaCambio}</FechaCambio>
            <Activo>${usuario.activo}</Activo>
          </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <AlianzaId>${alianzaBeneficiarioEntity.alianzaId}</AlianzaId>
            <BeneficiarioId>${alianzaBeneficiarioEntity.beneficiarioId}</BeneficiarioId>
            <MunicipioId>${alianzaBeneficiarioEntity.municipioId}</MunicipioId>
            <VeredaId>${alianzaBeneficiarioEntity.veredaId}</VeredaId>
            <AreaFinca>${alianzaBeneficiarioEntity.areaFinca}</AreaFinca>
            <AreaProyecto>${alianzaBeneficiarioEntity.areaProyecto}</AreaProyecto>
            <TipoTenenciaId>${alianzaBeneficiarioEntity.tipoTenenciaId}</TipoTenenciaId>
            <Experiencia>${alianzaBeneficiarioEntity.experiencia}</Experiencia>
            <Asociado>${alianzaBeneficiarioEntity.asociado}</Asociado>
            <ConocePerfil>${alianzaBeneficiarioEntity.conocePerfil}</ConocePerfil>
            <FueBeneficiado>${alianzaBeneficiarioEntity.fueBeneficiado}</FueBeneficiado>
            <CualBeneficio>${alianzaBeneficiarioEntity.cualBeneficio}</CualBeneficio>
            <Activo>${alianzaBeneficiarioEntity.activo}</Activo>
            <MiembrosHogar>${alianzaBeneficiarioEntity.miembrosHogar}</MiembrosHogar>
            <MiembrosEcoActivos>${alianzaBeneficiarioEntity.miembrosEcoActivos}</MiembrosEcoActivos>
            <ResidenciaId>${alianzaBeneficiarioEntity.residenciaId}</ResidenciaId>
            <AccesoExplotacionTierra>${alianzaBeneficiarioEntity.accesoExplotacionTierra}</AccesoExplotacionTierra>
            <GastosMensuales>${alianzaBeneficiarioEntity.gastosMensuales}</GastosMensuales>
            <MesesAsociado>${alianzaBeneficiarioEntity.mesesAsociado}</MesesAsociado>
            <NombreOrganizacion>${alianzaBeneficiarioEntity.nombreOrganizacion}</NombreOrganizacion>
            <ActivoInmobiliario>${alianzaBeneficiarioEntity.activoInmobiliario}</ActivoInmobiliario>
            <ActivoFinanciero>${alianzaBeneficiarioEntity.activoFinanciero}</ActivoFinanciero>
            <ActivoProductivo>${alianzaBeneficiarioEntity.activoProductivo}</ActivoProductivo>
            <ActivoCorriente>${alianzaBeneficiarioEntity.activoCorriente}</ActivoCorriente>
            <Nota>${alianzaBeneficiarioEntity.nota}</Nota>
            <NombreFinca>${alianzaBeneficiarioEntity.nombreFinca}</NombreFinca>
            <NivelEscolarId>${alianzaBeneficiarioEntity.nivelEscolarId}</NivelEscolarId>
            <CotizanteBEPS>${alianzaBeneficiarioEntity.cotizanteBeps}</CotizanteBEPS>
            <EstadoCivilId>${alianzaBeneficiarioEntity.estadoCivilId}</EstadoCivilId>
            <CalificacionSISBEN>${alianzaBeneficiarioEntity.calificacionSisben}</CalificacionSISBEN>
            <IngresosMensuales>${alianzaBeneficiarioEntity.ingresosMensuales}</IngresosMensuales>
            <TipoDiscapacidadId>${alianzaBeneficiarioEntity.tipoDiscapacidadId}</TipoDiscapacidadId>
            <ActividadEconomicaId>${alianzaBeneficiarioEntity.actividadEconomicaId}</ActividadEconomicaId>
            <IngresosDiarios>${alianzaBeneficiarioEntity.ingresosDiarios}</IngresosDiarios>
            <DiasTrabajo>${alianzaBeneficiarioEntity.diasTrabajo}</DiasTrabajo>
            <Longitud>${alianzaBeneficiarioEntity.longitud}</Longitud>
            <Latitud>${alianzaBeneficiarioEntity.latitud}</Latitud>
            <CedulaCatastral>${alianzaBeneficiarioEntity.cedulaCatastral}</CedulaCatastral>
            <BeneficioId>${alianzaBeneficiarioEntity.beneficioId}</BeneficioId>
            $dataConyuge
          </objeto>
        </GuardarAlianzaBeneficiario>
      </soap:Body>
    </soap:Envelope>
    ''';

      final alianzaBeneficiarioResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/GuardarAlianzaBeneficiario"
          },
          body: alianzaBeneficiarioSOAP);

      if (alianzaBeneficiarioResp.statusCode == 200) {
        final alianzaBeneficiarioDoc =
            xml.XmlDocument.parse(alianzaBeneficiarioResp.body);

        final respuesta = alianzaBeneficiarioDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          return alianzaBeneficiarioEntity;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
