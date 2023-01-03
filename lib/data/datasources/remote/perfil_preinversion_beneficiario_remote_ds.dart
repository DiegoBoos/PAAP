import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/entities/perfil_preinversion_beneficiario_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';

import '../../models/perfil_preinversion_beneficiario_model.dart';
import '../../utils.dart';

abstract class PerfilPreInversionBeneficiarioRemoteDataSource {
  Future<List<PerfilPreInversionBeneficiarioModel>>
      getPerfilPreInversionBeneficiarios(UsuarioEntity usuario);
  Future<List<PerfilPreInversionBeneficiarioEntity>>
      savePerfilesPreInversionesBeneficiarios(
          UsuarioEntity usuario,
          List<PerfilPreInversionBeneficiarioEntity>
              perfilesPreInversionesBeneficiariosEntity);
}

class PerfilPreInversionBeneficiarioRemoteDataSourceImpl
    implements PerfilPreInversionBeneficiarioRemoteDataSource {
  final http.Client client;

  PerfilPreInversionBeneficiarioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreInversionBeneficiarioModel>>
      getPerfilPreInversionBeneficiarios(UsuarioEntity usuario) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final perfilPreInversionBeneficiariosSOAP =
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
            <string>TablaPerfilesPreInversionesBeneficiarios</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilPreInversionBeneficiarioResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: perfilPreInversionBeneficiariosSOAP);

      if (perfilPreInversionBeneficiarioResp.statusCode == 200) {
        final perfilPreInversionBeneficiarioDoc =
            xml.XmlDocument.parse(perfilPreInversionBeneficiarioResp.body);

        final respuesta = perfilPreInversionBeneficiarioDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            perfilPreInversionBeneficiarioDoc
                .findAllElements('NewDataSet')
                .isNotEmpty) {
          final xmlString = perfilPreInversionBeneficiarioDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final perfilPreInversionBeneficiariosRaw =
              decodedResp.entries.first.value['Table'];

          if (perfilPreInversionBeneficiariosRaw is List) {
            return List.from(perfilPreInversionBeneficiariosRaw)
                .map((e) => PerfilPreInversionBeneficiarioModel.fromJson(e))
                .toList();
          } else {
            return [
              PerfilPreInversionBeneficiarioModel.fromJson(
                  perfilPreInversionBeneficiariosRaw)
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
  Future<List<PerfilPreInversionBeneficiarioEntity>>
      savePerfilesPreInversionesBeneficiarios(
          UsuarioEntity usuario,
          List<PerfilPreInversionBeneficiarioEntity>
              perfilesPreInversionesBeneficiariosEntity) async {
    List<PerfilPreInversionBeneficiarioEntity>
        perfilesPreInversionesBeneficiariosUpload = [];
    for (var perfilPreInversionBeneficiario
        in perfilesPreInversionesBeneficiariosEntity) {
      final resp = await savePerfilPreInversionBeneficiario(
          usuario, perfilPreInversionBeneficiario);
      if (resp != null) {
        perfilesPreInversionesBeneficiariosUpload.add(resp);
      }
    }
    return perfilesPreInversionesBeneficiariosUpload;
  }

  Future<PerfilPreInversionBeneficiarioEntity?>
      savePerfilPreInversionBeneficiario(
          UsuarioEntity usuario,
          PerfilPreInversionBeneficiarioEntity
              perfilPreInversionBeneficiarioEntity) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      String dataConyuge = '';

      if (perfilPreInversionBeneficiarioEntity.estadoCivilId != '2' &&
          perfilPreInversionBeneficiarioEntity.estadoCivilId != '5') {
        dataConyuge = '''
            <ConyugeTipoIdentificacionId>1</ConyugeTipoIdentificacionId>
            <ConyugeId>${perfilPreInversionBeneficiarioEntity.beneficiarioId}</ConyugeId>
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
            <ConyugeTipoIdentificacionId>${perfilPreInversionBeneficiarioEntity.conyugeTipoIdentificacionId}</ConyugeTipoIdentificacionId>
            <ConyugeId>${perfilPreInversionBeneficiarioEntity.conyugeId}</ConyugeId>
            <ConyugeNombre1>${perfilPreInversionBeneficiarioEntity.conyugeNombre1}</ConyugeNombre1>
            <ConyugeNombre2>${perfilPreInversionBeneficiarioEntity.conyugeNombre2}</ConyugeNombre2>
            <ConyugeApellido1>${perfilPreInversionBeneficiarioEntity.conyugeApellido1}</ConyugeApellido1>
            <ConyugeApellido2>${perfilPreInversionBeneficiarioEntity.conyugeApellido2}</ConyugeApellido2>
            <ConyugeGeneroId>${perfilPreInversionBeneficiarioEntity.conyugeGeneroId}</ConyugeGeneroId>
            <ConyugeFechaExpedicionDocumento>${perfilPreInversionBeneficiarioEntity.conyugeFechaExpedicionDocumento}</ConyugeFechaExpedicionDocumento>
            <ConyugeGrupoEspecialId>${perfilPreInversionBeneficiarioEntity.conyugeGrupoEspecialId}</ConyugeGrupoEspecialId>
            <ConyugeFechaNacimiento>${perfilPreInversionBeneficiarioEntity.conyugeFechaNacimiento}</ConyugeFechaNacimiento>
            <ConyugeIngresosMensuales>${perfilPreInversionBeneficiarioEntity.conyugeIngresosMensuales}</ConyugeIngresosMensuales>
      ''';
      }

      final perfilPreInversionBeneficiarioSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionBeneficiario xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionBeneficiarioEntity.perfilPreInversionId}</PerfilPreInversionId>
            <BeneficiarioId>${perfilPreInversionBeneficiarioEntity.beneficiarioId}</BeneficiarioId>
            <MunicipioId>${perfilPreInversionBeneficiarioEntity.municipioId}</MunicipioId>
            <VeredaId>${perfilPreInversionBeneficiarioEntity.veredaId}</VeredaId>
            <AreaFinca>${perfilPreInversionBeneficiarioEntity.areaFinca}</AreaFinca>
            <AreaProyecto>${perfilPreInversionBeneficiarioEntity.areaProyecto}</AreaProyecto>
            <TipoTenenciaId>${perfilPreInversionBeneficiarioEntity.tipoTenenciaId}</TipoTenenciaId>
            <Experiencia>${perfilPreInversionBeneficiarioEntity.experiencia}</Experiencia>
            <Asociado>${perfilPreInversionBeneficiarioEntity.asociado}</Asociado>
            <ConocePerfil>${perfilPreInversionBeneficiarioEntity.conocePerfil}</ConocePerfil>
            <FueBeneficiado>${perfilPreInversionBeneficiarioEntity.fueBeneficiado}</FueBeneficiado>
            <CualBeneficio>${perfilPreInversionBeneficiarioEntity.cualBeneficio}</CualBeneficio>
            <Activo>${perfilPreInversionBeneficiarioEntity.activo}</Activo>
            <MiembrosHogar>${perfilPreInversionBeneficiarioEntity.miembrosHogar}</MiembrosHogar>
            <MiembrosEcoActivos>${perfilPreInversionBeneficiarioEntity.miembrosEcoActivos}</MiembrosEcoActivos>
            <ResidenciaId>${perfilPreInversionBeneficiarioEntity.residenciaId}</ResidenciaId>
            <AccesoExplotacionTierra>${perfilPreInversionBeneficiarioEntity.accesoExplotacionTierra}</AccesoExplotacionTierra>
            <GastosMensuales>${perfilPreInversionBeneficiarioEntity.gastosMensuales}</GastosMensuales>
            <MesesAsociado>${perfilPreInversionBeneficiarioEntity.mesesAsociado}</MesesAsociado>
            <NombreOrganizacion>${perfilPreInversionBeneficiarioEntity.nombreOrganizacion}</NombreOrganizacion>
            <ActivoInmobiliario>${perfilPreInversionBeneficiarioEntity.activoInmobiliario}</ActivoInmobiliario>
            <ActivoFinanciero>${perfilPreInversionBeneficiarioEntity.activoFinanciero}</ActivoFinanciero>
            <ActivoProductivo>${perfilPreInversionBeneficiarioEntity.activoProductivo}</ActivoProductivo>
            <ActivoCorriente>${perfilPreInversionBeneficiarioEntity.activoCorriente}</ActivoCorriente>
            <Nota>${perfilPreInversionBeneficiarioEntity.nota}</Nota>
            <NombreFinca>${perfilPreInversionBeneficiarioEntity.nombreFinca}</NombreFinca>
            <NivelEscolarId>${perfilPreInversionBeneficiarioEntity.nivelEscolarId}</NivelEscolarId>
            <CotizanteBEPS>${perfilPreInversionBeneficiarioEntity.cotizanteBeps}</CotizanteBEPS>
            <EstadoCivilId>${perfilPreInversionBeneficiarioEntity.estadoCivilId}</EstadoCivilId>
            <CalificacionSISBEN>${perfilPreInversionBeneficiarioEntity.calificacionSisben}</CalificacionSISBEN>
            <IngresosMensuales>${perfilPreInversionBeneficiarioEntity.ingresosMensuales}</IngresosMensuales>
            <TipoDiscapacidadId>${perfilPreInversionBeneficiarioEntity.tipoDiscapacidadId}</TipoDiscapacidadId>
            <ActividadEconomicaId>${perfilPreInversionBeneficiarioEntity.actividadEconomicaId}</ActividadEconomicaId>
            <IngresosDiarios>${perfilPreInversionBeneficiarioEntity.ingresosDiarios}</IngresosDiarios>
            <DiasTrabajo>${perfilPreInversionBeneficiarioEntity.diasTrabajo}</DiasTrabajo>
            <Longitud>${perfilPreInversionBeneficiarioEntity.longitud}</Longitud>
            <Latitud>${perfilPreInversionBeneficiarioEntity.latitud}</Latitud>
            <CedulaCatastral>${perfilPreInversionBeneficiarioEntity.cedulaCatastral}</CedulaCatastral>
            <BeneficioId>${perfilPreInversionBeneficiarioEntity.beneficioId}</BeneficioId>
            $dataConyuge
          </objeto>
        </GuardarPerfilPreInversionBeneficiario>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilPreInversionBeneficiarioResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction":
                "${Constants.urlSOAP}/GuardarPerfilPreInversionBeneficiario"
          },
          body: perfilPreInversionBeneficiarioSOAP);

      if (perfilPreInversionBeneficiarioResp.statusCode == 200) {
        final perfilPreInversionBeneficiarioDoc =
            xml.XmlDocument.parse(perfilPreInversionBeneficiarioResp.body);

        final respuesta = perfilPreInversionBeneficiarioDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          return perfilPreInversionBeneficiarioEntity;
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
