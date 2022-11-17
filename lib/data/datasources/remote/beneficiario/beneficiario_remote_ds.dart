import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/beneficiario_entity.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/beneficiario_model.dart';
import '../../../utils.dart';

abstract class BeneficiarioRemoteDataSource {
  Future<List<BeneficiarioModel>> getBeneficiarios(UsuarioEntity usuario);
  Future<List<BeneficiarioEntity>> saveBeneficiarios(
      UsuarioEntity usuario, List<BeneficiarioEntity> beneficiariosEntity);
}

class BeneficiarioRemoteDataSourceImpl implements BeneficiarioRemoteDataSource {
  final http.Client client;

  BeneficiarioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BeneficiarioModel>> getBeneficiarios(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final beneficiarioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
          </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaBeneficiarios</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final beneficiarioResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: beneficiarioSOAP);

    if (beneficiarioResp.statusCode == 200) {
      final beneficiarioDoc = xml.XmlDocument.parse(beneficiarioResp.body);

      final respuesta =
          beneficiarioDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true' &&
          beneficiarioDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = beneficiarioDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final beneficiariosRaw = decodedResp.entries.first.value['Table'];

        if (beneficiariosRaw is List) {
          return List.from(beneficiariosRaw)
              .map((e) => BeneficiarioModel.fromJson(e))
              .toList();
        } else {
          return [BeneficiarioModel.fromJson(beneficiariosRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<BeneficiarioEntity>> saveBeneficiarios(UsuarioEntity usuario,
      List<BeneficiarioEntity> beneficiariosEntity) async {
    List<BeneficiarioEntity> beneficiariosUpload = [];
    for (var beneficiario in beneficiariosEntity) {
      final resp = await saveBeneficiario(usuario, beneficiario);
      if (resp != null) {
        beneficiariosUpload.add(resp);
      }
    }
    return beneficiariosUpload;
  }

  Future<BeneficiarioEntity?> saveBeneficiario(
      UsuarioEntity usuario, BeneficiarioEntity beneficiarioEntity) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final beneficiarioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarBeneficiario xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
          </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <Nombre1>${beneficiarioEntity.nombre1}</Nombre1>
            <Nombre2>${beneficiarioEntity.nombre2}</Nombre2>
            <Apellido1>${beneficiarioEntity.apellido1}</Apellido1>
            <Apellido2>${beneficiarioEntity.apellido2}</Apellido2>
            <GeneroId>${beneficiarioEntity.generoId}</GeneroId>
            <FechaNacimiento>${beneficiarioEntity.fechaNacimiento}</FechaNacimiento>
            <FechaExpedicionDocumento>${beneficiarioEntity.fechaExpedicionDocumento}</FechaExpedicionDocumento>
            <GrupoEspecialId>${beneficiarioEntity.grupoEspecialId}</GrupoEspecialId>
            <TelefonoMovil>${beneficiarioEntity.telefonoMovil}</TelefonoMovil>
            <Activo>${beneficiarioEntity.activo}</Activo>
            <TipoIdentificacionId>${beneficiarioEntity.tipoIdentificacionId}</TipoIdentificacionId>
            
          </objeto>
        </GuardarBeneficiario>
      </soap:Body>
    </soap:Envelope>
    ''';

    final beneficiarioResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/GuardarBeneficiario"
        },
        body: beneficiarioSOAP);

    if (beneficiarioResp.statusCode == 200) {
      final beneficiarioDoc = xml.XmlDocument.parse(beneficiarioResp.body);

      final respuesta =
          beneficiarioDoc.findAllElements('respuesta').map((e) => e.text).first;

      if (respuesta == 'true') {
        return beneficiarioEntity;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
