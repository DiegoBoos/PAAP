import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';

import '../../core/error/failure.dart';
import '../../../domain/entities/alianza_experiencia_pecuaria_entity.dart';
import '../../constants.dart';
import '../../models/alianza_experiencia_pecuaria_model.dart';
import '../../utils.dart';

abstract class AlianzaExperienciaPecuariaRemoteDataSource {
  Future<List<AlianzaExperienciaPecuariaModel>>
      getAlianzasExperienciasPecuarias(UsuarioEntity usuario);
  Future<List<AlianzaExperienciaPecuariaEntity>>
      saveAlianzasExperienciasPecuarias(
          UsuarioEntity usuario,
          List<AlianzaExperienciaPecuariaEntity>
              alianzasExperienciasPecuariasEntity);
}

class AlianzaExperienciaPecuariaRemoteDataSourceImpl
    implements AlianzaExperienciaPecuariaRemoteDataSource {
  final http.Client client;

  AlianzaExperienciaPecuariaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AlianzaExperienciaPecuariaModel>>
      getAlianzasExperienciasPecuarias(UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final alianzaExperienciaPecuariaSOAP =
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
            <string>TablaAlianzasExperienciasPecuarias</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final alianzaExperienciaPecuariaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: alianzaExperienciaPecuariaSOAP);

      if (alianzaExperienciaPecuariaResp.statusCode != 200) {
        throw const ServerFailure(['Error al obtener experiencias pecuarias']);
      }

      final alianzaExperienciaPecuariaDoc =
          xml.XmlDocument.parse(alianzaExperienciaPecuariaResp.body);

      final respuesta = alianzaExperienciaPecuariaDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        if (alianzaExperienciaPecuariaDoc
            .findAllElements('NewDataSet')
            .isEmpty) {
          return [];
        }

        final xmlString = alianzaExperienciaPecuariaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final alianzasExperienciasPecuariasRaw =
            decodedResp.entries.first.value['Table'];

        if (alianzasExperienciasPecuariasRaw is List) {
          return List.from(alianzasExperienciasPecuariasRaw)
              .map((e) => AlianzaExperienciaPecuariaModel.fromJson(e))
              .toList();
        } else {
          return [
            AlianzaExperienciaPecuariaModel.fromJson(
                alianzasExperienciasPecuariasRaw)
          ];
        }
      } else {
        throw const ServerFailure(
            ['Error al obtener experiencias pecuarias de la alianza']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<List<AlianzaExperienciaPecuariaEntity>>
      saveAlianzasExperienciasPecuarias(
          UsuarioEntity usuario,
          List<AlianzaExperienciaPecuariaEntity>
              alianzasExperienciasPecuariasEntity) async {
    List<AlianzaExperienciaPecuariaEntity> alianzasExperienciasPecuariasUpload =
        [];
    for (var alianzaExperienciaPecuaria
        in alianzasExperienciasPecuariasEntity) {
      final resp = await saveAlianzaExperienciaPecuaria(
          usuario, alianzaExperienciaPecuaria);
      if (resp != null) {
        alianzasExperienciasPecuariasUpload.add(resp);
      }
    }
    return alianzasExperienciasPecuariasUpload;
  }

  Future<AlianzaExperienciaPecuariaEntity?> saveAlianzaExperienciaPecuaria(
      UsuarioEntity usuario,
      AlianzaExperienciaPecuariaEntity alianzaExperienciaPecuariaEntity) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final alianzaExperienciaPecuariaSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarAlianzaExperienciaPecuaria xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <TipoActividadProductivaId>${alianzaExperienciaPecuariaEntity.tipoActividadProductivaId}</TipoActividadProductivaId>
            <BeneficiarioId>${alianzaExperienciaPecuariaEntity.beneficiarioId}</BeneficiarioId>
            <FrecuenciaId>${alianzaExperienciaPecuariaEntity.frecuenciaId}</FrecuenciaId>
            <CantidadAnimales>${alianzaExperienciaPecuariaEntity.cantidadAnimales}</CantidadAnimales>
            <CantidadCria>${alianzaExperienciaPecuariaEntity.cantidadCria}</CantidadCria>
            <CantidadLevante>${alianzaExperienciaPecuariaEntity.cantidadLevante}</CantidadLevante>
            <CantidadCeba>${alianzaExperienciaPecuariaEntity.cantidadCeba}</CantidadCeba>
            <CantidadLeche>${alianzaExperienciaPecuariaEntity.cantidadLeche}</CantidadLeche>
            <ValorJornal>${alianzaExperienciaPecuariaEntity.valorJornal}</ValorJornal>
            <CostosInsumos>${alianzaExperienciaPecuariaEntity.costosInsumos}</CostosInsumos>
            <Ingresos>${alianzaExperienciaPecuariaEntity.ingresos}</Ingresos>
          </objeto>
        </GuardarAlianzaExperienciaPecuaria>
      </soap:Body>
    </soap:Envelope>
    ''';

      final alianzaExperienciaPecuariaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction":
                "${Constants.urlSOAP}/GuardarAlianzaExperienciaPecuaria"
          },
          body: alianzaExperienciaPecuariaSOAP);

      if (alianzaExperienciaPecuariaResp.statusCode != 200) {
        throw const ServerFailure(
            ['Error al guardar la alianza experiencia pecuaria']);
      }

      final alianzaExperienciaPecuariaDoc =
          xml.XmlDocument.parse(alianzaExperienciaPecuariaResp.body);

      final respuesta = alianzaExperienciaPecuariaDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        return alianzaExperienciaPecuariaEntity;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
