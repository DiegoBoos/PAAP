import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/perfil_preinversion_consultor_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../constants.dart';
import '../../../domain/core/error/exception.dart';
import '../../models/perfil_preinversion_consultor_model.dart';
import '../../models/perfiles_preinversion_model.dart';
import '../../utils.dart';

abstract class PerfilPreInversionConsultorRemoteDataSource {
  Future<List<PerfilPreInversionConsultorModel>>
      getPerfilPreInversionConsultores(UsuarioEntity usuario);
  Future<List<PerfilPreInversionConsultorEntity>>
      savePerfilesPreInversionesConsultores(
          UsuarioEntity usuario,
          List<PerfilPreInversionConsultorEntity>
              perfilesPreInversionesConsultoresEntity);
}

class PerfilPreInversionConsultorRemoteDataSourceImpl
    implements PerfilPreInversionConsultorRemoteDataSource {
  final http.Client client;

  PerfilPreInversionConsultorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilPreInversionConsultorModel>>
      getPerfilPreInversionConsultores(UsuarioEntity usuario) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final perfilesPreInversionSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <RolId>400</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaPerfilesPreInversiones</string> 
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilesPreInversionResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: perfilesPreInversionSOAP);

      if (perfilesPreInversionResp.statusCode == 200) {
        final perfilesPreInversionDoc =
            xml.XmlDocument.parse(perfilesPreInversionResp.body);

        final respuesta = perfilesPreInversionDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        final mensaje = perfilesPreInversionDoc
            .findAllElements('mensaje')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          final xmlString = perfilesPreInversionDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final perfilesPreInversionRaw =
              decodedResp.entries.first.value['Table'];

          List<PerfilPreInversionConsultorModel>
              listPerfilPreInversionConsultor = [];
          if (perfilesPreInversionRaw is List) {
            final perfilesPreInversion = List.from(perfilesPreInversionRaw)
                .map((e) => PerfilesPreInversionModel.fromJson(e))
                .toList();
            for (var perfilPreInversion in perfilesPreInversion) {
              final dsPerfilPreInversionConsultor =
                  await getPerfilPreInversionConsultorTable(
                      usuario, perfilPreInversion.id);
              if (dsPerfilPreInversionConsultor.isNotEmpty) {
                for (var perfilPreInversionConsultor
                    in dsPerfilPreInversionConsultor) {
                  listPerfilPreInversionConsultor
                      .add(perfilPreInversionConsultor);
                }
              }
            }
          } else {
            listPerfilPreInversionConsultor.add(
                PerfilPreInversionConsultorModel.fromJson(
                    perfilesPreInversionRaw));
          }

          return listPerfilPreInversionConsultor;
        } else {
          throw ServerFailure([mensaje]);
        }
      } else {
        throw ServerException();
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<List<PerfilPreInversionConsultorModel>>
      getPerfilPreInversionConsultorTable(
          UsuarioEntity usuario, String perfilPreInversionId) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final perfilPreInversionConsultoresSOAP =
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
            <string>TablaPerfilesPreInversionesConsultores</string>      
            <string>$perfilPreInversionId</string>
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final perfilPreInversionConsultorResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: perfilPreInversionConsultoresSOAP);

      if (perfilPreInversionConsultorResp.statusCode == 200) {
        final perfilPreInversionConsultorDoc =
            xml.XmlDocument.parse(perfilPreInversionConsultorResp.body);

        final respuesta = perfilPreInversionConsultorDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            perfilPreInversionConsultorDoc
                .findAllElements('NewDataSet')
                .isNotEmpty) {
          final xmlString = perfilPreInversionConsultorDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final perfilPreInversionConsultoresRaw =
              decodedResp.entries.first.value['Table'];

          if (perfilPreInversionConsultoresRaw is List) {
            return List.from(perfilPreInversionConsultoresRaw)
                .map((e) => PerfilPreInversionConsultorModel.fromJson(e))
                .toList();
          } else {
            return [
              PerfilPreInversionConsultorModel.fromJson(
                  perfilPreInversionConsultoresRaw)
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
  Future<List<PerfilPreInversionConsultorEntity>>
      savePerfilesPreInversionesConsultores(
          UsuarioEntity usuario,
          List<PerfilPreInversionConsultorEntity>
              perfilesPreInversionesConsultoresEntity) async {
    List<PerfilPreInversionConsultorEntity>
        perfilesPreInversionesConsultoresUpload = [];
    for (var perfilPreInversionConsultor
        in perfilesPreInversionesConsultoresEntity) {
      if (perfilPreInversionConsultor.recordStatus == 'D') {
        final resp = await deletePerfilPreInversionConsultor(
            usuario, perfilPreInversionConsultor);
        if (resp != null) {
          perfilesPreInversionesConsultoresUpload.add(resp);
        }
      } else {
        final resp = await savePerfilPreInversionConsultor(
            usuario, perfilPreInversionConsultor);
        if (resp != null) {
          perfilesPreInversionesConsultoresUpload.add(resp);
        }
      }
    }
    return perfilesPreInversionesConsultoresUpload;
  }

  Future<PerfilPreInversionConsultorEntity?> savePerfilPreInversionConsultor(
      UsuarioEntity usuario,
      PerfilPreInversionConsultorEntity
          perfilPreInversionConsultorEntity) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final perfilPreInversionConsultorSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilPreInversionConsultor xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionConsultorEntity.perfilPreInversionId}</PerfilPreInversionId>
            <ConsultorId>${perfilPreInversionConsultorEntity.consultorId}</ConsultorId>
            <RevisionId>${perfilPreInversionConsultorEntity.revisionId}</RevisionId>
            <FechaRevision>${perfilPreInversionConsultorEntity.fechaRevision}</FechaRevision>
            
          </objeto>
        </GuardarPerfilPreInversionConsultor>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilPreInversionConsultorResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction":
                "${Constants.urlSOAP}/GuardarPerfilPreInversionConsultor"
          },
          body: perfilPreInversionConsultorSOAP);

      if (perfilPreInversionConsultorResp.statusCode == 200) {
        final perfilPreInversionConsultorDoc =
            xml.XmlDocument.parse(perfilPreInversionConsultorResp.body);

        final respuesta = perfilPreInversionConsultorDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          return perfilPreInversionConsultorEntity;
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

  Future<PerfilPreInversionConsultorEntity?> deletePerfilPreInversionConsultor(
      UsuarioEntity usuario,
      PerfilPreInversionConsultorEntity
          perfilPreInversionConsultorEntity) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final perfilPreInversionConsultorSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <BorrarPerfilPreInversionConsultor xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <PerfilPreInversionId>${perfilPreInversionConsultorEntity.perfilPreInversionId}</PerfilPreInversionId>
            <ConsultorId>${perfilPreInversionConsultorEntity.consultorId}</ConsultorId>
            <RevisionId>${perfilPreInversionConsultorEntity.revisionId}</RevisionId>            
          </objeto>
        </BorrarPerfilPreInversionConsultor>
      </soap:Body>
    </soap:Envelope>
    ''';

      final perfilPreInversionConsultorResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction":
                "${Constants.urlSOAP}/BorrarPerfilPreInversionConsultor"
          },
          body: perfilPreInversionConsultorSOAP);

      if (perfilPreInversionConsultorResp.statusCode == 200) {
        final perfilPreInversionConsultorDoc =
            xml.XmlDocument.parse(perfilPreInversionConsultorResp.body);

        final respuesta = perfilPreInversionConsultorDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          return perfilPreInversionConsultorEntity;
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
