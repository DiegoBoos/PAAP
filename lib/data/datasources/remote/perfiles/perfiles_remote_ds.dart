import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paap/data/models/v_perfil_model.dart';
import 'package:paap/domain/entities/usuario_entity.dart';
import 'package:xml/xml.dart' as xml;

import '../../../../domain/entities/vperfil_entity.dart';
import '../../../constants.dart';
import '../../../../domain/core/error/exception.dart';
import 'package:paap/domain/core/error/failure.dart';
import '../../../models/municipio_model.dart';
import '../../../models/perfil_model.dart';
import '../../../models/perfiles_model.dart';
import '../../../models/producto_model.dart';
import '../../../models/tipo_proyecto_model.dart';
import '../../../utils.dart';

abstract class PerfilesRemoteDataSource {
  Future<List<PerfilesModel>> getPerfiles(UsuarioEntity usuario);
  Future<List<PerfilesModel>> getPerfilesFiltros(
      UsuarioEntity usuario, String id, String nombre);

  Future<VPerfilModel> getPerfil(UsuarioEntity usuario, String perfilId);
}

class PerfilesRemoteDataSourceImpl implements PerfilesRemoteDataSource {
  final http.Client client;

  PerfilesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PerfilesModel>> getPerfiles(UsuarioEntity usuario) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilesSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
          </usuario>
          <rol>
            <RolId>400</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaPerfiles</string> 
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final perfilesResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilesSOAP);

    if (perfilesResp.statusCode == 200) {
      final perfilesDoc = xml.XmlDocument.parse(perfilesResp.body);

      final respuesta =
          perfilesDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          perfilesDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = perfilesDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilesRaw = decodedResp.entries.first.value['Table'];

        final perfiles = List.from(perfilesRaw)
            .map((e) => PerfilesModel.fromJson(e))
            .toList();

        return perfiles;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PerfilesModel>> getPerfilesFiltros(
      UsuarioEntity usuario, String? id, String? nombre) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilesSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ObtenerDatos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
          </usuario>
          <rol>
            <RolId>400</RolId>
            <Nombre>string</Nombre>
          </rol>
          <parametros>
            <string>TablaPerfilFiltros</string>        
            <string>$nombre</string>        
            <string>$id</string>        
          </parametros>
        </ObtenerDatos>
      </soap:Body>
    </soap:Envelope>''';

    final perfilesResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ObtenerDatos"
        },
        body: perfilesSOAP);

    if (perfilesResp.statusCode == 200) {
      final perfilesDoc = xml.XmlDocument.parse(perfilesResp.body);

      final respuesta =
          perfilesDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          perfilesDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        if (perfilesDoc.findAllElements('NewDataSet').isEmpty) {
          return [];
        }
        final xmlString = perfilesDoc
            .findAllElements('NewDataSet')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final Map<String, dynamic> decodedResp = json.decode(res);

        final perfilesRaw = decodedResp.entries.first.value['Table'];

        if (perfilesRaw is List) {
          final perfiles = List.from(perfilesRaw)
              .map((e) => PerfilesModel.fromJson(e))
              .toList();

          return perfiles;
        } else {
          return [PerfilesModel.fromJson(perfilesRaw)];
        }
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<VPerfilModel> getPerfil(UsuarioEntity usuario, String perfilId) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final perfilesSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarPerfil xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
            </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <PerfilId>$perfilId</PerfilId>
          </objeto>
        </ConsultarPerfil>
      </soap:Body>
    </soap:Envelope>''';

    final perfilResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ConsultarPerfil"
        },
        body: perfilesSOAP);

    if (perfilResp.statusCode == 200) {
      final perfilDoc = xml.XmlDocument.parse(perfilResp.body);

      final respuesta =
          perfilDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          perfilDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = perfilDoc
            .findAllElements('objeto')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final decodedResp = json.decode(res);

        final perfil = PerfilModel.fromJson(decodedResp['objeto']);

        final tipoProyecto =
            await getTipoProyecto(usuario, perfil.tipoProyectoId);

        final productoPrincipal = await getProducto(usuario, perfil.productoId);

        final productoAsociado =
            await getProducto(usuario, perfil.productoAsociadoId);

        final municipio = await getMunicipio(usuario, perfil.municipioId);

        /* final VPerfilModel vPerfil = VPerfilModel(
            perfilId: perfil.perfilId,
            convocatoriaId: perfil.convocatoriaId,
            nombre: perfil.nombre,
            abreviatura: perfil.abreviatura,
            municipio: municipio.nombre,
            direccion: perfil.direccion,
            contacto: perfil.contacto,
            telefonoFijo: perfil.telefonoFijo,
            telefonoMovil: perfil.telefonoMovil,
            correo: perfil.correo,
            tipoProyecto: tipoProyecto.nombre,
            productoPrincipal: productoPrincipal.nombre,
            productoAsociado: productoAsociado.nombre,
            valorTotalProyecto: perfil.valorTotalProyecto,
            incentivoModular: perfil.incentivoModular);
 */
        final vPerfil = VPerfilModel.fromJson({
          "perfilId": perfil.perfilId,
          "convocatoriaId": perfil.convocatoriaId,
          "nombre": perfil.nombre,
          "abreviatura": perfil.abreviatura,
          "municipio": municipio.nombre,
          "departamento": municipio.departamentoid,
          "direccion": perfil.direccion,
          "contacto": perfil.contacto,
          "telefonoFijo": perfil.telefonoFijo,
          "telefonoMovil": perfil.telefonoMovil,
          "correo": perfil.correo,
          "tipoProyecto": tipoProyecto.nombre,
          "productoPrincipal": productoPrincipal.nombre,
          "productoAsociado": productoAsociado.nombre,
          "valorTotalProyecto": perfil.valorTotalProyecto,
          "incentivoModular": perfil.incentivoModular
        });

        return vPerfil;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  Future<TipoProyectoModel> getTipoProyecto(
      UsuarioEntity usuario, String tipoProyectoId) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final tipoProyectoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarTipoProyecto xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
            </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <TipoProyectoId>$tipoProyectoId</TipoProyectoId>
          </objeto>
        </ConsultarTipoProyecto>
      </soap:Body>
    </soap:Envelope>''';

    final tipoProyectoResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ConsultarTipoProyecto"
        },
        body: tipoProyectoSOAP);

    if (tipoProyectoResp.statusCode == 200) {
      final tipoProyectoDoc = xml.XmlDocument.parse(tipoProyectoResp.body);

      final respuesta =
          tipoProyectoDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          tipoProyectoDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = tipoProyectoDoc
            .findAllElements('objeto')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final decodedResp = json.decode(res);

        final tipoProyecto = TipoProyectoModel.fromJson(decodedResp['objeto']);

        return tipoProyecto;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  Future<ProductoModel> getProducto(
      UsuarioEntity usuario, String productoId) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final productoSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarProductos xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
            </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <ProductoId>$productoId</ProductoId>
          </objeto>
        </ConsultarProductos>
      </soap:Body>
    </soap:Envelope>''';

    final productoResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ConsultarProductos"
        },
        body: productoSOAP);

    if (productoResp.statusCode == 200) {
      final productoDoc = xml.XmlDocument.parse(productoResp.body);

      final respuesta =
          productoDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          productoDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = productoDoc
            .findAllElements('objeto')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final decodedResp = json.decode(res);

        final producto = ProductoModel.fromJson(decodedResp['objeto']);

        return producto;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }

  Future<MunicipioModel> getMunicipio(
      UsuarioEntity usuario, String municipioId) async {
    final uri = Uri.parse(
        '${Constants.paapServicioWebSoapBaseUrl}/PaapServicios/PAAPServicioWeb.asmx');

    final municipioSOAP = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <ConsultarMunicipio xmlns="http://alianzasproductivas.minagricultura.gov.co/">
          <usuario>
            <UsuarioId>${usuario.usuarioId}</UsuarioId>
            <Contrasena>${usuario.contrasena}</Contrasena>
            </usuario>
          <rol>
            <RolId>100</RolId>
            <Nombre>string</Nombre>
          </rol>
          <objeto>
            <MunicipioId>$municipioId</MunicipioId>
          </objeto>
        </ConsultarMunicipio>
      </soap:Body>
    </soap:Envelope>''';

    final municipioResp = await client.post(uri,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "${Constants.urlSOAP}/ConsultarMunicipio"
        },
        body: municipioSOAP);

    if (municipioResp.statusCode == 200) {
      final municipioDoc = xml.XmlDocument.parse(municipioResp.body);

      final respuesta =
          municipioDoc.findAllElements('respuesta').map((e) => e.text).first;

      final mensaje =
          municipioDoc.findAllElements('mensaje').map((e) => e.text).first;

      if (respuesta == 'true') {
        final xmlString = municipioDoc
            .findAllElements('objeto')
            .map((xmlElement) => xmlElement.toXmlString())
            .first;

        String res = Utils.convertXmlToJson(xmlString);

        final decodedResp = json.decode(res);

        final municipio = MunicipioModel.fromJson(decodedResp['objeto']);

        return municipio;
      } else {
        throw ServerFailure([mensaje]);
      }
    } else {
      throw ServerException();
    }
  }
}
