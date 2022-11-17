import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/perfil_beneficiario_entity.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';

import '../../../models/perfil_beneficiario_model.dart';
import '../../../utils.dart';

abstract class PerfilBeneficiarioRemoteDataSource {
  Future<List<PerfilBeneficiarioModel>> getPerfilBeneficiarios(
      UsuarioEntity usuario);
  Future<List<PerfilBeneficiarioEntity>> savePerfilesBeneficiarios(
      UsuarioEntity usuario,
      List<PerfilBeneficiarioEntity> perfilesBeneficiariossEntity);
}

class PerfilBeneficiarioRemoteDataSourceImpl
    implements PerfilBeneficiarioRemoteDataSource {
  final http.Client client;

  PerfilBeneficiarioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilBeneficiarioModel>> getPerfilBeneficiarios(
      UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilBeneficiarioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
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
            <string>TablaPerfilesBeneficiarios</string>              
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final perfilBeneficiarioResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilBeneficiarioSOAP);

    if (perfilBeneficiarioResp.statusCode == 200) {
      final perfilBeneficiarioDoc =
          xml.XmlDocument.parse(perfilBeneficiarioResp.body);

      final respuesta = perfilBeneficiarioDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true' &&
          perfilBeneficiarioDoc.findAllElements('NewDataSet').isNotEmpty) {
        final xmlString = perfilBeneficiarioDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilBeneficiariosRaw = decodedResp.entries.first.value['Table'];

        if (perfilBeneficiariosRaw is List) {
          return List.from(perfilBeneficiariosRaw)
              .map((e) => PerfilBeneficiarioModel.fromJson(e))
              .toList();
        } else {
          return [PerfilBeneficiarioModel.fromJson(perfilBeneficiariosRaw)];
        }
      } else {
        return [];
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PerfilBeneficiarioEntity>> savePerfilesBeneficiarios(
      UsuarioEntity usuario,
      List<PerfilBeneficiarioEntity> perfilesBeneficiariosEntity) async {
    List<PerfilBeneficiarioEntity> perfilesBeneficiariosUpload = [];
    for (var perfilBeneficiario in perfilesBeneficiariosEntity) {
      final resp = await savePerfilBeneficiario(usuario, perfilBeneficiario);
      if (resp != null) {
        perfilesBeneficiariosUpload.add(resp);
      }
    }
    return perfilesBeneficiariosUpload;
  }

  Future<PerfilBeneficiarioEntity?> savePerfilBeneficiario(
      UsuarioEntity usuario,
      PerfilBeneficiarioEntity perfilBeneficiarioEntity) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilBeneficiarioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <GuardarPerfilBeneficiario xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
          </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <PerfilId>${perfilBeneficiarioEntity.perfilId}</PerfilId>
            <BeneficiarioId>${perfilBeneficiarioEntity.beneficiarioId}</BeneficiarioId>
            <MunicipioId>${perfilBeneficiarioEntity.municipioId}</MunicipioId>
            <VeredaId>${perfilBeneficiarioEntity.veredaId}</VeredaId>
            <AreaFinca>${perfilBeneficiarioEntity.areaFinca}</AreaFinca>
            <AreaProyecto>${perfilBeneficiarioEntity.areaProyecto}</AreaProyecto>
            <TipoTenenciaId>${perfilBeneficiarioEntity.tipoTenenciaId}</TipoTenenciaId>
            <Experiencia>${perfilBeneficiarioEntity.experiencia}</Experiencia>
            <Asociado>${perfilBeneficiarioEntity.asociado}</Asociado>
            <ConocePerfil>${perfilBeneficiarioEntity.conocePerfil}</ConocePerfil>
            <FueBeneficiado>${perfilBeneficiarioEntity.fueBeneficiado}</FueBeneficiado>
            <CualBeneficio>${perfilBeneficiarioEntity.cualBeneficio}</CualBeneficio>
            <Activo>${perfilBeneficiarioEntity.activo}</Activo>
          </objeto>
        </GuardarPerfilBeneficiario>
      </soap:Body>
    </soap:Envelope>
    ''';

    final perfilBeneficiarioResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/GuardarPerfilBeneficiario"
        },
        body: perfilBeneficiarioSOAP);

    if (perfilBeneficiarioResp.statusCode == 200) {
      final perfilBeneficiarioDoc =
          xml.XmlDocument.parse(perfilBeneficiarioResp.body);

      final respuesta = perfilBeneficiarioDoc
          .findAllElements('respuesta')
          .map((e) => e.text)
          .first;

      if (respuesta == 'true') {
        return perfilBeneficiarioEntity;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
