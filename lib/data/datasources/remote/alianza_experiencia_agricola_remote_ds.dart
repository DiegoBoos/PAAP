import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../domain/entities/alianza_experiencia_agricola_entity.dart';
import '../../constants.dart';
import '../../models/alianza_experiencia_agricola_model.dart';
import '../../utils.dart';

abstract class AlianzaExperienciaAgricolaRemoteDataSource {
  Future<List<AlianzaExperienciaAgricolaModel>>
      getAlianzasExperienciasAgricolas(UsuarioEntity usuario);
  Future<List<AlianzaExperienciaAgricolaEntity>>
      saveAlianzasExperienciasAgricolas(
          UsuarioEntity usuario,
          List<AlianzaExperienciaAgricolaEntity>
              alianzasExperienciasAgricolasEntity);
}

class AlianzaExperienciaAgricolaRemoteDataSourceImpl
    implements AlianzaExperienciaAgricolaRemoteDataSource {
  final http.Client client;

  AlianzaExperienciaAgricolaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AlianzaExperienciaAgricolaModel>>
      getAlianzasExperienciasAgricolas(UsuarioEntity usuario) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final alianzaExperienciaAgricolaSOAP =
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
            <string>TablaAlianzasExperienciasAgricolas</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final alianzaExperienciaAgricolaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: alianzaExperienciaAgricolaSOAP);

      if (alianzaExperienciaAgricolaResp.statusCode == 200) {
        final alianzaExperienciaAgricolaDoc =
            xml.XmlDocument.parse(alianzaExperienciaAgricolaResp.body);

        final respuesta = alianzaExperienciaAgricolaDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true' &&
            alianzaExperienciaAgricolaDoc
                .findAllElements('NewDataSet')
                .isNotEmpty) {
          final xmlString = alianzaExperienciaAgricolaDoc
              .findAllElements('NewDataSet')
              .map((xmlElement) => xmlElement.toXmlString())
              .first;

          String res = Utils.convertXmlToJson(xmlString);

          final Map<String, dynamic> decodedResp = json.decode(res);

          final alianzasExperienciasAgricolasRaw =
              decodedResp.entries.first.value['Table'];

          if (alianzasExperienciasAgricolasRaw is List) {
            return List.from(alianzasExperienciasAgricolasRaw)
                .map((e) => AlianzaExperienciaAgricolaModel.fromJson(e))
                .toList();
          } else {
            return [
              AlianzaExperienciaAgricolaModel.fromJson(
                  alianzasExperienciasAgricolasRaw)
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
  Future<List<AlianzaExperienciaAgricolaEntity>>
      saveAlianzasExperienciasAgricolas(
          UsuarioEntity usuario,
          List<AlianzaExperienciaAgricolaEntity>
              alianzasExperienciasAgricolasEntity) async {
    List<AlianzaExperienciaAgricolaEntity> alianzasExperienciasAgricolasUpload =
        [];
    for (var alianzaExperienciaAgricola
        in alianzasExperienciasAgricolasEntity) {
      final resp = await saveAlianzaExperienciaAgricola(
          usuario, alianzaExperienciaAgricola);
      if (resp != null) {
        alianzasExperienciasAgricolasUpload.add(resp);
      }
    }
    return alianzasExperienciasAgricolasUpload;
  }

  Future<AlianzaExperienciaAgricolaEntity?> saveAlianzaExperienciaAgricola(
      UsuarioEntity usuario,
      AlianzaExperienciaAgricolaEntity alianzaExperienciaAgricolaEntity) async {
    try {
      final uri = Uri.parse(
          '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

      final alianzaExperienciaAgricolaSOAP =
          '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarAlianzaExperienciaAgricola xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <TipoActividadProductivaId>${alianzaExperienciaAgricolaEntity.tipoActividadProductivaId}</TipoActividadProductivaId>
            <BeneficiarioId>${alianzaExperienciaAgricolaEntity.beneficiarioId}</BeneficiarioId>
            <FrecuenciaId>${alianzaExperienciaAgricolaEntity.frecuenciaId}</FrecuenciaId>
            <AreaCultivo>${alianzaExperienciaAgricolaEntity.areaCultivo}</AreaCultivo>
            <CantidadProducida>${alianzaExperienciaAgricolaEntity.cantidadProducida}</CantidadProducida>
            <CantidadVendida>${alianzaExperienciaAgricolaEntity.cantidadVendida}</CantidadVendida>
            <CantidadAutoconsumo>${alianzaExperienciaAgricolaEntity.cantidadAutoconsumo}</CantidadAutoconsumo>
            <CostoImplementacion>${alianzaExperienciaAgricolaEntity.costoImplementacion}</CostoImplementacion>
            <ValorJornal>${alianzaExperienciaAgricolaEntity.valorJornal}</ValorJornal>
            <TotalIngresoNeto>${alianzaExperienciaAgricolaEntity.totalIngresoNeto}</TotalIngresoNeto>
            <AreaPasto>${alianzaExperienciaAgricolaEntity.areaPasto}</AreaPasto>
            <AreaSinUso>${alianzaExperienciaAgricolaEntity.areaSinUso}</AreaSinUso>
            <AreaReservaConservacion>${alianzaExperienciaAgricolaEntity.areaReservaConservacion}</AreaReservaConservacion>
            <AreaImplementacion>${alianzaExperienciaAgricolaEntity.areaImplementacion}</AreaImplementacion>
            <TotalAreaPredio>${alianzaExperienciaAgricolaEntity.totalAreaPredio}</TotalAreaPredio>
          </objeto>
        </GuardarAlianzaExperienciaAgricola>
      </soap:Body>
    </soap:Envelope>
    ''';

      final alianzaExperienciaAgricolaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction":
                "${Constants.urlSOAP}/GuardarAlianzaExperienciaAgricola"
          },
          body: alianzaExperienciaAgricolaSOAP);

      if (alianzaExperienciaAgricolaResp.statusCode == 200) {
        final alianzaExperienciaAgricolaDoc =
            xml.XmlDocument.parse(alianzaExperienciaAgricolaResp.body);

        final respuesta = alianzaExperienciaAgricolaDoc
            .findAllElements('respuesta')
            .map((e) => e.text)
            .first;

        if (respuesta == 'true') {
          return alianzaExperienciaAgricolaEntity;
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
