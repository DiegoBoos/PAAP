import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../domain/entities/experiencia_pecuaria_entity.dart';
import '../../constants.dart';
import '../../models/experiencia_pecuaria_model.dart';
import '../../utils.dart';

abstract class ExperienciaPecuariaRemoteDataSource {
  Future<List<ExperienciaPecuariaModel>> getExperienciasPecuarias(
      UsuarioEntity usuario);
  Future<List<ExperienciaPecuariaEntity>> saveExperienciasPecuarias(
      UsuarioEntity usuario,
      List<ExperienciaPecuariaEntity> experienciasPecuariasEntity);
}

class ExperienciaPecuariaRemoteDataSourceImpl
    implements ExperienciaPecuariaRemoteDataSource {
  final http.Client client;

  ExperienciaPecuariaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ExperienciaPecuariaModel>> getExperienciasPecuarias(
      UsuarioEntity usuario) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final experienciaPecuariaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaExperienciasPecuarias</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final experienciaPecuariaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: experienciaPecuariaSOAP);

      if (experienciaPecuariaResp.statusCode == 200) {
        final experienciaPecuariaDoc =
            xml.XmlDocument.parse(experienciaPecuariaResp.body);

        final respuesta = experienciaPecuariaDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            experienciaPecuariaDoc.findAllElements('NewDataSet').isNotEmpty) {
          final xmlString = experienciaPecuariaDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final experienciasPecuariasRaw =
              decodedResp.entries.first.value['Table'];

          if (experienciasPecuariasRaw is List) {
            return List.from(experienciasPecuariasRaw)
                .map((e) => ExperienciaPecuariaModel.fromJson(e))
                .toList();
          } else {
            return [
              ExperienciaPecuariaModel.fromJson(experienciasPecuariasRaw)
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
  Future<List<ExperienciaPecuariaEntity>> saveExperienciasPecuarias(
      UsuarioEntity usuario,
      List<ExperienciaPecuariaEntity> experienciasPecuariasEntity) async {
    List<ExperienciaPecuariaEntity> experienciasPecuariasUpload = [];
    for (var experienciaPecuaria in experienciasPecuariasEntity) {
      final resp = await saveExperienciaPecuaria(usuario, experienciaPecuaria);
      if (resp != null) {
        experienciasPecuariasUpload.add(resp);
      }
    }
    return experienciasPecuariasUpload;
  }

  Future<ExperienciaPecuariaEntity?> saveExperienciaPecuaria(
      UsuarioEntity usuario,
      ExperienciaPecuariaEntity experienciaPecuariaEntity) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final experienciaPecuariaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarExperienciaPecuaria xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <TipoActividadProductivaId>${experienciaPecuariaEntity.tipoActividadProductivaId}</TipoActividadProductivaId>
            <BeneficiarioId>${experienciaPecuariaEntity.beneficiarioId}</BeneficiarioId>
            <FrecuenciaId>${experienciaPecuariaEntity.frecuenciaId}</FrecuenciaId>
            <CantidadAnimales>${experienciaPecuariaEntity.cantidadAnimales}</CantidadAnimales>
            <CantidadCria>${experienciaPecuariaEntity.cantidadCria}</CantidadCria>
            <CantidadLevante>${experienciaPecuariaEntity.cantidadLevante}</CantidadLevante>
            <CantidadCeba>${experienciaPecuariaEntity.cantidadCeba}</CantidadCeba>
            <CantidadLeche>${experienciaPecuariaEntity.cantidadLeche}</CantidadLeche>
            <ValorJornal>${experienciaPecuariaEntity.valorJornal}</ValorJornal>
            <CostosInsumos>${experienciaPecuariaEntity.costosInsumos}</CostosInsumos>
            <Ingresos>${experienciaPecuariaEntity.ingresos}</Ingresos>
          </objeto>
        </GuardarExperienciaPecuaria>
      </soap:Body>
    </soap:Envelope>
    ''';

      final experienciaPecuariaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/GuardarExperienciaPecuaria"
          },
          body: experienciaPecuariaSOAP);

      if (experienciaPecuariaResp.statusCode == 200) {
        final experienciaPecuariaDoc =
            xml.XmlDocument.parse(experienciaPecuariaResp.body);

        final respuesta = experienciaPecuariaDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          return experienciaPecuariaEntity;
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
