import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/usuario_entity.dart';

import '../../core/error/failure.dart';
import '../../../domain/entities/experiencia_agricola_entity.dart';
import '../../constants.dart';
import '../../models/experiencia_agricola_model.dart';
import '../../utils.dart';

abstract class ExperienciaAgricolaRemoteDataSource {
  Future<List<ExperienciaAgricolaModel>> getExperienciasAgricolas(
      UsuarioEntity usuario);
  Future<List<ExperienciaAgricolaEntity>> saveExperienciasAgricolas(
      UsuarioEntity usuario,
      List<ExperienciaAgricolaEntity> experienciasAgricolasEntity);
}

class ExperienciaAgricolaRemoteDataSourceImpl
    implements ExperienciaAgricolaRemoteDataSource {
  final http.Client client;

  ExperienciaAgricolaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ExperienciaAgricolaModel>> getExperienciasAgricolas(
      UsuarioEntity usuario) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final experienciaAgricolaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaExperienciasAgricolas</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

      final experienciaAgricolaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
          },
          body: experienciaAgricolaSOAP);

      if (experienciaAgricolaResp.statusCode != 200) {
        throw const ServerFailure(
            ['Error al obtener las experiencias agricolas']);
      }

      final experienciaAgricolaDoc =
          xml.XmlDocument.parse(experienciaAgricolaResp.body);

      final respuesta = experienciaAgricolaDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        if (experienciaAgricolaDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }

        final xmlString = experienciaAgricolaDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final experienciasAgricolasRaw =
            decodedResp.entries.first.value['Table'];

        if (experienciasAgricolasRaw is List) {
          return List.from(experienciasAgricolasRaw)
              .map((e) => ExperienciaAgricolaModel.fromJson(e))
              .toList();
        } else {
          return [ExperienciaAgricolaModel.fromJson(experienciasAgricolasRaw)];
        }
      } else {
        throw const ServerFailure(
            ['Error al obtener las experiencias agricolas']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<List<ExperienciaAgricolaEntity>> saveExperienciasAgricolas(
      UsuarioEntity usuario,
      List<ExperienciaAgricolaEntity> experienciasAgricolasEntity) async {
    List<ExperienciaAgricolaEntity> experienciasAgricolasUpload = [];
    for (var experienciaAgricola in experienciasAgricolasEntity) {
      final resp = await saveExperienciaAgricola(usuario, experienciaAgricola);
      if (resp != null) {
        experienciasAgricolasUpload.add(resp);
      }
    }
    return experienciasAgricolasUpload;
  }

  Future<ExperienciaAgricolaEntity?> saveExperienciaAgricola(
      UsuarioEntity usuario,
      ExperienciaAgricolaEntity experienciaAgricolaEntity) async {
    try {
      String url = await Constants.getAppUrl();
      final uri = Uri.parse(url);

      final experienciaAgricolaSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarExperienciaAgricola xmlns="http://alianzasproductivas.minagricultura.gov.co/">
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
            <TipoActividadProductivaId>${experienciaAgricolaEntity.tipoActividadProductivaId}</TipoActividadProductivaId>
            <BeneficiarioId>${experienciaAgricolaEntity.beneficiarioId}</BeneficiarioId>
            <FrecuenciaId>${experienciaAgricolaEntity.frecuenciaId}</FrecuenciaId>
            <AreaCultivo>${experienciaAgricolaEntity.areaCultivo}</AreaCultivo>
            <CantidadProducida>${experienciaAgricolaEntity.cantidadProducida}</CantidadProducida>
            <CantidadVendida>${experienciaAgricolaEntity.cantidadVendida}</CantidadVendida>
            <CantidadAutoconsumo>${experienciaAgricolaEntity.cantidadAutoconsumo}</CantidadAutoconsumo>
            <CostoImplementacion>${experienciaAgricolaEntity.costoImplementacion}</CostoImplementacion>
            <ValorJornal>${experienciaAgricolaEntity.valorJornal}</ValorJornal>
            <TotalIngresoNeto>${experienciaAgricolaEntity.totalIngresoNeto}</TotalIngresoNeto>
            <AreaPasto>${experienciaAgricolaEntity.areaPasto}</AreaPasto>
            <AreaSinUso>${experienciaAgricolaEntity.areaSinUso}</AreaSinUso>
            <AreaReservaConservacion>${experienciaAgricolaEntity.areaReservaConservacion}</AreaReservaConservacion>
            <AreaImplementacion>${experienciaAgricolaEntity.areaImplementacion}</AreaImplementacion>
            <TotalAreaPredio>${experienciaAgricolaEntity.totalAreaPredio}</TotalAreaPredio>
            
          </objeto>
        </GuardarExperienciaAgricola>
      </soap:Body>
    </soap:Envelope>
    ''';

      final experienciaAgricolaResp = await client.post(uri,
          headers: {
            "Content-Type": "text/xml; charset=utf-8",
            "SOAPAction": "${Constants.urlSOAP}/GuardarExperienciaAgricola"
          },
          body: experienciaAgricolaSOAP);

      if (experienciaAgricolaResp.statusCode != 200) {
        throw const ServerFailure(['Error al guardar la experiencia agricola']);
      }

      final experienciaAgricolaDoc =
          xml.XmlDocument.parse(experienciaAgricolaResp.body);

      final respuesta = experienciaAgricolaDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        return experienciaAgricolaEntity;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
